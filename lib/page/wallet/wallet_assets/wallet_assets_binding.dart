import 'package:get/get.dart';

import 'wallet_assets_logic.dart';

class WalletAssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletAssetsLogic());
  }
}
