import 'package:get/get.dart';

import 'recover_by_private_key_logic.dart';

class RecoverByPrivateKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoverByPrivateKeyLogic());
  }
}
