import 'package:get/get.dart';

import 'export_private_key_logic.dart';

class ExportPrivateKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExportPrivateKeyLogic());
  }
}
