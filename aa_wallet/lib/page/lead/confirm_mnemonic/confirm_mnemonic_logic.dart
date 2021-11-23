import 'dart:math';

import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class ConfirmMnemonicLogic extends GetxController {
  //传过来的助记词
  final mnemonicsList = <String>[].obs;

  //选择的助记词
  final chooseList = <String>[].obs;

  //打乱的助记词
  final randomList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    onGetMnemonics();
  }

  /**
   * 获取助记词
   * @author Will
   * @date 2021/11/16 17:10
   * @param null
   * @return null
   */
  void onGetMnemonics() {
    final mnemonics = Get.arguments;
    if (mnemonics != null && mnemonics is String) {
      final list = mnemonics.split(' ');
      mnemonicsList.value = list;
      randomList.value = shuffle(list) as List<String>;
      chooseList.value = <String>[];
    }
  }

  /**
   * 通过 下标改变元素的圆角widget
   * @author Will
   * @date 2021/11/16 17:09
   * @param index 当前下标
   * @return 圆角
   */
  BorderRadius onMnemonic(int index) {
    BorderRadius radius = BorderRadius.circular(0.0);
    if (index == 0) {
      radius = const BorderRadius.only(topLeft: Radius.circular(5));
    }
    if (index == 2) {
      radius = const BorderRadius.only(topRight: Radius.circular(5));
    }
    if (index == 9) {
      radius = const BorderRadius.only(bottomLeft: Radius.circular(5));
    }
    if (index == 11) {
      radius = const BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return radius;
  }

  /**
   * 随机打乱数组
   * @author Will
   * @date 2021/11/16 17:08
   * @param items 传入的数组
   * @return 返回打乱的新数组
   */
  List shuffle(List items) {
    final random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      final n = random.nextInt(i + 1);

      final temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  /**
   * 移除 相对应的 标题 起到 点击消失的效果
   * @author Will
   * @date 2021/11/16 17:06
   * @param index 当前的词在数组下标
   * @param title 当前的词标题
   */
  void onRemove(int index, String title) {
    randomList.removeAt(index);
    chooseList.add(title);

    //一下操作比较奇葩 有时间找找这个奇葩的BUG 移除随机数 然后 特定数都会 有问题
    final mnemonics = Get.arguments;
    if (mnemonics != null && mnemonics is String) {
      final list = mnemonics.split(' ');
      mnemonicsList.value = list;
    }
  }

  /**
   * 检查助记词
   * @author Will
   * @date 2021/11/16 17:06
   */
  void onCheckMnemonics() {
    String userChoose = '';
    for (final String element in chooseList) {
      userChoose += element + ' ';
    }
    userChoose = userChoose.substring(0, userChoose.length - 1);

    final String mnemonics = Get.arguments as String;
    if (userChoose != mnemonics) {
      CoreKitToast.showFailure(
        AppS().confirm_mnemonic_sequence_err,
        onClose: () => onGetMnemonics(),
      );
      return;
    }

    onCreat(mnemonics);
  }

  /**
   * 创建钱包
   * @author Will
   * @date 2021/11/17 10:37
   * @param mnemonics 助记词
   */
  void onCreat(String mnemonic) async {
    final cancelFunc = CoreKitToast.showLoading();
    //通过 助记词产生 私钥
    final privateKey = TokenService.getPrivateKey(mnemonic);
    //通过 私钥 产生 地址.
    final EthereumAddress publicAddress =
        TokenService.getPublicAddress(privateKey);
    //把 用户的 地址 和钱包密码 钱包名称 存储起来 创建一个新的 就采用他为默认的 钱包
    final String walletName = WalletService.to.walletName.value;
    String pwd = WalletService.to.password.value;
    //加密后的密码
    pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
    //加密后的助记词
    mnemonic = await const WalletCrypt().encrypt(pwd, mnemonic);

    WalletService.to.appDate
        .insertWallet(
      name: walletName,
      password: pwd,
      address: publicAddress.hexEip55,
      mnemonic: mnemonic,
      privateKey: privateKey,
      isMain: true,
    )
        .then((value) {
      final wService = WalletService.to;

      final WalletEntry wallet = WalletEntry(
        id: value,
        name: walletName,
        password: pwd,
        address: publicAddress.hexEip55,
        mnemonic: mnemonic,
        privateKey: privateKey,
        protocol: wService.protocol.value,
        is_main: true,
      );
      wService.wallet.value = wallet;
      //先采用默认的 发送
      ToKenApi.acquire().walletAddAddress(
          protocol: wService.protocol.value, address: publicAddress.toString());

      //创建好 地址 保存钱包 密码 钱包名称 跳转到首页
      Get.offAllNamed(AppRoutes.appMain);
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }
}
