import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePwdLogic extends GetxController {
  final TextEditingController oldPwdEdit = TextEditingController();
  final TextEditingController newPwdEdit = TextEditingController();
  final TextEditingController confirmPwdEdit = TextEditingController();

  final oldPwdVisible = true.obs;
  final newPwdVisible = true.obs;
  final confirmVisible = true.obs;

  late WalletEntry wallet = WalletEntry(id: 0);

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is WalletEntry) {
      wallet = arguments;
    }
  }

  void obscureOldPwd() {
    oldPwdVisible.value = !oldPwdVisible.value;
  }

  void obscureNewPwd() {
    newPwdVisible.value = !newPwdVisible.value;
  }

  void obscureConfirmPwd() {
    confirmVisible.value = !confirmVisible.value;
  }

  /*
   * 检查输入的合法性
   * @author Will
   * @date 2021/12/3 11:11
   */
  void onCheck() async {
    if (oldPwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().change_page_now_pwd_input);
      return;
    }

    if (!await const WalletCrypt()
        .contrastPwd(oldPwdEdit.text.trim(), wallet.password!)) {
      CoreKitToast.showError(AppS().wallet_password_err);
      return;
    }

    if (newPwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().change_page_new_pwd_input);
      return;
    }

    if (confirmPwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().change_page_confirm_pwd_input);
      return;
    }

    //相同密码不做修改
    if (newPwdEdit.text.trim() != confirmPwdEdit.text.trim()) {
      onDialogWidget(
        icon: const Icon(CupertinoIcons.check_mark_circled, size: 80),
        title: AppS().change_page_pwd_success,
        isClose: true,
      );
      return;
    }

    if (confirmPwdEdit.text.trim() != newPwdEdit.text.trim()) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_repeat);
      return;
    }

    //正则表达 8 位 包含字母数字 符号
    final RegExp regexPwd = RegExp(r'^(?:(?=.*[a-z])(?=.*[0-9])).{8,16}$');
    if (!regexPwd.hasMatch(confirmPwdEdit.text.trim())) {
      CoreKitToast.showIconText(text: AppS().creat_wallet_pwd_tips);
      return;
    }

    onChangPwd();
  }

  /*
   * 修改密码
   * @author Will
   * @date 2021/12/3 11:11
   */
  void onChangPwd() async {
    String oldPwd = oldPwdEdit.text;
    String newPwd = confirmPwdEdit.text;

    final cancelFunc = CoreKitToast.showLoading();
    //加密后的旧密码
    oldPwd = await const WalletCrypt().walletPwdEncrypt(oldPwd);
    //解密后的 私钥
    String privateKey =
        await const WalletCrypt().decrypt(oldPwd, wallet.privateKey!);

    //加密后的新密码
    newPwd = await const WalletCrypt().walletPwdEncrypt(newPwd);

    //加密后秘钥
    privateKey = await const WalletCrypt().encrypt(newPwd, privateKey);

    wallet = wallet.copyWith(
      password: newPwd,
      privateKey: privateKey,
    );

    if (wallet.mnemonic != null) {
      //解密的助记词
      String mnemonic =
          await const WalletCrypt().decrypt(oldPwd, wallet.mnemonic!);
      //加密后的助记词
      mnemonic = await const WalletCrypt().encrypt(newPwd, mnemonic);

      wallet = wallet.copyWith(
        mnemonic: mnemonic,
      );
    }

    WalletService.to.onUpdateWallet(wallet).then((value) {
      if (value) {
        oldPwdEdit.text = '';
        newPwdEdit.text = '';
        confirmPwdEdit.text = '';

        //主錢包的話發送监听
        if (wallet.is_main != null && wallet.is_main!) {
          WalletService.to.wallet.value = wallet;
        }

        onDialogWidget(
          icon: const Icon(CupertinoIcons.check_mark_circled, size: 80),
          title: AppS().change_page_pwd_success,
          isClose: true,
        );
      } else {
        onDialogWidget(
          icon: const Icon(
            CupertinoIcons.clear_circled,
            size: 80,
            color: Colors.red,
          ),
          title: AppS().change_page_pwd_fail,
        );
      }
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }

  void onDialogWidget(
      {required Icon? icon, required String? title, bool? isClose}) {
    CustomDialog.showCustomDialog(
      Get.context!,
      SizedBox(
        width: 145,
        height: 145,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(
              height: 20,
            ),
            Text(title ?? ''),
          ],
        ),
      ),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
      onClose: () {
        if (isClose != null && isClose) {
          Get.back(result: wallet);
        }
      },
    );
  }
}
