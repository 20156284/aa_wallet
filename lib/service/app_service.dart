// ===============================================
// app_service
//
// Create by will on 2021/11/10 10:29
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:aa_wallet/api/sys/sys_api.dart';
import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/entity/sys/version_entity.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/preference/app_preferences.dart';
import 'package:aa_wallet/preference/app_user_preferences.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:app_upgrade/app_upgrade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:web3dart/credentials.dart';

class AppService extends GetxService {
  AppService(this.context);

  final BuildContext context;

  static AppService get to => Get.find();

  final app = AppPreferences().obs;
  final langList = <LanguageInfo>[].obs;
  final haveBackUpMnemonic = false.obs;

  @override
  void onInit() async {
    super.onInit();

    _onLoadLanguage();
    onReadConfig();

    //监听 app 设置的 的变化
    ever(app, handleAppChanged);
  }

  /**
   * 加载语言
   * @author Will
   * @date 2021/11/16 14:52
   */
  void _onLoadLanguage() async {
    final String data =
        await DefaultAssetBundle.of(context).loadString(Res.language);
    final List<dynamic> languageList = json.decode(data) as List<dynamic>;
    final List<LanguageInfo> list = <LanguageInfo>[];
    for (final dynamic map in languageList) {
      final LanguageInfo languageInfo =
          LanguageInfo.fromJson(map as Map<String, dynamic>);
      list.add(languageInfo);
    }
    langList.value = list;
  }

  /**
   * 监听app 配置的变换 而重新更改
   * @author Will
   * @date 2021/11/16 14:16
   * @param 监听变化的对象
   */
  void handleAppChanged(_app) async {}

  /**
   * 读取用户设置的配置
   * @author Will
   * @date 2021/11/16 14:04
   */
  void onReadConfig() async {
    // 读取用户配置 方便写入内存 到时候 可以相应配读取用户信息
    final storeApp = (await AppUserPreferences.getInstance()).app;
    app.value = storeApp;
    if (storeApp.languageInfo != null) {
      changeLanguage(Locale(storeApp.languageInfo!.languageCode!,
          storeApp.languageInfo!.countryCode!));
    } else {
      //给出默认的 英文界面
      changeLanguage(const Locale('en', 'US'));
    }

    // //表示 第一次打开 app 没有创建过
    // if (storeApp.isFistTime == null) {
    //   app.value.isFistTime = true;
    // }
  }

  /**
   * 语言的转换
   *
   * @author Will
   * @date 2021/11/16 10:48
   * @param 传入的本地化
   */
  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
    AppS.load(locale);

