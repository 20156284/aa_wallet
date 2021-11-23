import 'package:get/get.dart';

import 'app_main_logic.dart';

class AppMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppMainLogic());
  }
}
