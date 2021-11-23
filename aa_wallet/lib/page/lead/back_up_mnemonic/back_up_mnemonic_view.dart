import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'back_up_mnemonic_logic.dart';

class BackUpMnemonicPage extends GetView<BackUpMnemonicLogic> {
  const BackUpMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().back_up_mnemonic_title),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Text(
            AppS().back_up_mnemonic,
          ),
          const SizedBox(
            height: 25,
          ),
          _buildMnemonicWidget(),
          SizedBox(
            height: Get.width * 216 / 375,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Res.ic_tips,
                width: 20,
                height: 20,
              ),
              Text(
                AppS().app_tips,
                style: const TextStyle(color: AppTextTheme.color5),
              ),
            ],
          ),
          Text(
            AppS().back_up_mnemonic_tips,
            style: const TextStyle(fontSize: 13, color: AppTextTheme.color4),
          ),
          const SizedBox(
            height: 20,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().back_up_mnemonic_confirm,
            onPressed: () => controller.onGotoConfirm(),
          ),
        ],
      ),
    );
  }

  Widget _buildMnemonicWidget() {
    return Obx(
      () => controller.mnemonicsList.isEmpty
          ? Container()
          : Container(
              decoration: BoxDecoration(
                color: AppTheme.of(Get.context!).inputBgColor,
                border: Border.all(
                  color:
                      CupertinoTheme.of(Get.context!).primaryContrastingColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Wrap(
                children: [
                  for (int i = 0; i < controller.mnemonicsList.length; i++)
                    _buildMnemonicItems(i)
                ],
              ),
            ),
    );
  }

  Widget _buildMnemonicItems(int index) {
    final width = (Get.width - 15 * 2 - 2) / 3;
    final String title = controller.mnemonicsList[index];
    return Container(
      width: width,
      height: 55,
      decoration: BoxDecoration(
        color: AppTheme.of(Get.context!).inputBgColor,
        border: Border.all(
          color: CupertinoTheme.of(Get.context!).primaryContrastingColor,
          width: 0,
        ),
        borderRadius: controller.onMnemonic(index),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(title),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5, top: 5),
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 11,
                  color:
                      CupertinoTheme.of(Get.context!).primaryContrastingColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
