import 'package:get/get.dart';

class ChooseCreatWalletLogic extends GetxController {
  final coinType = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final String cType = Get.arguments.toString();
    coinType.value = cType;
  }
}
