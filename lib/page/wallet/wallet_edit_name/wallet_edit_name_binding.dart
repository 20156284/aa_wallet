import 'package:get/get.dart';

import 'wallet_edit_name_logic.dart';

class WalletEditNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletEditNameLogic());
  }
}
