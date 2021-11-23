import 'package:get/get.dart';

import 'wallet_details_logic.dart';

class WalletDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletDetailsLogic());
  }
}
