import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lead_logic.dart';

class LeadPage extends GetView<LeadLogic> {
  const LeadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopBg(),
            const SizedBox(
              height: 20,
            ),
            _buildItems(
              icon: Res.ic_creat_wallet,
              title: AppS().creat_wallet_title,
              subTitle: AppS().creat_wallet_content,
              onTap: () => Get.toNamed(AppRoutes.creatWallet),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            _buildItems(
              icon: Res.ic_recover_wallet,
              title: AppS().recover_wallet_title,
              subTitle: AppS().recover_wallet_content,
              onTap: () => Get.toNamed(AppRoutes.recoverWallet),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBg() {
    return Container(
      height: Get.width * 345 / 375,
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Res.ic_main,
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      padding: EdgeInsets.only(top: Get.width * 54 / 375),
      child: Column(
        children: [
          InkWell(
            onTap: () => controller.onGotoLanguagePage(),
            child: Container(
              width: Get.width,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 21),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    controller.languageInfo.value.icon ?? Res.ic_en_us,
                    width: 24,
                    height: 24,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(controller.languageInfo.value.name ?? 'English'),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            AppS().creat_wallet_fist,
            style: const TextStyle(
                color: Color(0xFF23262F),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildItems(
      {required String? icon,
      String? title,
      String? subTitle,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
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
                        color: Color(0xFF444444),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subTitle ?? '',
                    style: const TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.right_chevron,
              // color: AppTheme.of(Get.context!).dividerColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
