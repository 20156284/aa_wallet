import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'token_details_logic.dart';

class TokenDetailsPage extends GetView<TokenDetailsLogic> {
  const TokenDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          middle: Text(controller.tokenEntry.value.coinKey ?? ''),
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          border: Border.all(width: 0.0, style: BorderStyle.none),
        ),
        child: Stack(
          children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              controller: controller.refreshCtrl,
              onRefresh: () => controller.onRefreshFun(),
              onLoading: () => controller.onLoadingFun(),
              child: _buildChild(),
            ),
            _buildToolBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (c, i) {
        switch (i) {
          case 0:
            return _buildToken();
          case 1:
            return _buildState();
          default:
            return _buildStateCell();
        }
      },
      itemCount: 3,
    );
  }

  Widget _buildToken() {
    return Container(
      width: Get.width - 15 * 2,
      height: Get.width * 140 / 375,
      decoration: BoxDecoration(
        color: const Color(0xFF0F6EFF),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 43.5 / 375,
          ),
          Text(
            controller.tokenEntry.value.balance ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          // Text(
          //   AppS().token_details_roughly_money(
          //       controller.tokenEntry.value.totalMoney ?? '0'),
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 13,
          //   ),
          // ),
          // const SizedBox(height: 6.5),
          const SizedBox(
            height: 14,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              Res.ic_img,
              width: 35.5,
              height: 22,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildState() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStateBtn(
            title: AppS().token_details_state_all,
            tag: 0,
          ),
          _buildStateBtn(
            title: AppS().token_details_state_transfer_out,
            tag: 1,
          ),
          _buildStateBtn(
            title: AppS().token_details_state_transfer_in,
            tag: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStateBtn({
    String? title,
    int? tag,
  }) {
    final width = (Get.width - 15 * 2 - 11 * 2) / 3;
    return InkWell(
      onTap: () {
        controller.state.value = tag!;
        controller.onRefreshFun();
      },
      child: Container(
        decoration: BoxDecoration(
          color: controller.state.value == tag
              ? const Color(0xFF0F6EFF)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: controller.state.value == tag
              ? null
              : Border.all(
                  color: const Color(0xFF999999),
                  width: 0.5,
                ),
        ),
        width: width,
        height: 35,
        alignment: Alignment.center,
        child: Text(
          title ?? '',
          style: TextStyle(
            color: controller.state.value == tag
                ? Colors.white
                : const Color(0xFF999999),
          ),
        ),
      ),
    );
  }

  Widget _buildToolBar() {
    return Positioned(
      bottom: 0,
      child: SafeArea(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBtn(
                title: AppS().token_details_collection,
                bgColor: const Color(0xFF0F6EFF),
                onTap: () {},
              ),
              _buildBtn(
                icon: Res.ic_transfer,
                title: AppS().token_details_transfer,
                bgColor: const Color(0xFF0548AE),
                onTap: () => Get.toNamed(AppRoutes.tokenTransfer),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtn({
    String? icon,
    String? title,
    Color? bgColor,
    GestureTapCallback? onTap,
  }) {
    final width = (Get.width - 15 * 3) / 2;
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ?? const Color(0xFF0F6EFF),
          borderRadius: BorderRadius.circular(6),
        ),
        width: width,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Image.asset(
                icon,
                width: 24,
                height: 24,
              ),
            if (icon == null)
              CoreKitStyle.image(
                controller.tokenEntry.value.imageUrl ?? Res.ic_collection,
                width: 24,
                height: 24,
              ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateCell() {
    return Container();
  }
}
