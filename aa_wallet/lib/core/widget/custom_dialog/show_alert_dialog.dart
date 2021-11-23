// ===============================================
// show_alert_dialog
//
// Create by will on 3/4/21 3:16 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog();

  static Future<T?> showCustomDialog<T>(
    BuildContext context,
    Widget contentWidget, {
    //默认显示关闭按钮
    bool isShowCloseBtn = true,
    //默认关闭按钮 在右上角
    AlignmentGeometry? alignment,
    //点击 空白地方 默认不关闭弹窗
    bool barrierDismissible = false,
    BorderRadius? borderRadius,
    GestureTapCallback? onClose,
    //默认的关闭时间 3秒
    Duration? closeDuration,
    //是否自动关闭 默认不自动关闭
    bool isAutoClose = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => CustomWidget(
        contentWidget: contentWidget,
        alignment: alignment,
        borderRadius: borderRadius,
        isShowCloseBtn: isShowCloseBtn,
        onClose: onClose,
        closeDuration: closeDuration,
        isAutoClose: isAutoClose,
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
    required this.contentWidget,
    this.alignment,
    this.borderRadius,
    this.isShowCloseBtn,
    this.onClose,
    this.closeDuration,
    this.isAutoClose,
  }) : super(key: key);

  final Widget contentWidget;
  final AlignmentGeometry? alignment;
  final BorderRadius? borderRadius;
  final bool? isShowCloseBtn;
  final GestureTapCallback? onClose;
  final Duration? closeDuration;
  final bool? isAutoClose;

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.isAutoClose != null && widget.isAutoClose!) {
        //Timer的使用需要引入
        final timeout = widget.closeDuration ?? const Duration(seconds: 3);
        Timer(timeout, () {
          Navigator.pop(context);
          widget.onClose!();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              child: Stack(
                alignment: widget.alignment ?? Alignment.topRight,
                children: <Widget>[
                  widget.contentWidget,
                  Offstage(
                    offstage: !widget.isShowCloseBtn!,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Icon(
                          CupertinoIcons.clear_circled,
                          size: 30,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        widget.onClose!();
                      },
                    ),
                  )
                ],
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
