import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:get/get.dart';

class LeadLogic extends GetxController {
  final languageInfo = LanguageInfo().obs;

  @override
  void onInit() {
    super.onInit();
    languageInfo.value = AppService.to.app.value.languageInfo!;
  }

  /**
   * 跳转选择语言的页面
   * @author Will
   * @date 2021/11/16 15:26
   */
  void onGotoLanguagePage() async {
    final data = await Get.toNamed(AppRoutes.languageChoose);
    if (data != null && data is LanguageInfo) {
      languageInfo.value = data;
    }
  }
}
