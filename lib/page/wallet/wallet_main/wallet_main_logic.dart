import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletMainLogic extends GetxController {
  //刷新控件
  late RefreshController refreshCtrl = RefreshController(initialRefresh: true);

  List<TokenEntry> dbTokenList = <TokenEntry>[];
  final walletList = <WalletEntry>[].obs;
  final tokenList = <TokenEntry>[].obs;
  final wallet = WalletEntry(id: 0).obs;
  final showAddress = ''.obs;

  late Worker worker;

  @override
  void onInit() async {
    super.onInit();

    final walletService = WalletService.to;

    for (final walletEntry in await walletService.appDate.getAllWallets()) {
      if (walletEntry.is_main!) {
        wallet.value = walletEntry;
        break;
      }
    }
    onShow();

    //监听钱包的变化
    worker = ever(walletService.wallet, handleWalletChanged);
  }

  @override
  void onClose() {
    //释放当前页面的监听事件
    worker.dispose();
    super.onClose();
  }

  /**
   * 监听钱包变换的事件
   * @author Will
   * @date 2021/11/18 15:05
   * @param _wallet 钱包实体类
   */
  void handleWalletChanged(WalletEntry _wallet) async {
    wallet.value = _wallet;
    wallet.refresh();
    onShow();
    onRefreshFun();
  }

  /**
   * 显示钱包地址做裁剪
   * @author Will
   * @date 2021/11/20 15:55
   */
  void onShow() {
    showAddress.value =
        TokenService.formattingAddress(wallet.value.address ?? '');
  }

  /**
   * 複製私鑰
   * @author Will
   * @date 2021/11/19 17:07
   */
  void onCopy() {
    Clipboard.setData(ClipboardData(text: wallet.value.address));
    CustomDialog.showCustomDialog(
      Get.context!,
      onCopyDialogWidget(),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /**
   * 复制钱包地址的弹窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget onCopyDialogWidget() {
    return SizedBox(
      width: 145,
      height: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.check_mark_circled, size: 80),
          const SizedBox(
            height: 20,
          ),
          Text(AppS().wallet_add_copy_success),
        ],
      ),
    );
  }

  /**
   * 添加資產
   * @author Will
   * @date 2021/11/22 15:59
   */
  void onAddAssets() {
    Get.toNamed(AppRoutes.addToken);
  }

  void onRefreshFun() async {
    dbTokenList = await WalletService.to.appDate.getAllToken();

    final newList = <TokenEntry>[];
    for (final tokenEntry in dbTokenList) {
      TokenEntry newTokenEntry = TokenEntry(id: 0, wallet_id: 0);
      //只去查询 当前 主币下 代币的余额
      if (tokenEntry.protocol == wallet.value.protocol) {
        if (tokenEntry.contractAddress == null) {
          //这个是主币 所以 获取主币的余额
          final balance = await TokenService.getBalance(
            wallet.value.address!,
          );
          WalletService.to.aaaAmount.value = num.parse(balance);
          newTokenEntry = tokenEntry.copyWith(balance: balance);
        } else {
          //这个是代币的 获取小数点
          final int decimals =
              await TokenService.getDecimals(tokenEntry.contractAddress!);
          final balance = await TokenService.getTokenBalance(
              decimals, wallet.value.address!, tokenEntry.contractAddress!);
          newTokenEntry =
              tokenEntry.copyWith(balance: balance, decimals: decimals);
        }
        newList.add(newTokenEntry);
      }
    }

    tokenList.value = newList;
    tokenList.refresh();

    refreshCtrl.refreshCompleted();
  }
}
