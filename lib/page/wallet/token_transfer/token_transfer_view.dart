import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'token_transfer_logic.dart';

class TokenTransferPage extends GetView<TokenTransferLogic> {
  const TokenTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().token_details_transfer),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        trailing: InkWell(
          onTap: () => controller.getPermission(Permission.camera),
          child: Container(
            height: kMinInteractiveDimensionCupertino,
            width: kMinInteractiveDimensionCupertino,
            alignment: Alignment.centerRight,
            child: Image.asset(
              Res.ic_scan,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              Text(
                AppS().token_transfer_addr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: controller.addrEdit,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: AppS().token_transfer_addr_input,

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
                height: 25,
              ),
              Text(
                AppS().token_transfer_money,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: controller.moneyEdit,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: AppS().token_transfer_money_input,

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
              // const SizedBox(
              //   height: 25,
              // ),
              // Text(
              //   AppS().token_transfer_fee,
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // Obx(
              //   () => SizedBox(
              //     width: Get.width - 15 * 2,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         _buildBtn(
              //           title: AppS().token_transfer_slow,
              //           money: AppS().token_transfer_slow_info('000175'),
              //           btnTag: 0,
              //         ),
              //         _buildBtn(
              //           title: AppS().token_transfer_recommend,
              //           money: AppS().token_transfer_recommend_info('000175'),
              //           btnTag: 1,
              //         ),
              //         _buildBtn(
              //           title: AppS().token_transfer_quick,
              //           money: AppS().token_transfer_quick_info('000175'),
              //           btnTag: 2,
              //         ),
              //         _buildBtn(
              //           title: AppS().token_transfer_customize,
              //           btnTag: 3,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 15,
            child: SafeArea(
              child: CoreKitStyle.cupertinoButton(
                context,
                width: Get.width - 15 * 2,
                title: AppS().app_confirm,
                onPressed: () => controller.onCheck(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn({
    String? title,
    String? money,
    int? btnTag,
  }) {
    final width = (Get.width - 15 * 2 - 11 * 3) / 4;

    return InkWell(
      onTap: () {
        controller.chooseTag.value = btnTag!;
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: controller.chooseTag.value == btnTag
                  ? const Color(0xFF0F6EFF)
                  : const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(3.5),
            width: width,
            height: 78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: controller.chooseTag.value == btnTag
                        ? Colors.white
                        : const Color(0xFF444444),
                  ),
                ),
                if (money != null)
                  const SizedBox(
                    height: 5,
                  ),
                if (money != null)
                  Text(
                    money,
                    style: TextStyle(
                      fontSize: 11,
                      color: controller.chooseTag.value == btnTag
                          ? Colors.white
                          : const Color(0xFF444444),
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          if (controller.chooseTag.value == btnTag)
            const Positioned(
              right: 5,
              top: 5,
              child: Icon(
                CupertinoIcons.checkmark_circle,
                size: 15,
                color: Colors.white,
              ),
            )
        ],
      ),
    );
  }
}
