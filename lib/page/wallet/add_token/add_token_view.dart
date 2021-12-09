import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_token_logic.dart';

class AddTokenPage extends GetView<AddTokenLogic> {
  const AddTokenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().token_add),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        children: [
          _buildSearchBar(),
          _buildCell(
            title: AppS().token_main_assets,
            onTap: () => Get.toNamed(AppRoutes.walletAssets, arguments: true),
          ),
          _buildCell(
            title: AppS().token_user_all_assets,
            onTap: () => Get.toNamed(AppRoutes.walletAssets, arguments: false),
          ),
          // _buildCell(
          //   title: AppS().token_customize,
          //   onTap: () => CoreKitToast.showIconText(text: AppS().app_build_now),
          // ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 33,
      child: CupertinoTextField(
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.search,
        placeholder: AppS().add_token_input,
        maxLines: 1,
        controller: controller.searchEdit,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16.5),
        ),
        prefix: const Padding(
          padding: EdgeInsets.only(
            left: 15,
          ),
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.separator,
          ),
        ),
      ),
    );
  }

  Widget _buildCell({String? title, GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () => onTap!(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17.5),
            color: Colors.white,
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: AppTheme.of(Get.context!).chevronRightColor,
                ),
              ],
            ),
          ),
          const Divider(
            indent: 20,
          ),
        ],
      ),
    );
  }
}
