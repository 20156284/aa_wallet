import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BackUpMnemonicLogic extends GetxController {
  final mnemonicsList = <String>[].obs;
  final mnemonics = ''.obs;
  bool isComeFrom = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      mnemonics.value = Get.arguments.toString();
      mnemonicsList.value = mnemonics.value.split(' ');
      isComeFrom = true;
    } else {
      final String walletMnemonics = TokenService.generateMnemonic();
      mnemonics.value = walletMnemonics;
      mnemonicsList.value = walletMnemonics.split(' ');
    }
  }

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

  void onGotoConfirm() {
    if (isComeFrom) {
      // Get.back();
      onCopy();
    } else {
      if (mnemonicsList.isNotEmpty)
        Get.toNamed(AppRoutes.confirmMnemonic, arguments: mnemonics.value);
    }
  }

  /**
   * 複製助记词
   * @author Will
   * @date 2021/11/19 17:07
   */
  void onCopy() {
    Clipboard.setData(ClipboardData(text: mnemonics.value));
    CustomDialog.showCustomDialog(
      Get.context!,
      onCopyDialogWidget(),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /**
   * 导出输入密码确认窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget onCopyDialogWidget() {
    return SizedBox(
      width: 145,
      height: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.check_mark_circled, size: 80),
          const SizedBox(
            height: 20,
          ),
          Text(AppS().back_up_mnemonic_confirm_success),
        ],
      ),
    );
  }
}
