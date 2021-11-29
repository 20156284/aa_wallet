import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:get/get.dart';

class CoinTypeLogic extends GetxController {
  final coinKeyList = <CoinKeyEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      coinKeyList.value = Get.arguments as List<CoinKeyEntity>;
    }
  }
}
