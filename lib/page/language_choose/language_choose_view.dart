import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'language_choose_logic.dart';

class LanguageChoosePage extends GetView<LanguageChooseLogic> {
  const LanguageChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(
          width: 0.0,
          style: BorderStyle.none,
        ),
        middle: Text(AppS().language_choose),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 31),
          itemBuilder: (BuildContext context, int index) {
            final info = controller.langList[index];
            return _buildCell(info);
          },
          itemCount: controller.langList.length,
        ),
      ),
    );
  }

  /**
   * 放置每个子视图
   * @author Will
   * @date 2021/11/16 16:04
   * @param 语言对象
   * @return 返回Widget
   */
  Widget _buildCell(LanguageInfo info) {
    return InkWell(
      onTap: () => controller.onChooseLanguage(info),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              info.icon ?? Res.ic_en_us,
              width: 24,
              height: 24,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(info.name ?? 'English'),
            ),
            if (info == controller.chooseLang.value)
              const Icon(
                CupertinoIcons.check_mark,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
