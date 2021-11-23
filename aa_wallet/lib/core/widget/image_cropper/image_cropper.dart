import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';

class AppImageCropper {
  AppImageCropper();
  static Future<File?> crop(
    BuildContext context,
    Future<File> file, {
    int? maxWidth,
    int? maxHeight,
    double? aspectRatio,
    CropStyle cropStyle = CropStyle.rectangle,
    ImageCompressFormat compressFormat = ImageCompressFormat.png,
  }) async {
    final path = (await file).path;

    return ImageCropper.cropImage(
      sourcePath: path,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      aspectRatio: aspectRatio == null
          ? null
          : CropAspectRatio(
              ratioX: 1 * aspectRatio,
              ratioY: 1,
            ),
      cropStyle: cropStyle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: '图片裁剪',
        toolbarColor: CupertinoTheme.of(context).primaryColor,
        toolbarWidgetColor: const CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: aspectRatio != null,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        title: '图片裁剪',
        resetAspectRatioEnabled: aspectRatio == null,
        aspectRatioLockEnabled: aspectRatio != null,
      ),
    );
  }
}
