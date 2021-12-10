import 'package:get/get.dart';

import 'custom_token_logic.dart';

class CustomTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomTokenLogic());
  }
}
