import 'package:get/get.dart';

import 'confirm_mnemonic_logic.dart';

class ConfirmMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmMnemonicLogic());
  }
}
