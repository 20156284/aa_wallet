import 'package:get/get.dart';

import 'collection_address_logic.dart';

class CollectionAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionAddressLogic());
  }
}
