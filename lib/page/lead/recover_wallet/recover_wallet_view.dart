import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'recover_wallet_logic.dart';

class RecoverWalletPage extends GetView<RecoverWalletLogic> {
  const RecoverWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().recover_wallet_title),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        children: [
          _buildCell(
            icon: Res.ic_mnemonic,
            title: AppS().recover_wallet_mnemonic,
            subTitle: AppS().recover_wallet_import_mnemonic,
            onTap: () => Get.toNamed(AppRoutes.recoverByMnemonic),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildCell(
            icon: Res.ic_private_key,
            title: AppS().recover_wallet_private_key,
            subTitle: AppS().recover_wallet_import_private_key,
            onTap: () => Get.toNamed(AppRoutes.recoverByPrivateKey),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
      {required String? icon,
      String? title,
      String? subTitle,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              icon!,
              width: 65,
              height: 65,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subTitle ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
