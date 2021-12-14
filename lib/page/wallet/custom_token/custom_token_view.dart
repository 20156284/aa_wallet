import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_token_logic.dart';

class CustomTokenPage extends GetView<CustomTokenLogic> {
  const CustomTokenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().token_customize),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        trailing: InkWell(
          onTap: () => controller.onSave(),
          child: Container(
            alignment: Alignment.center,
            width: kMinInteractiveDimensionCupertino,
            height: kMinInteractiveDimensionCupertino,
            child: Text(
              AppS().app_save,
            ),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
        children: [
          Text(AppS().custom_token_addr),
          const SizedBox(
            height: 15,
          ),
          CupertinoTextField(
            textInputAction: TextInputAction.next,
            placeholder: AppS().custom_token_addr_input,
            placeholderStyle: TextStyle(
                color: AppTheme.of(context).unChooesTextColor, fontSize: 15),
            maxLines: 1,
            controller: controller.addressEdit,
            padding: const EdgeInsets.only(left: 0, right: 0),
            // 输入框内容padding值
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(10)), // 输入框圆角设置/装饰阴影
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          Text(AppS().custom_token_symbol),
          const SizedBox(
            height: 15,
          ),
          CupertinoTextField(
            textInputAction: TextInputAction.next,
            placeholder: AppS().custom_token_symbol_input,
            placeholderStyle: TextStyle(
                color: AppTheme.of(context).unChooesTextColor, fontSize: 15),
            maxLines: 1,
            controller: controller.symbolEdit,
            padding: const EdgeInsets.only(left: 0, right: 0),
            // 输入框内容padding值
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(10)), // 输入框圆角设置/装饰阴影
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          Text(AppS().custom_token_decimal),
          const SizedBox(
            height: 15,
          ),
          CupertinoTextField(
            textInputAction: TextInputAction.next,
            placeholder: AppS().custom_token_decimal_input,
            placeholderStyle: TextStyle(
                color: AppTheme.of(context).unChooesTextColor, fontSize: 15),
            maxLines: 1,
            controller: controller.decimalEdit,
            padding: const EdgeInsets.only(left: 0, right: 0),
            // 输入框内容padding值
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(10)), // 输入框圆角设置/装饰阴影
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
