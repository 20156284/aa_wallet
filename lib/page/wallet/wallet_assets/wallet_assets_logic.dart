import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletAssetsLogic extends GetxController {
  final isManagement = true.obs;
  final dbWalletList = <WalletEntry>[].obs;

  //刷新控件
  late RefreshController refreshCtrl = RefreshController(initialRefresh: true);

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

  void onRefreshFun() async {
    dbWalletList.value = await WalletService.to.appDate.getAllWallets();

    refreshCtrl.refreshCompleted();
  }

  void onDel(WalletEntry walletEntry) async {
    WalletService.to.onDelWallet(walletEntry);
    dbWalletList.remove(walletEntry);
    refreshCtrl.refreshCompleted();
  }
}
