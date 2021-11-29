import 'dart:ui';


import 'package:aa_wallet/core/widget/keyboard/view_pwd_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'key_event.dart';
import 'keyboard_item.dart';

class CoreKitKeyboard extends StatefulWidget {
  const CoreKitKeyboard(
      {Key? key,
      this.onKeyDown,
      this.onResult,
      this.autoBack = false,
      this.pwdLength = 6,
      this.keyHeight = 48,
      this.delText,
      this.delWidget,
      this.confirmText,
      this.tipsText,
      this.confirmWidget,
      this.subtitleWidget,
      this.forgetText,
      this.showForgetText = false,
      this.resetText,
      this.showResetText = false,
      this.onForget,
      this.onReset})
      : super(key: key);

  final ValueChanged<String>? onKeyDown;
  final ValueChanged<String>? onResult;
  final bool? autoBack;
  final num? pwdLength;
  final double? keyHeight;
  final Widget? delWidget;
  final Widget? confirmWidget;
  final Widget? subtitleWidget;
  final String? tipsText;
  final String? delText;
  final String? confirmText;
  final String? forgetText;
  final bool? showForgetText;
  final GestureTapCallback? onForget;
  final String? resetText;
  final bool? showResetText;
  final GestureTapCallback? onReset;

  @override
  _CoreKitKeyboardState createState() => _CoreKitKeyboardState();
}

class _CoreKitKeyboardState extends State<CoreKitKeyboard> {
  String data = '';

  List<String> keyList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'del',
    '0',
    'commit'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.autoBack!) {
      keyList[9] = '';
      keyList[11] = 'del';
    }
  }

  @override
  Widget build(BuildContext context) {
    double pwdHeight = 140;
    if (widget.subtitleWidget != null) {
      pwdHeight = 190;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: pwdWidget(pwdHeight),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: keyboardWidget(),
          ),
        ],
      ),
    );
  }

  Widget pwdWidget(double pwdHeight) {
    return Container(
      width: double.infinity,
      height: pwdHeight,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Align(
            child: IconButton(
              icon: const Icon(Icons.close, size: 28),
              onPressed: () => widget.onKeyDown!(KeyDownEvent('close').key),
            ),
            alignment: Alignment.topRight,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  widget.tipsText ?? 'Please enter your payment code',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250,
                  height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomPwdField(data, widget.pwdLength!.toInt()),
                ),
                if (widget.subtitleWidget != null) widget.subtitleWidget!,
                if (widget.showForgetText! || widget.showResetText!)
                  const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.showForgetText!)
                      InkWell(
                        onTap: widget.onForget,
                        child: Text(
                          widget.forgetText ?? 'Forgetting payment password',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    if (widget.showResetText!)
                      InkWell(
                        onTap: widget.onReset,
                        child: Text(
                          widget.resetText ?? 'Reset the payment password',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget keyboardWidget() {
    return Container(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      height: keyList.length / 3 * widget.keyHeight! +
          MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Wrap(
        children: keyList.map((item) {
          String title = item;
          if (item == 'del' && widget.delText != null) {
            title = widget.delText!;
          }
          if (item == 'commit' && widget.confirmText != null) {
            title = widget.confirmText!;
          }
          return KeyboardItem(
            keyHeight: widget.keyHeight,
            text: title,
            callback: () => onKeyDown(context, item),
          );
        }).toList(),
      ),
    );
  }

  void onKeyDown(BuildContext context, String text) {
    if ('commit' == text && data.length >= 6) {
      widget.onResult!(data);
      return;
    }
    if ('del' == text && data.isNotEmpty) {
      setState(() {
        data = data.substring(0, data.length - 1);
      });
    }
    if (data.length >= widget.pwdLength!.toInt()) {
      return;
    }
    setState(() {
      if ('del' != text && text != 'commit') {
        data += text;
        widget.onKeyDown!(KeyDownEvent(text).key);
      }
    });
    if (data.length == widget.pwdLength && widget.autoBack!) {
      widget.onResult!(data);
    }
  }
}
