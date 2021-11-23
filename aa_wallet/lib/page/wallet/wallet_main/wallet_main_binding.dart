import 'package:get/get.dart';

import 'wallet_main_logic.dart';

class WalletMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletMainLogic());
  }
}
