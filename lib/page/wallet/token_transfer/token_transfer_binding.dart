import 'package:get/get.dart';

import 'token_transfer_logic.dart';

class TokenTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenTransferLogic());
  }
}
