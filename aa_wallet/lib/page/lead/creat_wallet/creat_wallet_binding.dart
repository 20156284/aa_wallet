import 'package:get/get.dart';

import 'creat_wallet_logic.dart';

class CreatWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatWalletLogic());
  }
}
