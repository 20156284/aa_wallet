import 'package:get/get.dart';

import 'coin_type_logic.dart';

class CoinTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoinTypeLogic());
  }
}
