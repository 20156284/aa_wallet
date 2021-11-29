import 'package:get/get.dart';

import 'lead_logic.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeadLogic());
  }
}
