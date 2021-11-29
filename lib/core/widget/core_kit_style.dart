// ===============================================
// core_kit_style
//
// Create by will on 3/5/21 12:14 AM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreKitStyle {
  CoreKitStyle();

  static Widget image(
    String imageUrl, {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    bool cache = true,
    BorderRadius? borderRadius,
    Widget? errorWidget,
    Widget? placeholder,
    double? size,
  }) {
    late Widget imgWidget = Container();

    if (imageUrl.contains('http')) {
      imgWidget = ExtendedImage.network(
        imageUrl,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        cache: true,
        enableLoadState: true,
        // loadStateChanged: (ExtendedImageState state) {
        //   switch (state.extendedImageLoadState) {
        //     case LoadState.loading:
        //       return Image.asset(
        //         Res.loading,
        //         fit: fit,
        //       );
        //       break;
        //     case LoadState.completed:
        //       return  ExtendedRawImage(
        //         image: state.extendedImageInfo?.image,
        //         width: size ?? width,
        //         height: size ?? height,
        //         fit: fit,
        //       );
        //       break;
        //     case LoadState.failed:
        //       return GestureDetector(
        //         child: Stack(
        //           fit: StackFit.expand,
        //           children: <Widget>[
        //             Image.asset(
        //               Res.loading,
        //               fit: fit,
        //             ),
        //           ],
        //         ),
        //         onTap: () {
        //           state.reLoadImage();
        //         },
        //       );
        //       break;
        //     default:
        //       return Image.asset(
        //         Res.loading,
        //         fit: fit,
        //       );
        //       break;
        //   }
        // },
      );
    } else if (imageUrl.contains('assets')) {
      //加载本地图片
      imgWidget = Image.asset(
        imageUrl,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: imgWidget,
    );
  }

  static Widget cupertinoButton(
    BuildContext context, {
    Key? key,
    double? width,
    double? height,
    String? title,
    Icon? icon,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? btnPadding,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Decoration? decoration,
  }) {
    late Widget childWidget;

    if (title != null) {
      childWidget = Text(
        title,
        style: titleStyle == null
            ? TextStyle(
                color: onPressed != null
                    ? Colors.white
                    : CupertinoTheme.of(context).primaryColor)
            : titleStyle.copyWith(
                color: titleStyle.color ?? Colors.white,
              ),
      );
    }

    if (icon != null) {
      childWidget = icon;
    }

    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(0),
      width: width ?? MediaQuery.of(context).size.width,
      decoration: decoration,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 44,
        child: CupertinoButton(
          color: decoration == null
              ? backgroundColor ?? CupertinoTheme.of(context).primaryColor
              : Colors.transparent,
          padding: btnPadding ?? const EdgeInsets.all(0),
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
          child: childWidget,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
