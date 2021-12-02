import 'package:get/get.dart';

class WalletAssetsLogic extends GetxController {
  final isManagement = true.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is bool) {
      isManagement.value = arguments;
    }
  }
}
