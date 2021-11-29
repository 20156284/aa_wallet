import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExportPrivateKeyLogic extends GetxController {
  final privateKey = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      privateKey.value = Get.arguments.toString();
    }
  }

  /**
   * 複製私鑰
   * @author Will
   * @date 2021/11/19 17:07
   */
  void onCopy() {
    if (CoreUtil.isNotEmptyString(privateKey.value)) {
      Clipboard.setData(ClipboardData(text: privateKey.value));
      CustomDialog.showCustomDialog(
        Get.context!,
        dialogWidget(),
        isShowCloseBtn: false,
        isAutoClose: true,
        closeDuration: const Duration(seconds: 1),
        borderRadius: BorderRadius.circular(12),
      );
    }
  }

  /**
   * 导出输入密码确认窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget dialogWidget() {
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
          Text(AppS().wallet_import_key_copy_success),
        ],
      ),
    );
  }
}
