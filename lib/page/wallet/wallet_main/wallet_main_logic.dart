import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late Worker tokenWorker;

  @override
  void onInit() async {
    super.onInit();

    dbTokenList = await WalletService.to.appDate.getAllToken();

    wallet.value = WalletService.to.wallet.value;
    getToken(wallet.value);

    //监听钱包的变化
    worker = ever(WalletService.to.wallet, handleWalletChanged);
    //监听token的变化
    tokenWorker = ever(AppService.to.tokenList, handleTokenChanged);
    onShow();
  }

  @override
  void onClose() {
    //释放当前页面的监听事件
    worker.dispose();
    tokenWorker.dispose();
    super.onClose();
  }

  /**
   * 监听Token变换的事件
   * @author Will
   * @date 2021/11/18 15:05
   * @param _wallet 钱包实体类
   */
  void handleTokenChanged(_token) async {
    dbTokenList = await WalletService.to.appDate.getAllToken();
    //主要是通过刷新去获取新的代币余额
    onRefreshFun();
  }

  /**
   * 监听钱包变换的事件
   * @author Will
   * @date 2021/11/18 15:05
   * @param _wallet 钱包实体类
   */
  void handleWalletChanged(_wallet) async {
    wallet.value = WalletService.to.wallet.value;
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
    showAddress.value = TokenService.formattingAddress(wallet.value.address!);
  }

  void onChoose() {}

  /**
   * 跳转详情
   * @author Will
   * @date 2021/11/17 17:10
   */
  void onShowDetails() async {
    final data =
        await Get.toNamed(AppRoutes.walletDetails, arguments: wallet.value);
    if (data != null && data is WalletEntry) {
      wallet.value = data;
      wallet.refresh();
    }
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

  /**
   * 获取代币
   * @author Will
   * @date 2021/11/25 17:10
   */
  void getToken(WalletEntry walletEntry) async {
    final newList = <TokenEntry>[];
    for (final tokenEntry in dbTokenList) {
      if (tokenEntry.protocol == walletEntry.protocol) {
        newList.add(tokenEntry);
      }
    }
    tokenList.value = newList;
  }

  void onRefreshFun() async {
    final newList = <TokenEntry>[];
    for (final tokenEntry in dbTokenList) {
      TokenEntry newTokenEntry = TokenEntry(id: 0, wallet_id: 0);
      if (tokenEntry.protocol == wallet.value.protocol) {
        if (tokenEntry.contractAddress == null) {
          //这个是主币 所以 获取主币的余额
          final balance = await TokenService.getBalance(wallet.value.address!);
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

    refreshCtrl.refreshCompleted();
  }
}
