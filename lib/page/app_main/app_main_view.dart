import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/widget/app_cupertino_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_main_logic.dart';

class AppMainPage extends GetView<AppMainLogic> {
  const AppMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.bodyWidget[controller.chooseIndex.value],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  // 底部导航
  AppCupertinoTabBar _buildBottomNavigationBar() {
    return AppCupertinoTabBar(
      backgroundColor: AppTheme.of(Get.context!).tabBarBackgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            Res.ic_wallet,
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            Res.ic_wallet_select,
            width: 25,
            height: 25,
          ),
          label: AppS().wallet,
          backgroundColor: CupertinoTheme.of(Get.context!).barBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Res.ic_profile,
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            Res.ic_profile_selcet,
            width: 25,
            height: 25,
          ),
          label: AppS().profile,
          backgroundColor: CupertinoTheme.of(Get.context!).barBackgroundColor,
        ),
      ],
      currentIndex: controller.chooseIndex.value,
      activeColor: CupertinoTheme.of(Get.context!).primaryColor,
      border: const Border(
        top: BorderSide(
          color: Colors.white,
          width: 0.0, // One physical pixel.
          style: BorderStyle.solid,
        ),
      ),
      onTap: (value) {
        controller.chooseIndex.value = value;
        // switch (value) {
        //   case 0:
        //     routerDelegate.toNamed(AppRoutes.Home);
        //     break;
        //   case 1:
        //     routerDelegate.toNamed(AppRoutes.ProFile);
        //     break;
        //   default:
        // }
      },
    );
  }
}
