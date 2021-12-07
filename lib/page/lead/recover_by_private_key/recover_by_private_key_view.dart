import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'recover_by_private_key_logic.dart';

class RecoverByPrivateKeyPage extends GetView<RecoverByPrivateKeyLogic> {
  const RecoverByPrivateKeyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().recover_wallet_title),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            AppS().recover_wallet_private_key,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: controller.privateEdit,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: AppS().recover_import_private_key,

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
            maxLines: 5,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            AppS().creat_wallet_name,
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
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              labelText: AppS().creat_wallet_name_input,

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
            onChanged: (val) {
              WalletService.to.walletName.value = val;
            },
          ),
          const SizedBox(
            height: 33,
          ),
          Text(
            AppS().creat_wallet_pwd,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => TextField(
              controller: controller.pwdEdit,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: controller.pwdVisible.value,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                labelText: AppS().creat_wallet_pwd_input,

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
                suffixIcon: IconButton(
                  icon: Icon(
                    //根据passwordVisible状态显示不同的图标
                    controller.pwdVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: controller.pwdVisible.value
                        ? const Color(0xff999999)
                        : CupertinoTheme.of(context).primaryColor,
                  ),
                  onPressed: () => controller.obscurePwd(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => TextField(
              controller: controller.repeatPwdEdit,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: controller.repeatVisible.value,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                labelText: AppS().creat_wallet_repeat_pwd_input,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 0.5),
                ),

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
                suffixIcon: IconButton(
                  icon: Icon(
                    //根据passwordVisible状态显示不同的图标
                    controller.repeatVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: controller.repeatVisible.value
                        ? const Color(0xff999999)
                        : CupertinoTheme.of(context).primaryColor,
                  ),
                  onPressed: () => controller.obscureRepeat(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppS().creat_wallet_pwd_tips,
            style: TextStyle(
                color: CupertinoTheme.of(context).primaryColor, fontSize: 13),
          ),
          const SizedBox(
            height: 35,
          ),
          CoreKitStyle.cupertinoButton(
            context,
            title: AppS().app_confirm,
            onPressed: () => controller.onCheck(),
          ),
        ],
      ),
    );
  }
}
