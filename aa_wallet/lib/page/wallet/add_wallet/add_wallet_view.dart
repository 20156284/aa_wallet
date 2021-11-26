import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_wallet_logic.dart';

class AddWalletPage extends GetView<AddWalletLogic> {
  const AddWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().add_wallet_choose_coin_type),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          _buildCell(
            title: AppS().add_wallet_eth,
            subTitle: AppS().add_wallet_eth_subtitle,
            icon: Res.ic_eth_select,
            onTap: () =>
                Get.toNamed(AppRoutes.chooseCreatWallet, arguments: 'ETH'),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildCell(
            title: AppS().add_wallet_btc,
            subTitle: AppS().add_wallet_btc_subtitle,
            icon: Res.ic_btc_select,
            onTap: () =>
                Get.toNamed(AppRoutes.chooseCreatWallet, arguments: 'BTC'),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildCell(
            title: AppS().add_wallet_aac,
            subTitle: AppS().add_wallet_aac_subtitle,
            icon: Res.ic_aaa_select,
            onTap: () =>
                Get.toNamed(AppRoutes.chooseCreatWallet, arguments: 'AAC'),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
      {String? title,
      String? subTitle,
      String? icon,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17.5),
        color: Colors.white,
        child: Row(
          children: [
            Image.asset(
              icon!,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 3.5,
                  ),
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subTitle ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3.5,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
