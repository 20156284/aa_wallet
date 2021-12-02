import 'dart:io';

import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'collection_address_logic.dart';

class CollectionAddressPage extends GetView<CollectionAddressLogic> {
  const CollectionAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        primaryColor: Colors.white,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          navActionTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18,
          ),
        ),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF0F6EFF),
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            AppS().token_details_collection,
          ),
          backgroundColor: const Color(0xFF0F6EFF),
          border: Border.all(width: 0.0, style: BorderStyle.none),
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
          children: [
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      AppS().collections_addr_tips,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            RepaintBoundary(
              key: controller.globalKey,
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppS().collections_addr_in_eth,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    QrImage(
                      padding: const EdgeInsets.all(25),
                      data: controller.wallet.value.address ?? '',
                      size: Get.width * 229 / 375,
                      embeddedImage: const AssetImage(Res.ic_qr_code_bg),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size:
                            Size(Get.width * 229 / 375, Get.width * 229 / 375),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      AppS().collections_addr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      controller.wallet.value.address ?? '',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: Get.width - 25 * 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (Platform.isAndroid) {
                        controller.getPermission(Permission.storage);
                      }
                      if (Platform.isIOS) {
                        controller.getPermission(Permission.photos);
                      }
                    },
                    child: Container(
                      width: (Get.width - 25 * 2 - 15) / 2,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Res.ic_save,
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppS().app_save_photos,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.onCopy(),
                    child: Container(
                      width: (Get.width - 25 * 2 - 15) / 2,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Res.ic_copy_blue,
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppS().collections_addr_copy,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
