import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'confirm_mnemonic_logic.dart';

class ConfirmMnemonicPage extends GetView<ConfirmMnemonicLogic> {
  const ConfirmMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().confirm_mnemonic),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        trailing: InkWell(
          onTap: () => controller.onGetMnemonics(),
          child: Container(
            height: 44,
            width: 80,
            alignment: Alignment.centerRight,
            child: const Icon(
              CupertinoIcons.refresh_thick,
              size: 25,
            ),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Text(
            AppS().confirm_mnemonic_sequence,
          ),
          const SizedBox(
            height: 25,
          ),
          _buildMnemonicWidget(),
          const SizedBox(
            height: 25,
          ),
          _buildRandomWidget(),
          const SizedBox(
            height: 25,
          ),
          Obx(() => _buildBtn()),
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
    String title = '';
    if (controller.chooseList.isNotEmpty &&
        controller.chooseList.length > index) {
      title = controller.chooseList[index];
    }

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

  Widget _buildRandomWidget() {
    return Obx(
      () => controller.randomList.isEmpty
          ? Container()
          : Wrap(
              spacing: 7.5,
              runSpacing: 7.5,
              children: [
                for (int i = 0; i < controller.randomList.length; i++)
                  _buildMnemonicRandom(i)
              ],
            ),
    );
  }

  Widget _buildMnemonicRandom(int index) {
    final width = (Get.width - 15 * 2 - 8 * 2) / 3;
    final String title = controller.randomList[index];
    return InkWell(
      onTap: () => controller.onRemove(index, title),
      child: Container(
        width: width,
        height: 55,
        decoration: BoxDecoration(
          color: AppTheme.of(Get.context!).inputBgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }

  Widget _buildBtn() {
    if (controller.chooseList.isEmpty) {
      return CoreKitStyle.cupertinoButton(
        Get.context!,
        title: AppS().back_up_mnemonic_confirm,
        onPressed: () => controller.onCheckMnemonics(),
      );
    } else {
      final width = Get.width - 15 * 2;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CoreKitStyle.cupertinoButton(
            Get.context!,
            width: (width - 15) / 3 * 2,
            title: AppS().back_up_mnemonic_confirm,
            onPressed: () => controller.onCheckMnemonics(),
          ),
          InkWell(
            onTap: () => controller.onDelChoose(),
            child: Container(
              height: 44,
              width: (width - 15) / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: CupertinoTheme.of(Get.context!).primaryColor,
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.delete_left,
              ),
            ),
          ),
        ],
      );
    }
  }
}
