import 'package:get/get.dart';

import 'update_record_logic.dart';

class UpdateRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateRecordLogic());
  }
}
