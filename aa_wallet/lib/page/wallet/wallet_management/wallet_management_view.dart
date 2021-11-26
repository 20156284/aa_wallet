import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wallet_management_logic.dart';

class WalletManagementPage extends GetView<WalletManagementLogic> {
  const WalletManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().profile_wallet_management),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        trailing: InkWell(
          onTap: () => Get.toNamed(AppRoutes.addWallet),
          child: Container(
            height: kMinInteractiveDimensionCupertino,
            width: kMinInteractiveDimensionCupertino,
            alignment: Alignment.centerRight,
            child: const Icon(
              CupertinoIcons.add_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 76,
            child: Obx(
              () => Container(
                color: const Color(0xFFF1F5F6),
                child: ListView(
                  children: [
                    _buildItems(
                      selectIcon: Res.ic_eth_select,
                      icon: Res.ic_eth,
                      btnTag: 0,
                      onTap: () {},
                    ),
                    _buildItems(
                      selectIcon: Res.ic_btc_select,
                      icon: Res.ic_btc,
                      btnTag: 1,
                      onTap: () {},
                    ),
                    _buildItems(
                      selectIcon: Res.ic_aaa_select,
                      icon: Res.ic_aaa,
                      btnTag: 2,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: ListView(
          //     children: [],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildItems(
      {String? selectIcon,
      String? icon,
      int? btnTag,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
        controller.btnTag.value = btnTag!;
      },
      child: Container(
        width: 76,
        height: 76,
        alignment: Alignment.center,
        color: controller.btnTag.value == btnTag
            ? Colors.white
            : const Color(0xFFF1F5F6),
        child: Image.asset(
          controller.btnTag.value == btnTag ? selectIcon! : icon!,
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
