// ===============================================
// profile_page_binding
//
// Create by will on 2021/10/25 14:01
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:get/get.dart';
import 'profile_page_logic.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageLogic());
  }
}
