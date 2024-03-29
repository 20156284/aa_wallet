import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_page_logic.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfilePageLogic logic = Get.put(ProfilePageLogic());
  

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().profile),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          _buildCell(
            title: AppS().language_choose,
            icon: Res.ic_choose_lang,
            onTap: () => Get.toNamed(AppRoutes.languageChoose),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Divider(),
          ),
          _buildCell(
            title: AppS().profile_update_record,
            icon: Res.ic_update_record,
            subTitle: _buildVersion(),
            onTap: () => Get.toNamed(AppRoutes.updateRecord),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildCell(
            title: AppS().profile_wallet_management,
            icon: Res.ic_wallet_management,
            onTap: () => Get.toNamed(AppRoutes.walletManagement),
          ),
        ],
      ),
    );
  }

  Widget _buildVersion() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => Text(
                AppS().app_version(logic.version.value),
                style: const TextStyle(
                    fontSize: 12, color: CupertinoColors.systemGrey),
              ),
            ),
            Obx(
              () => Text(
                AppS().app_build(logic.buildNumber.value),
                style: const TextStyle(
                    fontSize: 12, color: CupertinoColors.systemGrey),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildCell({
    required String? title,
    Widget? subTitle,
    String? icon,
    GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              icon!,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title ?? '',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            if (subTitle != null) subTitle,
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
