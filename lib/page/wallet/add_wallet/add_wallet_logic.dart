import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';

class AddWalletLogic extends GetxController {
  final serverSupportMainCoin = <CoinKeyEntity>[].obs;

  late Worker worker;

  @override
  void onInit() async {
    super.onInit();

    serverSupportMainCoin.value = WalletService.to.serverSupportMainCoin.value;
    //支持主链币的变换
    worker = ever(
        WalletService.to.serverSupportMainCoin, handleSupportMainCoinChanged);
  }

  void handleSupportMainCoinChanged(_serverSupportMainCoin) {
    serverSupportMainCoin.value = WalletService.to.serverSupportMainCoin.value;
  }

  @override
  void onClose() {
    worker.dispose();
    super.onClose();
  }

  void onGotoCreate(String btnTag) {
    final wallet = WalletService.to;
    switch (btnTag) {
      case 'ERC20':
        wallet.walletName.value = 'ETH';
        wallet.protocol.value = 'ERC20';
        break;
      case 'TRC20':
        wallet.walletName.value = 'BTC';
        wallet.protocol.value = 'TRC20';
        break;
      case 'ARC20':
        wallet.walletName.value = 'AAA';
        wallet.protocol.value = 'ARC20';
        break;
    }
    Get.toNamed(AppRoutes.chooseCreatWallet);
  }
}
