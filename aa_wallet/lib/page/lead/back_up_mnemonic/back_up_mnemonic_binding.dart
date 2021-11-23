import 'package:get/get.dart';

import 'back_up_mnemonic_logic.dart';

class BackUpMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BackUpMnemonicLogic());
  }
}
