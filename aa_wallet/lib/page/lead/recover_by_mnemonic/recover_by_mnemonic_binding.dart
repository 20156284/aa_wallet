import 'package:get/get.dart';

import 'recover_by_mnemonic_logic.dart';

class RecoverByMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoverByMnemonicLogic());
  }
}
