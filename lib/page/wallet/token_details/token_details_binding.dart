import 'package:get/get.dart';

import 'token_details_logic.dart';

class TokenDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenDetailsLogic());
  }
}
