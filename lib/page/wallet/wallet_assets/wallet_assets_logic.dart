import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';

class WalletAssetsLogic extends GetxController {
  final isManagement = true.obs;
  final dbWalletList = <WalletEntry>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is bool) {
      isManagement.value = arguments;
    }
    //获取当前多少个钱包
    dbWalletList.value = await WalletService.to.appDate.getAllWallets();
  }
}