    _chooseLanguage(locale);
  }

  /**
   * 选择语言 让新设置的语言 保存起来
   * @author Will
   * @date 2021/11/16 15:12
   * @param null
   * @return null
   */
  void _chooseLanguage(Locale locale) {
    for (final lang in langList) {
      if (lang.languageCode == locale.languageCode &&
          lang.countryCode == locale.countryCode) {
        app.update((val) {
          val!.languageInfo = lang;
          val.isFistTime = app.value.isFistTime;
        });
        app.refresh();

        //通常 使用获取用户信息之后 存入数据库 让数据永远保存最新的一份
        AppUserPreferences.getInstance().then((v) => v.setApp(app.value));
        break;
      }
    }
  }

  void updateFistTime(bool fistTime) {
    app.update((val) {
      val!.languageInfo = app.value.languageInfo;
      val.isFistTime = fistTime;
    });
    app.refresh();

    //通常 使用获取用户信息之后 存入数据库 让数据永远保存最新的一份
    AppUserPreferences.getInstance().then((v) => v.setApp(app.value));
  }

  /**
   * 插入一条数据
   * @author Will
   * @date 2021/11/25 17:07
   * @param name 钱包名称
   * @param password 密码
   * @param mnemonic 助记词
   * @param privateKey 私钥
   * @param protocol 币区块
   * @param address 钱包地址
   * @param rpcUrl 调用的是那个rpc
   */
  void insertWallet({
    required String? name,
    required String? password,
    String? privateKey,
    String? mnemonic,
  }) async {
    CustomDialog.showCustomDialog(
      Get.context!,
      Container(
        width: 145,
        height: 145,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitSquareCircle(
              color: CupertinoTheme.of(Get.context!).primaryColor,
              size: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(AppS().creat_wallet_ing),
          ],
        ),
      ),
      isShowCloseBtn: false,
      borderRadius: BorderRadius.circular(12),
    );

    //延迟 100 毫秒执行主要是先让上面的 load 显示出来再执行 插入操作
    Future.delayed(const Duration(milliseconds: 100), () {
      insert(
        name: name,
        password: password,
        privateKey: privateKey,
        mnemonic: mnemonic,
      );
    });
  }

  /**
   * 插入数据
   * @author Will
   * @date 2021/11/25 17:07
   * @param name 钱包名称
   * @param password 密码
   * @param mnemonic 助记词
   * @param privateKey 私钥
   * @param address 钱包地址
   */
  void insert({
    required String? name,
    required String? password,
    String? privateKey,
    String? mnemonic,
  }) async {
    final wService = WalletService.to;
    String protocol = wService.protocol.value;

    debugPrint('password =>$password');
    //加密后的密码
    password = await const WalletCrypt().walletPwdEncrypt(password!);
    debugPrint('encrypt password =>$password');

    if (mnemonic != null) {
      debugPrint('mnemonic=>$mnemonic');
      //通过 助记词产生 私钥
      privateKey = TokenService.getPrivateKey(mnemonic);
      debugPrint('privateKey =>$privateKey');
      //加密后的助记词
      mnemonic = await const WalletCrypt().encrypt(password, mnemonic);
      debugPrint('encrypt mnemonic =>$mnemonic');
    }

    //通过 私钥 产生 地址.
    final EthereumAddress publicAddress =
        TokenService.getPublicAddress(privateKey!);

    //去重 表示已經有
    if (await duplicateRemoval(publicAddress.hexEip55, protocol)) {
      Get.back();
      CustomDialog.showCustomDialog(
        Get.context!,
        SizedBox(
          width: 145,
          height: 145,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.clear_circled,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(AppS().wallet_has),
            ],
          ),
        ),
        isShowCloseBtn: false,
        isAutoClose: true,
        closeDuration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(12),
      );
    } else {
      //加密后秘钥
      privateKey = await const WalletCrypt().encrypt(password, privateKey);
      debugPrint('encrypt privateKey =>$privateKey');

      //更新之前的旧钱包
      await onReadWallet();

      final value = await wService.appDate.insertWallet(
        name: name,
        password: password,
        mnemonic: mnemonic,
        privateKey: privateKey,
        protocol: protocol,
        address: publicAddress.hexEip55,
        //所有创建的钱包 都变成主钱包
        isMain: true,
      );

      final WalletEntry wallet = WalletEntry(
        id: value,
        name: name,
        password: password,
        address: publicAddress.hexEip55,
        mnemonic: mnemonic,
        privateKey: privateKey,
        protocol: protocol,
        //所有创建的钱包 都变成主钱包
        is_main: true,
      );

      //不管是不是主要钱包 都给他做成 主要钱包
      wService.wallet.value = wallet;

      updateFistTime(false);

      //创建钱包成功的时候发给后台让后添加
      ToKenApi.acquire()
          .walletAddAddress(
              protocol: wService.protocol.value,
              address: publicAddress.hexEip55)
          .catchError((error) {
        Get.back();
        CoreKitToast.showError(error);
      });

      await creatToken(wallet);

      //创建好 地址 保存钱包 密码 钱包名称 跳转到首页
      Get.offAllNamed(AppRoutes.appMain);
    }
  }

  /**
   * 倘若第一次创建 或者回复的时候 默认给创建其 AAA 下的所有代币
   * @author Will
   * @date 2021/11/25 12:21
   * @param wallet 所在的主钱包
   * @return null
   */
  Future<void> creatToken(WalletEntry wallet) async {
    //获取代币地址
    final wService = WalletService.to;

    final allWallet = await wService.appDate.getAllWallets();

    //创建钱包成功的时候发给后台让后添加
    final coinList = await ToKenApi.acquire()
        .walletGetCoinKey(type: '1')
        .catchError((error) {
      CoreKitToast.showError(error);
    });

    //所有主币都 可以添加自己 主要代币
    for (final coinKeyEntity in coinList) {
      if (coinKeyEntity.protocol == wService.protocol.value) {
        //把获取到的主币 插入数据库 主键是当前这个钱包
        wService.appDate.insertToken(
          wallet_id: wallet.id,
          contractAddress: coinKeyEntity.contractAddress,
          imageUrl: coinKeyEntity.imageUrl,
          protocol: coinKeyEntity.protocol,
          coinKey: coinKeyEntity.coinKey,
          // isMainCoin: true,
        );
      }
    }

    //获取 后台支持的 当前 主币下的 代币
    final list = await ToKenApi.acquire()
        .walletGetCoinKey(type: '2')
        .catchError((error) {
      CoreKitToast.showError(error);
    });

    //相对来说 上面是一个钱包的存在 0 表示初始化 如果 大于1 的情况下表示下面已经添加过相对应的钱包 不给添加相对应的代币
    int hasWall = 0;

    //查找本地缓存是不是 有当前钱包纯在 不存在的情况下 插入 相对应的代币
    for (final dbWallet in allWallet) {
      //查找相对应的钱包存在 过
      if (dbWallet.protocol == wallet.protocol) {
        hasWall++;
        if (hasWall > 1) break;
      }
    }

    //等于 1的情况下表示只有相对应该主币下钱包只有一个 添加 他旗下的默认支持的代币
    if (hasWall == 1 && wallet.protocol == 'ARC20') {
      for (final coinKeyEntity in list) {
        if (coinKeyEntity.protocol == wService.protocol.value) {
          wService.appDate.insertToken(
            wallet_id: wallet.id,
            contractAddress: coinKeyEntity.contractAddress,
            imageUrl: coinKeyEntity.imageUrl,
            protocol: coinKeyEntity.protocol,
            coinKey: coinKeyEntity.coinKey,
          );
        }
      }
    }
  }

  /*
   * 去重是否已创建过该钱包地址
   * @author Will
   * @date 2021/12/7 17:06
   * @param address 钱包地址
   * @return 返回是否
   */
  Future<bool> duplicateRemoval(String address, String protocol) async {
    bool isHasAddress = false;
    final dbWalletList = await WalletService.to.appDate.getAllWallets();
    for (final walletEntry in dbWalletList) {
      if (walletEntry.address == address && walletEntry.protocol == protocol) {
        isHasAddress = true;
        break;
      }
    }
    return isHasAddress;
  }

  /**
   * 让其他钱包都变成非主要钱包
   * @author Will
   * @date 2021/11/17 14:15
   */
  Future<void> onReadWallet() async {
    final dbWalletList = await WalletService.to.appDate.getAllWallets();

    //本地钱包为空 不执行下面操作
    if (dbWalletList.isEmpty) return;

    for (WalletEntry walletEntry in dbWalletList) {
      if (walletEntry.is_main!) {
        walletEntry = walletEntry.copyWith(is_main: false);
        WalletService.to.appDate.updateWallet(walletEntry);
        break;
      }
    }
  }

  Future<AppUpgradeInfo> checkAppInfo(
      VersionEntity entity, List<String> contents) async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    // return Future.delayed(const Duration(seconds: 0), () {
    //
    // });

    return AppUpgradeInfo(
      title: AppS().app_update_version(entity.versionNo ?? ''),
      contents: contents,
      force: entity.isUpdates == 'S',
      apkDownloadUrl: entity.downloadAddress ?? '',
    );
  }

  void checkAppUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    SysApi.acquire()
        .getVersion(
      type: Platform.operatingSystem,
    )
        .then((value) {
      if (value != null) {
        final bool isUpdate = CoreUtil.versionCheck(
          localVersion: packageInfo.version,
          serverVersion: value.versionNo,
        );
        if (isUpdate) {
          List<String> contents = <String>[];
          try {
            contents = value.content!.replaceAll('<br>', '').split('\r\n');
          } catch (e) {
            contents = <String>[value.content!];
          }

          AppUpgrade.appUpgrade(
            Get.context!,
            checkAppInfo(value, contents),
            okBackgroundColors: [
              const Color(0xFF44AFFF),
              const Color(0xFF0091FF),
            ],
            okText: AppS().app_update_now,
          );
        }
      }
    });
  }
}
