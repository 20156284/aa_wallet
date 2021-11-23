// ===============================================
// icon_text
//
// Create by Will on 2020/10/5 6:05 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:aa_wallet/core/toast.dart';
import 'package:flutter/material.dart';

/// 图标+文字的Widget
class IconTextWidget extends StatelessWidget {
  const IconTextWidget(
      {Key? key, this.icon, this.text, this.color = Colors.white})
      : super(key: key);

  final String? icon;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CoreKitToastContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Image(
                image: AssetImage(
                  icon!,
                ),
                width: 30,
                height: 30,
                color: color,
                fit: BoxFit.contain,
              ),
            ),
          if (text != null) Text(text!),
        ],
      ),
    );
  }
}
