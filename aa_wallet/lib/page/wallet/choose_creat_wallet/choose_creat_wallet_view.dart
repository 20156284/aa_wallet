import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_creat_wallet_logic.dart';

class ChooseCreatWalletPage extends GetView<ChooseCreatWalletLogic> {
  const ChooseCreatWalletPage({Key? key}) : super(key: key);

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
            icon: Res.ic_creat_wallet,
            title: AppS().creat_wallet_title,
            onTap: () => Get.toNamed(AppRoutes.creatWallet),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildCell(
            icon: Res.ic_recover_wallet,
            title: AppS().recover_wallet_title,
            onTap: () => Get.toNamed(AppRoutes.recoverWallet),
          ),
        ],
      ),
    );
  }

  Widget _buildCell({String? title, String? icon, GestureTapCallback? onTap}) {
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
              child: Text(
                title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
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
