// ===============================================
// core_kit_photo
//
// Create by will on 2021/12/15 09:15
// Copyright @lankaidriver.All rights reserved.
// ===============================================

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../core_kit_localizations.dart';
import '../custom_dialog/show_alert_dialog.dart';
import 'core_kit_cropper.dart';

enum PickerPhotoType {
  Camera,
  Album,
}

class CoreKitPhoto {
  CoreKitPhoto();

  /*
   * 选择照片或者拍照的功能 样式 采用 微信样式
   * @author Will
   * @date 2021/12/15 10:17
   * @param context context
   * @param albumText 图库字样 默认是 相册
   * @param cameraText 照片字样 默认是 拍照
   * @param cancelText 取消字样 默认是 取消
   * @param pickerPhotoType 图片类型
   * @param maxAssets 最大几张图片默认最大9张
   * @param selectedAssets 已经选过的图片
   * @param isCropper 是否开启截图功能 默认不开启
   * @return 返回 已经处理过的 AssetEntity数组
   */
  static Future<List<AssetEntity>?> showAlbumAndCameraOption({
    required BuildContext context,
    String? albumText,
    String? cameraText,
    String? cancelText,
    int? maxAssets,
    List<AssetEntity>? selectedAssets,
    double? cropAspectRatio = CropAspectRatios.ratio1_1,
    EditorConfig? editorConfig,
    //是否开启截图 默认不开启
    bool isCropper = false,
    //默认采用微信设计样式
    bool? isWeChatDesign = true,
  }) async {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        if (isWeChatDesign!) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 50 * 3 + 1 + 4 + MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                InkWell(
                  onTap: () => getPermission(
                    context: context,
                    permission: Permission.photos,
                    maxAssets: maxAssets,
                    selectedAssets: selectedAssets,
                    isCropper: isCropper,
                    cropAspectRatio: cropAspectRatio,
                    editorConfig: editorConfig,
                  ).then((value) {
                    Navigator.of(context).pop(value);
                  }),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      albumText ?? CoreKitS.of(context).album,
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () => getPermission(
                    context: context,
                    permission: Permission.camera,
                    maxAssets: maxAssets,
                    selectedAssets: selectedAssets,
                    isCropper: isCropper,
                    cropAspectRatio: cropAspectRatio,
                    editorConfig: editorConfig,
                  ).then((value) {
                    Navigator.of(context).pop(value);
                  }),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      cameraText ?? CoreKitS.of(context).camera,
                    ),
                  ),
                ),
                Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).dividerColor,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      cancelText ?? CoreKitS.of(context).cancel,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(albumText ?? CoreKitS.of(context).album),
                onPressed: () async {
                  getPermission(
                    context: context,
                    permission: Permission.photos,
                    maxAssets: maxAssets,
                    selectedAssets: selectedAssets,
                    isCropper: isCropper,
                  ).then((value) {
                    Navigator.of(context).pop(value);
                  });
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(cameraText ?? CoreKitS.of(context).camera),
                onPressed: () async {
                  getPermission(
                    context: context,
                    permission: Permission.camera,
                    maxAssets: maxAssets,
                    selectedAssets: selectedAssets,
                    isCropper: isCropper,
                  ).then((value) {
                    Navigator.of(context).pop(value);
                  });
                },
                isDefaultAction: true,
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(cancelText ?? CoreKitS.of(context).cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
          );
        }
      },
    );
  }

  /*
   * 获取权限的逻辑
   * @author Will
   * @date 2021/12/15 15:15
   * @param context context
   * @param permission 权限类型 这里暂时 支持相册 拍照 读写(only android)
   * @return 返回选过的图片
   */
  static Future<List<AssetEntity>?> getPermission({
    required BuildContext context,
    required Permission permission,
    int? maxAssets,
    List<AssetEntity>? selectedAssets,
    bool isCropper = false,
    double? cropAspectRatio = CropAspectRatios.ratio1_1,
    EditorConfig? editorConfig,
  }) async {
    final value = await permission.request();

    String content = '';
    if (value.index == 1) {
      if (permission == Permission.photos) {
        return _pickPhotosThenSend(
          context: context,
          pickerPhotoType: PickerPhotoType.Album,
          isCropper: isCropper,
          maxAssets: maxAssets,
          selectedAssets: selectedAssets,
          cropAspectRatio: cropAspectRatio,
          editorConfig: editorConfig,
        );
      }
      if (permission == Permission.camera) {
        return _pickPhotosThenSend(
          context: context,
          pickerPhotoType: PickerPhotoType.Camera,
          isCropper: isCropper,
          maxAssets: maxAssets,
          selectedAssets: selectedAssets,
          cropAspectRatio: cropAspectRatio,
          editorConfig: editorConfig,
        );
      }
    } else {
      if (permission == Permission.photos) {
        content = CoreKitS.of(context).permissionPhotosClose;
      }
      if (permission == Permission.camera) {
        content = CoreKitS.of(context).permissionCameraClose;
      }
      showCupertinoAlertDialog(context: context, content: content);
      return null;
    }
  }

  /*
   * 这里单独区分Android 读写权限 主要是存储图片需要用到
   * @author Will
   * @date 2021/12/15 15:15
   * @param context context
   * @param permission 权限类型 这里暂时 支持相册 拍照 读写(only android)
   * @return 返回选过的图片
   */
  static Future<List<AssetEntity>?> getPermissionByAndroidStorage({
    required BuildContext context,
    int? maxAssets,
    AssetEntity? selectedAssets,
    double? cropAspectRatio = CropAspectRatios.ratio1_1,
    EditorConfig? editorConfig,
  }) async {
    final value = await Permission.storage.request();

    String content = '';
    if (value.index == 1) {
      final AssetEntity? result = await CoreKitCropper.crop(
        context: context,
        selectedAssets: selectedAssets!,
        cropAspectRatio: cropAspectRatio,
        editorConfig: editorConfig,
      );
      if (result != null) {
        //返回的所有的都是 默认给到一张图片 因为是选择编辑图片功能
        return [result];
      }
      return null;
    } else {
      content = CoreKitS.of(context).permissionStorageClose;

      showCupertinoAlertDialog(context: context, content: content);
      return null;
    }
  }

  /*
   *
   * @author Will
   * @date 2021/12/15 09:40
   * @param context
   * @param content 显示内容
   * @param cancelText 取消字样
   */
  static Future<T?> showCupertinoAlertDialog<T>({
    required BuildContext context,
    String? content,
    String? cancelText,
  }) {
    return CustomDialog.showCustomDialog(
      context,
      CupertinoAlertDialog(
        title: Text(
          CoreKitS.of(context).dialogTitlePermissionRequired,
        ),
        content: Text(content ?? ''),
        actions: [
          CupertinoDialogAction(
            child: Text(
              CoreKitS.of(context).dialogTitlePermissionSettings,
            ),
            onPressed: () async {
              await openAppSettings(); //打开设置页面
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              cancelText ?? CoreKitS.of(context).cancel,
            ),
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /*
   *
   * @author Will
   * @date 2021/12/15 10:14
   * @param context context
   * @param pickerPhotoType 图片类型
   * @param maxAssets 最大几张图片默认最大9张
   * @param selectedAssets 已经选过的图片
   * @param isCropper 是否开启截图功能 默认不开启
   * @return 返回 已经处理过的 AssetEntity数组
   */
  static Future<List<AssetEntity>?> _pickPhotosThenSend({
    required BuildContext context,
    required PickerPhotoType pickerPhotoType,
    int? maxAssets,
    List<AssetEntity>? selectedAssets,
    //是否开启截图 默认不开启
    bool isCropper = false,
    double? cropAspectRatio = CropAspectRatios.ratio1_1,
    EditorConfig? editorConfig,
  }) async {
    if (pickerPhotoType == PickerPhotoType.Album) {
      final asset = await AssetPicker.pickAssets(
        context,
        selectedAssets: selectedAssets,
        requestType: RequestType.image,
        maxAssets: maxAssets ?? 9,
      );

      if (asset == null) {
        return null;
      }
      selectedAssets = asset;
    } else {
      await Future.delayed(const Duration(milliseconds: 200), () async {
        final asset = await CameraPicker.pickFromCamera(context);

        if (asset == null) {
          return;
        }
        if (selectedAssets != null) {
          selectedAssets!.add(asset);
        } else {
          selectedAssets = [asset];
        }
      });
    }

    //截取图片
    if (isCropper) {
      if (Platform.isAndroid) {
        // getPermission(context: context, pickerPhotoType: pickerPhotoType)
        return getPermissionByAndroidStorage(
          context: context,
          selectedAssets: selectedAssets!.first,
          cropAspectRatio: cropAspectRatio,
          editorConfig: editorConfig,
        );
      }

      final AssetEntity? result = await CoreKitCropper.crop(
        context: context,
        selectedAssets: selectedAssets!.first,
        cropAspectRatio: cropAspectRatio,
        editorConfig: editorConfig,
      );
      if (result != null) {
        //返回的所有的都是 默认给到一张图片 因为是选择编辑图片功能
        return [result];
      }
      return null;
    } else {
      return selectedAssets;
    }
  }
}
