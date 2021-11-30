import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/page/wallet/wallet_management_widget/wallet_management_widget_view.dart';
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
      child: const WalletManagementWidgetPage(
        isDialog: false,
      ),
    );
  }
}
