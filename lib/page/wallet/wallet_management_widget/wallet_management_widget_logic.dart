import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';

class WalletManagementWidgetLogic extends GetxController {
  final btnTag = '0'.obs;
  final walletList = <WalletEntry>[].obs;
  final isDialog = false.obs;
  List<WalletEntry> dbWalletList = <WalletEntry>[];

  final serverSupportMainCoin = <CoinKeyEntity>[].obs;

  late Worker worker;

  @override
  void onInit() async {
    super.onInit();

    serverSupportMainCoin.value = WalletService.to.serverSupportMainCoin.value;
    //支持主链币的变换
    worker = ever(
        WalletService.to.serverSupportMainCoin, handleSupportMainCoinChanged);

    dbWalletList = await WalletService.to.appDate.getAllWallets();
    onGetAllWallet();
  }

  void handleSupportMainCoinChanged(_serverSupportMainCoin) {
    serverSupportMainCoin.value = WalletService.to.serverSupportMainCoin.value;
  }

  @override
  void onClose() {
    worker.dispose();
    super.onClose();
  }

  /**
   * 获取所有钱包地址
   * @author Will
   * @date 2021/11/30 15:28
   */
  void onGetAllWallet() async {
    List<WalletEntry> newList = <WalletEntry>[];

    if (btnTag.value == '0') {
      newList = dbWalletList;
    } else {
      for (final wallet in dbWalletList) {
        switch (btnTag.value) {
          case 'ERC20':
            if (wallet.protocol == 'ERC20') {
              newList.add(wallet);
            }
            break;
          case 'TRC20':
            if (wallet.protocol == 'TRC20') {
              newList.add(wallet);
            }
            break;
          case 'ARC20':
            if (wallet.protocol == 'ARC20') {
              newList.add(wallet);
            }
            break;
        }
      }
    }

    walletList.value = newList;
    walletList.refresh();
  }

  /**
   * 选择一个Cell 让他变成主钱包
   * @author Will
   * @date 2021/11/30 17:41
   * @param walletEntry 选择的钱包对象
   */
  void onChoose(WalletEntry walletEntry) async {
    // 关闭弹窗或者是返回上一级
    Get.back();

    final wService = WalletService.to;
    //获取之前显示的主钱包 替换下来
    WalletEntry beforeWallet = wService.wallet.value;
    beforeWallet = beforeWallet.copyWith(is_main: false);

    //更新新的钱包 作为一个主要钱包
    walletEntry = walletEntry.copyWith(is_main: true);

    wService.wallet.value = walletEntry;

    await wService.onUpdateWallet(walletEntry);
    await wService.onUpdateWallet(beforeWallet);
  }
}
