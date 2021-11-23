import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wallet_details_logic.dart';

class WalletDetailsPage extends GetView<WalletDetailsLogic> {
  const WalletDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet_details_title),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        children: [
          _buildWalletTop(),
          const SizedBox(
            height: 15,
          ),
          _buildCell(
            title: AppS().wallet_export_mnemonic,
            onTap: () => controller.onExport(ExportType.Mnemonic),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildCell(
            title: AppS().wallet_export_private_key,
            onTap: () => controller.onExport(ExportType.Pwd),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildCell(
            title: AppS().wallet_export_change_pwd,
          ),
          const SizedBox(
            height: 15,
          ),
          _buildCell(
            title: AppS().wallet_export_reset_pwd,
          ),
          SizedBox(
            height: Get.width * 202 / 375,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().wallet_del,
            onPressed: () => controller.onDelWallet(),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletTop() {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(Get.context!).primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => controller.onUpdateWall(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Text(
                    controller.wallet.value.name,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  Res.ic_edit,
                  width: 15,
                  height: 15,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => controller.onCopy(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => Expanded(
                    child: Text(
                      controller.showAddress.value,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  Res.ic_copy,
                  width: 15,
                  height: 15,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              Res.ic_img,
              width: 35.5,
              height: 22,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCell({required String? title, GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                title ?? '',
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFF999999),
            )
          ],
        ),
      ),
    );
  }
}
