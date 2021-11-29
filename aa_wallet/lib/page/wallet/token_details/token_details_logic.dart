import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TokenDetailsLogic extends GetxController {
  final tokenEntry = TokenEntry(id: 0, wallet_id: 0).obs;

  //刷新控件
  late RefreshController refreshCtrl = RefreshController(initialRefresh: true);

  final state = 0.obs;

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
    refreshCtrl.refreshCompleted();
  }

  /**
   * 上拉加载
   * @author Will
   * @date 2021/11/26 10:58
   */
  void onLoadingFun() {}
}
