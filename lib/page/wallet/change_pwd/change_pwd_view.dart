import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'change_pwd_logic.dart';

class ChangePwdPage extends GetView<ChangePwdLogic> {
  const ChangePwdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet_export_change_pwd),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(
              height: 25,
            ),
            _buildCell(
              title: AppS().change_page_now_pwd,
              controller: controller.oldPwdEdit,
              visible: controller.oldPwdVisible.value,
              placeholder: AppS().change_page_now_pwd_input,
              onPressed: () => controller.obscureOldPwd(),
            ),
            const SizedBox(
              height: 12,
            ),
            _buildCell(
              title: AppS().change_page_new_pwd,
              controller: controller.newPwdEdit,
              visible: controller.newPwdVisible.value,
              placeholder: AppS().change_page_new_pwd_input,
              onPressed: () => controller.obscureNewPwd(),
            ),
            const SizedBox(
              height: 12,
            ),
            _buildCell(
              title: AppS().change_page_confirm_pwd,
              controller: controller.confirmPwdEdit,
              visible: controller.confirmVisible.value,
              placeholder: AppS().change_page_confirm_pwd_input,
              onPressed: () => controller.obscureConfirmPwd(),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              AppS().creat_wallet_pwd_tips,
              style: TextStyle(
                  color: CupertinoTheme.of(context).primaryColor, fontSize: 13),
            ),
            const SizedBox(
              height: 50,
            ),
            CoreKitStyle.cupertinoButton(
              context,
              title: AppS().change_page_confirm,
              onPressed: () => controller.onCheck(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell({
    String? title,
    TextEditingController? controller,
    bool? visible,
    String? placeholder,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: Get.width - 15 * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF121212),
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.next,
              placeholder: placeholder,
              placeholderStyle: TextStyle(
                  color: AppTheme.of(Get.context!).unChooesTextColor,
                  fontSize: 15),
              maxLines: 1,
              controller: controller,
              padding: const EdgeInsets.only(left: 15, right: 0),
              obscureText: visible!,
              // 输入框内容padding值
              decoration: BoxDecoration(
                // 文本框装饰
                color: AppTheme.of(Get.context!).inputBgColor, // 文本框颜色// 输入框边框
                borderRadius:
                    const BorderRadius.all(Radius.circular(0)), // 输入框圆角设置/装饰阴影
              ),
              suffix: IconButton(
                icon: Icon(
                  //根据passwordVisible状态显示不同的图标
                  visible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: visible
                      ? const Color(0xff999999)
                      : CupertinoTheme.of(Get.context!).primaryColor,
                ),
                onPressed: () => onPressed!(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
