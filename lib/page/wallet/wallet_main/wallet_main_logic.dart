import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletMainLogic extends GetxController {
  List<TokenEntry> dbTokenList = <TokenEntry>[];
  final walletList = <WalletEntry>[].obs;
  final tokenList = <TokenEntry>[].obs;
  final wallet = WalletEntry(id: 0).obs;
  final showAddress = ''.obs;

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
    Clipboard.setData(ClipboardData(text: wallet.value.address??''));
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
   * 删除代币地址弹框
   * @author Will
   * @date 2021/11/18 14:32
   * @param entry 钱包实体类
   */
  void onDelWallet(TokenEntry tokenEntry) async {
    CustomDialog.showCustomDialog(
      Get.context!,
      dialogWidget(tokenEntry),
      isShowCloseBtn: false,
      borderRadius: BorderRadius.circular(20),
    );
  }

  /**
   * 删除代币地址视图
   * @author Will
   * @date 2021/11/18 14:32
   * @param entry 钱包实体类
   */
  Widget dialogWidget(TokenEntry tokenEntry) {
    final width = Get.width * 339 / 375;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          const SizedBox(
            height: 23,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              AppS().wallet_del_coin_tips,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 28.5,
          ),
          Row(
            children: [
              CoreKitStyle.cupertinoButton(
                Get.context!,
                backgroundColor: const Color(0xFFE9E9E9),
                title: AppS().app_cancel,
                titleStyle: const TextStyle(color: Color(0xFF666666)),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                onPressed: () => Get.back(),
                width: width / 2,
              ),
              CoreKitStyle.cupertinoButton(
                Get.context!,
                title: AppS().app_confirm,
                onPressed: () => onDel(tokenEntry),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                width: width / 2,
              ),
            ],
          )
        ],
      ),
    );
  }

  /**
   * 删除代币地址方法
   * @author Will
   * @date 2021/11/18 14:33
   * @param entry 钱包实体类
   */
  void onDel(TokenEntry tokenEntry) {
    //先关闭弹窗
    Get.back();

    if (tokenEntry.is_main_coin != null && tokenEntry.is_main_coin!) {
      CoreKitToast.showError(AppS().wallet_del_coin_err);
      return;
    }

    tokenList.remove(tokenEntry);
    WalletService.to.appDate.deleteToken(tokenEntry);
  }
}
