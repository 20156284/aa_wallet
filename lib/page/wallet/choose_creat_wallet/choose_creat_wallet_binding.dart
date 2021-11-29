import 'package:get/get.dart';

import 'choose_creat_wallet_logic.dart';

class ChooseCreatWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseCreatWalletLogic());
  }
}
