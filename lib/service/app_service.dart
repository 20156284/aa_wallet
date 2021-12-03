// ===============================================
// app_service
//
// Create by will on 2021/11/10 10:29
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:convert';
import 'dart:ui';

import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/preference/app_preferences.dart';
import 'package:aa_wallet/preference/app_user_preferences.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class AppService extends GetxService {
  AppService(this.context);

  final BuildContext context;

  static AppService get to => Get.find();

  final app = AppPreferences().obs;
  final langList = <LanguageInfo>[].obs;
  final haveBackUpMnemonic = false.obs;

  final tokenList = <TokenEntry>[].obs;

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
   * @param cancelFunc 关闭的load
   */
  void insertWallet({
    required String? name,
    required String? password,
    String? privateKey,
    String? mnemonic,
    String? protocol,
    String? rpcUrl,
  }) async {
    final cancelFunc = CoreKitToast.showCustomDialog(
      child: Container(
        width: 145,
        height: 145,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
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
    );

    final wService = WalletService.to;

    bool isFist = false;
    if (app.value.isFistTime == null) {
      isFist = true;
    } else {
      isFist = app.value.isFistTime!;
    }

    //加密后的密码
    password = await const WalletCrypt().walletPwdEncrypt(password!);

    if (mnemonic != null) {
      //通过 助记词产生 私钥
      privateKey = TokenService.getPrivateKey(mnemonic);
      //加密后的助记词
      mnemonic = await const WalletCrypt().encrypt(password, mnemonic);
    }

    //通过 私钥 产生 地址.
    final EthereumAddress publicAddress =
        TokenService.getPublicAddress(privateKey!);

    //去重 表示已經有
    if (await duplicateRemoval(publicAddress.hexEip55)) {
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

      final value = await wService.appDate.insertWallet(
        name: name,
        password: password,
        mnemonic: mnemonic,
        privateKey: privateKey,
        protocol: protocol,
        address: publicAddress.hexEip55,
        rpcUrl: rpcUrl,
        //第一次创建的钱包也是主钱包
        isMain: isFist,
        isFist: isFist,
      );

      final WalletEntry wallet = WalletEntry(
        id: value,
        name: name,
        password: password,
        address: publicAddress.hexEip55,
        mnemonic: mnemonic,
        privateKey: privateKey,
        protocol: protocol,
        rpcUrl: rpcUrl,
        //第一次创建的钱包也是主钱包
        is_main: isFist,
        is_fist: isFist,
      );
      wService.wallet.value = wallet;

      updateFistTime(false);
      if (isFist) creatToken(wallet);

      //创建钱包成功的时候发给后台让后添加
      ToKenApi.acquire()
          .walletAddAddress(
              protocol: wService.protocol.value,
              address: publicAddress.hexEip55)
          .then((value) {
        //创建好 地址 保存钱包 密码 钱包名称 跳转到首页
        Get.offAllNamed(AppRoutes.appMain);
      }).catchError((error) {
        CoreKitToast.showError(error);
      }).whenComplete(cancelFunc);
    }
  }

  /**
   * 倘若第一次创建 或者回复的时候 默认给创建其他代币
   * @author Will
   * @date 2021/11/25 12:21
   * @param wallet 所在的主钱包
   * @return null
   */
  void creatToken(WalletEntry wallet) async {
    //获取代币地址
    final wService = WalletService.to;
    //如果 主钱包 没有 或者是第一次 找回的 都给主动添加 主币
    if ((await wService.appDate.getAllWallets()).length == 1) {
      //创建钱包成功的时候发给后台让后添加
      final list = await ToKenApi.acquire()
          .walletGetCoinKey(type: '1')
          .catchError((error) {
        CoreKitToast.showError(error);
      });

      for (final coinKeyEntity in list) {
        if (coinKeyEntity.protocol == wService.protocol.value) {
          //把获取到的主币 插入数据库 主键是当前这个钱包
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

    //创建钱包成功的时候发给后台让后添加
    final list = await ToKenApi.acquire()
        .walletGetCoinKey(type: '2')
        .catchError((error) {
      CoreKitToast.showError(error);
    });

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

    getToken(wallet);
  }

  /**
   * 获取代币
   * @author Will
   * @date 2021/11/25 17:10
   */
  void getToken(WalletEntry walletEntry) async {
    final list = await WalletService.to.appDate.getAllToken();
    final newList = <TokenEntry>[];
    for (final tokenEntry in list) {
      if (tokenEntry.protocol == walletEntry.protocol) {
        newList.add(tokenEntry);
      }
    }

    tokenList.value = newList;
  }

  Future<bool> duplicateRemoval(String address) async {
    bool isHasAddress = false;
    final list = await WalletService.to.appDate.getAllWallets();
    for (final walletEntry in list) {
      if (walletEntry.address == address) {
        isHasAddress = true;
        break;
      }
    }
    return isHasAddress;
  }
}
