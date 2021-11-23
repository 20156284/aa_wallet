import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'export_private_key_logic.dart';

class ExportPrivateKeyPage extends GetView<ExportPrivateKeyLogic> {
  const ExportPrivateKeyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet_export_private_key),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            AppS().wallet_import_key_tips,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildTipsContent(title: AppS().wallet_import_key_content1),
          const SizedBox(
            height: 10,
          ),
          _buildTipsContent(title: AppS().wallet_import_key_content2),
          const SizedBox(
            height: 35,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Obx(() => Text(controller.privateKey.value)),
          ),
          const SizedBox(
            height: 35,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().wallet_import_key_copy,
            onPressed: () => controller.onCopy(),
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
