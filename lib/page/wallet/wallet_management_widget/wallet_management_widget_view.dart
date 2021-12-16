import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wallet_management_widget_logic.dart';

class WalletManagementWidgetPage extends StatefulWidget {
  const WalletManagementWidgetPage({Key? key, required this.isDialog})
      : super(key: key);

  final bool? isDialog;
  @override
  _WalletManagementWidgetPageState createState() =>
      _WalletManagementWidgetPageState();
}

class _WalletManagementWidgetPageState
    extends State<WalletManagementWidgetPage> {
  final logic = Get.put(WalletManagementWidgetLogic());

  @override
  void initState() {
    super.initState();
    logic.isDialog.value = widget.isDialog!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 76,
          child: Container(
            color: const Color(0xFFF1F5F6),
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildItems(
                      selectIcon: Res.ic_wallet_all_select,
                      icon: Res.ic_wallet_all,
                      btnTag: '0',
                    );
                  } else {
                    final info = logic.serverSupportMainCoin[index - 1];
                    String selectIcon = '';
                    String icon = '';
                    switch (info.protocol) {
                      case 'ERC20':
                        selectIcon = Res.ic_eth_select;
                        icon = Res.ic_eth;
                        break;
                      case 'TRC20':
                        selectIcon = Res.ic_btc_select;
                        icon = Res.ic_btc;
                        break;
                      case 'ARC20':
                        selectIcon = Res.ic_aaa_select;
                        icon = Res.ic_aaa;
                        break;
                    }

                    return _buildItems(
                      selectIcon: selectIcon,
                      icon: icon,
                      btnTag: info.protocol!,
                    );
                  }
                },
                itemCount: logic.serverSupportMainCoin.length + 1,
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                final info = logic.walletList[index];
                return _buildCell(info);
              },
              itemCount: logic.walletList.length,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItems({
    required String selectIcon,
    required String icon,
    required String btnTag,
  }) {
    return InkWell(
      onTap: () {
        logic.btnTag.value = btnTag;
        logic.onGetAllWallet();
        logic.serverSupportMainCoin.refresh();
      },
      child: Container(
        width: 76,
        height: 76,
        alignment: Alignment.center,
        color: logic.btnTag.value == btnTag
            ? Colors.white
            : const Color(0xFFF1F5F6),
        child: Image.asset(
          logic.btnTag.value == btnTag ? selectIcon : icon,
          width: 32,
          height: 32,
        ),
      ),
    );
  }

  Widget _buildCell(WalletEntry walletEntry) {
    Color bgColor = const Color(0xFF088FC3);
    switch (walletEntry.protocol) {
      case 'ERP20':
        bgColor = const Color(0xFF088FC3);
        break;
      case 'TRC20':
        bgColor = const Color(0xFFFE9E00);
        break;
      case 'ARC20':
        bgColor = const Color(0xFF088FC3);
        break;
    }
    return InkWell(
      onTap: () => logic.onChoose(walletEntry),
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    walletEntry.name ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 14,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              TokenService.formattingAddress(walletEntry.address ?? ''),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WalletManagementWidgetLogic>();
    super.dispose();
  }
}
