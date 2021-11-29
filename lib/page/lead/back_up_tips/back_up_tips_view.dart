import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'back_up_tips_logic.dart';

class BackUpTipsPage extends GetView<BackUpTipsLogic> {
  const BackUpTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().back_up_tips),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Text(
            AppS().back_up_tips,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildTipsContent(title: AppS().back_up_tips_content1),
          const SizedBox(
            height: 10,
          ),
          _buildTipsContent(title: AppS().back_up_tips_content2),
          const SizedBox(
            height: 10,
          ),
          _buildTipsContent(title: AppS().back_up_tips_content3),
          SizedBox(
            height: Get.width * 113 / 375,
          ),
          Image.asset(
            Res.ic_no_screenshots,
            width: 68.5,
            height: 62,
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              AppS().back_up_do_not_screen_capture1,
              style: TextStyle(
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          Text(
            AppS().back_up_do_not_screen_capture2,
          ),
          SizedBox(
            height: Get.width * 172.5 / 375,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().app_confirm,
            onPressed: () => controller.onGotoMnemonic(),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsContent({String? title}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoTheme.of(Get.context!).primaryColor,
          ),
          width: 10,
          height: 10,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: Text(title ?? '')),
      ],
    );
  }
}
