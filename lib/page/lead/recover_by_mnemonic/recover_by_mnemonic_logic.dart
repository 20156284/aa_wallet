import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoverByMnemonicLogic extends GetxController {
  // final TextEditingController mnemonicEdit = TextEditingController();
  final TextEditingController nameEdit = TextEditingController();
  // final TextEditingController pwdEdit = TextEditingController();
  // final TextEditingController repeatPwdEdit = TextEditingController();

//  主要测试钱包
  final TextEditingController mnemonicEdit = TextEditingController(
      text:
          'song convince art planet domain property load satoshi rocket west vital cycle');

  // //第二测试钱包
  // final TextEditingController mnemonicEdit = TextEditingController(
  //     text:
  //         'forest palm main jelly embody cigar select physical clown tape dutch profit');

  //第三测试钱包
  // final TextEditingController mnemonicEdit = TextEditingController(
  //     text:
  //         'credit rural oval choose lonely advice clarify scale key frown either muscle');

  // final TextEditingController nameEdit =
  //     TextEditingController(text: 'Will’sWallet');
  final TextEditingController pwdEdit = TextEditingController(text: 'Aa123456');
  final TextEditingController repeatPwdEdit =
      TextEditingController(text: 'Aa123456');

  final pwdVisible = true.obs;
  final repeatVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    nameEdit.text = WalletService.to.walletName.value;
  }

  /**
   * 检查输入是否合法再执行
   * @author Will
   * @date 2021/11/17 09:50
   */
  void onCheck() {
    if (mnemonicEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().recover_import_mnemonic);
      return;
    }
    if (mnemonicEdit.text.split(' ').length != 12) {
      CoreKitToast.showError(AppS().recover_import_mnemonic_tips);
      return;
    }
    // if (nameEdit.text.trim().isEmpty) {
    //   CoreKitToast.showError(AppS().creat_wallet_name_input);
    //   return;
    // }
    if (pwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_input);
      return;
    }
    if (repeatPwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_repeat_pwd_input);
      return;
    }

    if (pwdEdit.text.trim() != repeatPwdEdit.text.trim()) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_repeat);
      return;
    }

    //正则表达 8 位 包含字母数字 符号
    final RegExp regexPwd = RegExp(r'^(?:(?=.*[a-z])(?=.*[0-9])).{8,16}$');
    if (!regexPwd.hasMatch(repeatPwdEdit.text.trim())) {
      CoreKitToast.showIconText(text: AppS().creat_wallet_pwd_tips);
      return;
    }

    if (CoreUtil.isNotEmptyString(nameEdit.text.trim())) {
      WalletService.to.walletName.value = nameEdit.text;
    }

    //導入操作
    onRecover(mnemonicEdit.text);
  }

  /**
   * 切换密码显示状态
   * @author Will
   * @date 2021/11/17 09:59
   * @param null
   * @return null
   */
  void obscurePwd() {
    pwdVisible.value = !pwdVisible.value;
  }

  /**
   * 切换确认密码显示状态
   * @author Will
   * @date 2021/11/17 09:59
   * @param null
   * @return null
   */
  void obscureRepeat() {
    repeatVisible.value = !repeatVisible.value;
  }

  /**
   * 创建钱包
   * @author Will
   * @date 2021/11/17 10:37
   * @param mnemonics 助记词
   */
  void onRecover(String mnemonic) async {
    AppService.to.insertWallet(
      name: WalletService.to.walletName.value,
      password: pwdEdit.text,
      mnemonic: mnemonic,
      protocol: WalletService.to.protocol.value,
    );
  }
}
