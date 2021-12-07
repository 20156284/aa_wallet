// ===============================================
// wallet_service
//
// Create by will on 2021/11/18 14:35
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:ui';

import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletService extends GetxService {
  static WalletService get to => Get.find();

  final protocol = 'ARC20'.obs;

  final appDate = AppDatabase();
  //当前App默认的钱包
  final wallet = WalletEntry(id: 0).obs;

  final walletName = 'AAC'.obs;
  final password = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    final List<WalletEntry> walletList = await appDate.getAllWallets();

    for (final walletEntry in walletList) {
      if (walletEntry.is_main!) {
        wallet.value = walletEntry;
        break;
      }
    }
  }

  /**
   * 读取所有的钱包
   * @author Will
   * @date 2021/11/17 14:15
   */
  Future<void> onReadWallet() async {
    final List<WalletEntry> walletList = await appDate.getAllWallets();

    for (final walletEntry in walletList) {
      if (walletEntry.is_main!) {
        wallet.value = walletEntry;
        break;
      }
    }
  }

  /**
   * 删除钱包地址弹框
   * @author Will
   * @date 2021/11/18 14:32
   * @param entry 钱包实体类
   */
  void onDelWallet(WalletEntry entry) async {
    CustomDialog.showCustomDialog(
      Get.context!,
      dialogWidget(entry),
      isShowCloseBtn: false,
      borderRadius: BorderRadius.circular(20),
    );
  }

  /**
   * 删除钱包地址视图
   * @author Will
   * @date 2021/11/18 14:32
   * @param entry 钱包实体类
   */
  Widget dialogWidget(WalletEntry entry) {
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
              AppS().wallet_del_only,
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
                onPressed: () => onDel(entry),
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
   * 删除钱包地址方法
   * @author Will
   * @date 2021/11/18 14:33
   * @param entry 钱包实体类
   */
  void onDel(WalletEntry entry) async {
    //先关闭弹窗
    Get.back();
    final del = await appDate.deleteWallet(entry);
    if (del != null) {}
    final List<WalletEntry> walletList = await appDate.getAllWallets();
    if (walletList.isEmpty) {
      Get.offAllNamed(AppRoutes.lead);
    } else {
      final WalletEntry walletEntry = walletList.first.copyWith(is_main: true);
      await appDate.updateWallet(walletEntry);
      //设置当前的钱包为主钱包
      wallet.value = walletEntry;
    }
  }

  /**
   * 更新钱包
   * @author Will
   * @date 2021/11/30 17:59
   * @param entry 钱包对象
   */
  Future<bool> onUpdateWallet(WalletEntry entry) {
    return appDate.updateWallet(entry);
  }
}
