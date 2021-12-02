import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wallet_assets_logic.dart';

class WalletAssetsPage extends GetView<WalletAssetsLogic> {
  const WalletAssetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Obx(
          () => Text(
            controller.isManagement.value
                ? AppS().token_main_assets
                : AppS().token_user_all_assets,
          ),
        ),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        children: [],
      ),
    );
  }
}
