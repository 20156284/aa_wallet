import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:get/get.dart';

class BackUpTipsLogic extends GetxController {
  final mnemonics = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      mnemonics.value = Get.arguments.toString();
    }
  }

  void onGotoMnemonic() {
    if (CoreUtil.isEmptyString(mnemonics.value)) {
      Get.toNamed(AppRoutes.backUpMnemonic);
    } else {
      Get.toNamed(
        AppRoutes.backUpMnemonic,
        arguments: mnemonics.value,
      );
    }
  }
}
