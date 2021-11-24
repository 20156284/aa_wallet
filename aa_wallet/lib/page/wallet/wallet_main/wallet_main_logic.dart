import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/core/widget/qr_scan.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

class WalletMainLogic extends GetxController {
  final walletList = <WalletEntry>[].obs;
  final wallet = WalletEntry(
          id: 0,
          name: '',
          password: '',
          mnemonic: '',
          privateKey: '',
          address: '',
          protocol: '',
          rpcUrl: '',
          is_main: false)
      .obs;
  final showAddress = ''.obs;

  late Worker worker;
  @override
  void onInit() {
    super.onInit();
    wallet.value = WalletService.to.wallet.value;
    //监听钱包的变化
    worker = ever(WalletService.to.wallet, handleWalletChanged);
    onShow();
    getBalances();
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
  void handleWalletChanged(_wallet) async {
    wallet.value = WalletService.to.wallet.value;
    wallet.refresh();
    onShow();
    getBalances();
  }

  /**
   * 显示钱包地址做裁剪
   * @author Will
   * @date 2021/11/20 15:55
   */
  void onShow() {
    showAddress.value = TokenService.formattingAddress(wallet.value.address);
  }

  void onChoose() {}

  /**
   * 使用照片之前先获取手机手机权限问题
   * @author Will
   * @date 2021/11/17 17:08
   * @param permission 调用那个权限
   */
  void getPermission(Permission permission) async {
    await permission.request().then((value) async {
      String content = '';
      if (value.index == 1) {
        if (permission == Permission.photos) {}
        if (permission == Permission.camera) {
          final String? str = await CoreQRScan.pushScan(
              context: Get.context!,
              borderColor: CupertinoTheme.of(Get.context!).primaryColor);
          debugPrint(str);
        }
      } else {
        if (permission == Permission.photos) {
          content = AppS().app_permission_photos_close;
        }
        if (permission == Permission.camera) {
          content = AppS().app_permission_camera_close;
        }

        _showCupertinoAlertDialog(content);
      }
    });
  }

  /**
   * 如果没有权限的时候 弹出权限问题的弹窗
   * @author Will
   * @date 2021/11/17 17:08
   * @param content 显示被屏蔽的内容
   */
  void _showCupertinoAlertDialog(String content) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(AppS().app_permission_title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: Text(AppS().app_permission_open),
            onPressed: () async {
              await openAppSettings(); //打开设置页面
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: Text(AppS().app_cancel),
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

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
   * 导出输入密码确认窗
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
          Text(AppS().wallet_import_key_copy_success),
        ],
      ),
    );
  }

  /**
   * 獲取所有主币余额
   * @author Will
   * @date 2021/11/22 15:59
   */
  void getBalances() async {
    final List<String> balances = <String>[];
    walletList.value = await WalletService.to.appDate.getAllWallets();
    for (final wallet in walletList) {
      if (CoreUtil.isNotEmptyString(wallet.rpcUrl)) {
        balances.add(await TokenService.getBalance(wallet.address,
            rpcUrl: wallet.rpcUrl));
      } else {
        balances.add(await TokenService.getBalance(wallet.address));
      }
    }
    print(balances.toString());
    // balance.value = await TokenService.getBalance(wallet.value.address);
    //獲取 主連 餘額 比如說 AAA
    //獲取 ETH 餘額
  }

  /**
   * 添加資產
   * @author Will
   * @date 2021/11/22 15:59
   */
  void onAddAssets() {}
}
