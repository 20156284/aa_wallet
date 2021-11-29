import 'dart:ui';

import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:get/get.dart';

class LanguageChooseLogic extends GetxController {
  final langList = <LanguageInfo>[].obs;
  final chooseLang = LanguageInfo().obs;

  @override
  void onInit() {
    super.onInit();
    _onLoadLanguage();
  }

  /**
   * 加载语言
   * @author Will
   * @date 2021/11/16 14:52
   */
  void _onLoadLanguage() async {
    langList.value = AppService.to.langList;
    chooseLang.value = AppService.to.app.value.languageInfo!;
  }

  /**
   * 选择语言
   * @author Will
   * @date 2021/11/16 16:20
   * @param null
   * @return null
   */
  void onChooseLanguage(LanguageInfo info) {
    AppService.to.changeLanguage(Locale(info.languageCode!, info.countryCode!));
    Get.back(result: info);
  }
}
