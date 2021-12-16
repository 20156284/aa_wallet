// ===============================================
// core_kit_cropper
//
// Create by will on 2021/12/15 15:54
// Copyright @lankaidriver.All rights reserved.
// ===============================================

import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../core_kit_localizations.dart';
import 'crop_editor_helper.dart';

class CoreKitCropper extends StatefulWidget {
  const CoreKitCropper({
    Key? key,
    required this.selectedAssets,
    this.editorConfig,
  }) : super(key: key);

  final AssetEntity selectedAssets;
  final EditorConfig? editorConfig;

  static Future<AssetEntity?> crop({
    required BuildContext context,
    required AssetEntity selectedAssets,
    bool useRootNavigator = true,
    Curve routeCurve = Curves.easeIn,
    Duration routeDuration = const Duration(milliseconds: 300),
    double? cropAspectRatio = CropAspectRatios.ratio1_1,
    EditorConfig? editorConfig,
  }) async {
    editorConfig ??= EditorConfig(
      maxScale: 8.0,
      cropRectPadding: const EdgeInsets.all(20.0),
      cornerSize: const Size(30, 3),
      hitTestSize: 20.0,
      cropAspectRatio: cropAspectRatio,
      cornerColor: Colors.white,
      editorMaskColorHandler: (context, pointerDown) {
        return Colors.black;
      },
    );

    final AssetEntity? result = await Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).push<AssetEntity>(
      AssetPickerPageRoute<AssetEntity>(
        builder: CoreKitCropper(
          selectedAssets: selectedAssets,
          editorConfig: editorConfig,
        ),
        transitionCurve: routeCurve,
        transitionDuration: routeDuration,
      ),
    );
    return result;
  }

  @override
  _CoreKitCropperState createState() => _CoreKitCropperState();
}

class _CoreKitCropperState extends State<CoreKitCropper> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  late final ValueNotifier<File?> _fileNotifier = ValueNotifier<File?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _fileNotifier.value = (await widget.selectedAssets.file)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: _fileNotifier,
            builder: (context, value, child) {
              if (value == null) {
                return Container();
              } else {
                return ExtendedImage.file(
                  value,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height,
                  mode: ExtendedImageMode.editor,
                  extendedImageEditorKey: editorKey,
                  cacheRawData: true,
                  initEditorConfigHandler: (state) {
                    return EditorConfig(
                      maxScale: 8.0,
                      cropRectPadding: const EdgeInsets.all(20.0),
                      cornerSize: const Size(30, 3),
                      hitTestSize: 20.0,
                      cropAspectRatio: CropAspectRatios.ratio1_1,
                      cornerColor: Colors.white,
                      editorMaskColorHandler: (context, pointerDown) {
                        if (pointerDown) {
                          return Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.4);
                        }
                        return Colors.black;
                      },
                    );
                  },
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 49 + MediaQuery.of(context).padding.bottom,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: SizedBox(
                            width: 44,
                            child: Text(
                              CoreKitS.of(context).cancel,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          child: SizedBox(
                            width: 44,
                            child: Text(
                              CoreKitS.of(context).reset,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => onFinish(),
                          child: SizedBox(
                            width: 44,
                            child: Text(
                              CoreKitS.of(context).finish,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onFinish() async {
    final Uint8List fileData = Uint8List.fromList(kIsWeb
        ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))!
        : (await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!))!);

    PhotoManager.editor.saveImage(fileData).then((value) {
      Navigator.of(context).pop(value);
    });
  }
}
