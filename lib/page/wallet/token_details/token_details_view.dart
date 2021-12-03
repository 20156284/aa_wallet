import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/entity/token/transaction_records_entity.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'token_details_logic.dart';

class TokenDetailsPage extends GetView<TokenDetailsLogic> {
  const TokenDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Obx(() => Text(controller.tokenEntry.value.coinKey ?? '')),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: Stack(
        children: [
          Obx(
            () => SmartRefresher(
              enablePullDown: true,
              header: const WaterDropHeader(),
              controller: controller.refreshCtrl,
              onRefresh: () => controller.onRefreshFun(),
              // enablePullUp: true,
              // onLoading: () => controller.onLoadingFun(),
              child: _buildChild(),
            ),
          ),
          _buildToolBar(),
        ],
      ),
    );
  }

  Widget _buildChild() {
    return ListView.builder(
      padding: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: MediaQuery.of(Get.context!).padding.bottom + 44),
      itemBuilder: (c, i) {
        switch (i) {
          case 0:
            return _buildToken();
          case 1:
            return _buildState();
          default:
            final transactionRecords = controller.transactionRecordsList[i - 2];
            return _buildStateCell(transactionRecords);
        }
      },
      itemCount: controller.transactionRecordsList.length + 2,
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
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 25, bottom: 15),
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
        switch (tag) {
          case 0:
            controller.type = null;
            break;
          case 1:
            controller.type = '20';
            break;
          case 2:
            controller.type = '10';
            break;
        }
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
      child: Container(
        color: CupertinoTheme.of(Get.context!).scaffoldBackgroundColor,
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
                  onTap: () => Get.toNamed(AppRoutes.collectionAddress,
                      arguments: controller.tokenEntry.value),
                ),
                _buildBtn(
                  icon: Res.ic_transfer,
                  title: AppS().token_details_transfer,
                  bgColor: const Color(0xFF0548AE),
                  onTap: () => Get.toNamed(AppRoutes.tokenTransfer,
                      arguments: controller.tokenEntry.value),
                ),
              ],
            ),
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

  Widget _buildStateCell(TransactionRecordsEntity transactionRecordsEntity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildItems(
              title: AppS().token_transfer_cell_total,
              subTitle: transactionRecordsEntity.number,
              isRight: true),
          const SizedBox(
            height: 10,
          ),
          _buildItems(
              title: AppS().token_transfer_cell_addr,
              subTitle: transactionRecordsEntity.toAddress),
          const SizedBox(
            height: 10,
          ),
          _buildItems(
              title: AppS().token_transfer_cell_hash,
              subTitle: transactionRecordsEntity.txId),
          const SizedBox(
            height: 10,
          ),
          _buildItems(
              title: AppS().token_transfer_cell_state,
              subTitle: transactionRecordsEntity.status,
              isRight: true),
          const SizedBox(
            height: 10,
          ),
          _buildItems(
              title: AppS().token_transfer_cell_time,
              subTitle: transactionRecordsEntity.createTime == null
                  ? ''
                  : DateUtil.formatDateMs(transactionRecordsEntity.createTime!,
                      format: DateFormats.full),
              isRight: true),
        ],
      ),
    );
  }

  Widget _buildItems({String? title, String? subTitle, bool? isRight}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ''),
        const SizedBox(
          width: 22,
        ),
        Expanded(
          child: Text(
            subTitle ?? '',
            textAlign: isRight == true ? TextAlign.right : TextAlign.left,
          ),
        ),
      ],
    );
  }
}
