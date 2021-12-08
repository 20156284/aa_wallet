import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CollectionAddressLogic extends GetxController {
  final wallet = WalletService.to.wallet;
  final globalKey = GlobalKey();

  final tokenEntry = TokenEntry(id: 0, wallet_id: 0).obs;
  final address = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments != null && arguments is TokenEntry) {
      tokenEntry.value = arguments;
    }

    address.value = wallet.value.address!;
  }

  void onCopyQrCode() {
    // Clipboard.setData(ClipboardData(text: inviteCode.value));
    // CoreKitToast.showSuccess(AppS().app_copy_success);
  }

  void onSavePicture() async {
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      final ui.Image image = await boundary.toImage(pixelRatio: dpr);
      final ByteData? _byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List pngBytes = _byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 100,
          name: 'qrcode');
      final isSuccess = result['isSuccess'];

      if (isSuccess != null && isSuccess is bool && isSuccess) {
        CustomDialog.showCustomDialog(
          Get.context!,
          onTipsDialogWidget(
            icon: const Icon(
              CupertinoIcons.check_mark_circled,
              size: 80,
            ),
            title: AppS().app_save_photos_success,
          ),
          isShowCloseBtn: false,
          isAutoClose: true,
          closeDuration: const Duration(seconds: 1),
          borderRadius: BorderRadius.circular(12),
        );
      } else {
        CustomDialog.showCustomDialog(
          Get.context!,
          onTipsDialogWidget(
            icon: const Icon(
              CupertinoIcons.clear_circled,
              size: 80,
              color: Colors.red,
            ),
            title: AppS().app_save_photos_failure,
          ),
          isShowCloseBtn: false,
          isAutoClose: true,
          closeDuration: const Duration(seconds: 1),
          borderRadius: BorderRadius.circular(12),
        );
      }
    } catch (error) {
      CoreKitToast.showError(error);
      CoreKitToast.showError(AppS().app_save_photos_failure);
    }
  }

  void _showCupertinoAlertDialog(String content) {
    Get.dialog(CupertinoAlertDialog(
      title: Text(AppS().app_permission_title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: Text(AppS().app_permission_open),
          onPressed: () async {
            await openAppSettings(); //打开设置页面
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: Text(AppS().app_cancel),
          isDestructiveAction: true,
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }

  void getPermission(Permission permission) async {
    await permission.request().then((value) {
      String content = '';
      if (value.index == 1) {
        onSavePicture();
      } else {
        content = AppS().app_permission_photos_close;
        _showCupertinoAlertDialog(content);
      }
    });
  }

  /**
   * 复制钱包地址的弹窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget onTipsDialogWidget({required Icon? icon, required String? title}) {
    return SizedBox(
      width: 145,
      height: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(
            height: 20,
          ),
          Text(title ?? ''),
        ],
      ),
    );
  }

  /**
   * 钱包地址
   * @author Will
   * @date 2021/11/19 17:07
   */
  void onCopy() {
    Clipboard.setData(ClipboardData(text: wallet.value.address));
    CustomDialog.showCustomDialog(
      Get.context!,
      onTipsDialogWidget(
        icon: const Icon(CupertinoIcons.check_mark_circled, size: 80),
        title: AppS().wallet_add_copy_success,
      ),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
