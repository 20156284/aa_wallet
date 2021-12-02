import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/entity/token/transaction_records_entity.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TokenDetailsLogic extends GetxController {
  final tokenEntry = TokenEntry(id: 0, wallet_id: 0).obs;

  //刷新控件
  late RefreshController refreshCtrl = RefreshController(initialRefresh: true);

  final state = 0.obs;
  String? type;
  final transactionRecordsList = <TransactionRecordsEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final entry = Get.arguments;
    if (entry != null && entry is TokenEntry) {
      tokenEntry.value = entry;
    }
  }

  /**
   * 下拉刷新
   * @author Will
   * @date 2021/11/26 10:58
   */
  void onRefreshFun() {
    final cancelFunc = CoreKitToast.showLoading();
    ToKenApi.acquire()
        .transactionRecords(
      type: type,
      protocol: tokenEntry.value.protocol,
      address: WalletService.to.wallet.value.address,
      coinKey: tokenEntry.value.coinKey,
    )
        .then((value) {
      final hasData = value.isNotEmpty == true;
      refreshCtrl.refreshCompleted(resetFooterState: hasData);
      transactionRecordsList.clear();
      if (hasData) {
        transactionRecordsList.addAll(value);
      }
    }).catchError((error) {
      refreshCtrl.refreshFailed();
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }

  /**
   * 上拉加载
   * @author Will
   * @date 2021/11/26 10:58
   */
  void onLoadingFun() {}
}
