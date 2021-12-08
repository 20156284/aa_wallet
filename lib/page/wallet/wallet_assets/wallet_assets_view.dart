import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        final walletEntry = controller.dbWalletList[i];
        return _buildItems(walletEntry);
      },
      itemCount: controller.dbWalletList.length,
    );
  }

  Widget _buildItems(WalletEntry walletEntry) {
    String icon = '';
    switch (walletEntry.protocol!) {
      case 'ERC20':
        icon = Res.ic_eth_select;
        break;
      case 'TRC20':
        icon = Res.ic_btc_select;
        break;
      case 'ARC20':
        icon = Res.ic_aaa_select;
        break;
    }
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Slidable(
        key: Key(walletEntry.id.toString()),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                icon,
                width: 27.5,
                height: 27.5,
              ),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletEntry.name ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    walletEntry.address ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        endActionPane: controller.isManagement.value == true
            ? ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                    onDismissed: () => controller.onDel(walletEntry)),
                children: [
                  SlidableAction(
                    onPressed: (context) => controller.onDel(walletEntry),
                    backgroundColor: const Color(0xFFFF5454),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: AppS().app_del,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
