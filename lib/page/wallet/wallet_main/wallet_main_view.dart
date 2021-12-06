import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/page/wallet/wallet_management_widget/wallet_management_widget_view.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'wallet_main_logic.dart';

class WalletMainPage extends GetView<WalletMainLogic> {
  const WalletMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        leading: InkWell(
          onTap: () => onShowMoreWallet(),
          child: Container(
            height: kMinInteractiveDimensionCupertino,
            width: kMinInteractiveDimensionCupertino,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              Res.ic_choose,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
      child: Obx(
        () => SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(),
          controller: controller.refreshCtrl,
          onRefresh: () => controller.onRefreshFun(),
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() {
    return ListView.builder(
      itemBuilder: (c, i) {
        switch (i) {
          case 0:
            return _buildWalletMain();
          case 1:
            return const SizedBox(
              height: 15,
            );
          case 2:
            return _buildAssets();
          default:
            final tokenEntry = controller.tokenList[i - 3];
            return _buildCell(
              title: tokenEntry.coinKey,
              imageUrl: tokenEntry.imageUrl,
              balance: tokenEntry.balance,
              totalMoney: tokenEntry.totalMoney,
              onTap: () =>
                  Get.toNamed(AppRoutes.tokenDetails, arguments: tokenEntry),
            );
        }
      },
      itemCount: controller.tokenList.length + 3,
    );
  }

  Widget _buildWalletMain() {
    return Container(
      width: Get.width - 15 * 2,
      height: Get.width * 108 / 375,
      decoration: BoxDecoration(
        color: const Color(0xFF0F6EFF),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => controller.onShowDetails(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    controller.wallet.value.name ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Image.asset(
                  Res.ic_more,
                  width: 14,
                  height: 3,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Obx(
            () => InkWell(
              onTap: () => controller.onCopy(),
              child: Text(
                controller.showAddress.value,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppS().wallet_assets,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => controller.onAddAssets(),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.centerRight,
              child: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
      {required String? title,
      String? imageUrl,
      String? balance,
      String? totalMoney,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CoreKitStyle.image(imageUrl!, size: 40),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      balance ?? '',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      totalMoney ?? '',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF878889),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            indent: 71,
          ),
        ],
      ),
    );
  }

  void onShowMoreWallet() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) {
        return Container(
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          height: Get.height * 2 / 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          CupertinoIcons.clear,
                          color: Colors.black,
                          size: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppS().wallet_choose,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.walletManagement);
                      },
                      child: Text(
                        AppS().profile_wallet_management,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Expanded(
                child: WalletManagementWidgetPage(
                  isDialog: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
