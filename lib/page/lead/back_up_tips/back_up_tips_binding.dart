import 'package:get/get.dart';

import 'back_up_tips_logic.dart';

class BackUpTipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BackUpTipsLogic());
  }
}
