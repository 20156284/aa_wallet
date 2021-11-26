import 'package:get/get.dart';

import 'add_token_logic.dart';

class AddTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTokenLogic());
  }
}
