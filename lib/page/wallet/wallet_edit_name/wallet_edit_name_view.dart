import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wallet_edit_name_logic.dart';

class WalletEditNamePage extends GetView<WalletEditNameLogic> {
  const WalletEditNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet_edit_name),
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
            AppS().wallet_edit_name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: controller.nameEdit,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: AppS().wallet_edit_name_input,

              ///设置输入框可编辑时的边框样式
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(
                  color: AppTheme.of(context).inputBgColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(
                  color: CupertinoTheme.of(context).primaryContrastingColor,
                  width: 1,
                ),
              ),

              fillColor: AppTheme.of(context).inputBgColor,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            AppS().wallet_edit_tips,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 74,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().app_confirm,
            onPressed: () => controller.onUpdateWalletName(),
          ),
        ],
      ),
    );
  }
}
