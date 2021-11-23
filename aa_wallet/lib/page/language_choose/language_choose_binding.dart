import 'package:get/get.dart';

import 'language_choose_logic.dart';

class LanguageChooseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageChooseLogic());
  }
}
