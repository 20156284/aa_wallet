import 'dart:math';

import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

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

    AppService.to.insertWallet(
      name: wService.walletName.value,
      password: wService.password.value,
      mnemonic: mnemonic,
      protocol: wService.protocol.value,
      cancelFunc: cancelFunc,
    );
  }
}
