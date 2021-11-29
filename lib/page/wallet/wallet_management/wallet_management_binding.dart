import 'package:get/get.dart';

import 'wallet_management_logic.dart';

class WalletManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletManagementLogic());
  }
}
