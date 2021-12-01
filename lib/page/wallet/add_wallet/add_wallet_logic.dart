import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';

class AddWalletLogic extends GetxController {
  void onGotoCreate(int btnTag) {
    final wallet = WalletService.to;
    switch (btnTag) {
      case 0:
        wallet.protocol.value = 'ERC20';
        break;
      case 1:
        wallet.protocol.value = 'TRC20';
        break;
      case 2:
        wallet.protocol.value = 'ARC20';
        break;
    }
    Get.toNamed(AppRoutes.chooseCreatWallet);
  }
}