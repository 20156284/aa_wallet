import 'package:get/get.dart';

import 'recover_wallet_logic.dart';

class RecoverWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoverWalletLogic());
  }
}
