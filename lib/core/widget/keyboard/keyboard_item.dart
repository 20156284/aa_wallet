import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardItem extends StatefulWidget {
  const KeyboardItem(
      {Key? key, this.callback, this.text, this.keyHeight, this.textWidget})
      : super(key: key);

  final String? text;
  final VoidCallback? callback;
  final double? keyHeight;
  final Widget? textWidget;

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<KeyboardItem> {
  double keyHeight = 44;
  double txtSize = 18;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final _screenWidth = mediaQuery.size.width;
    if (null != widget.keyHeight) {
      keyHeight = widget.keyHeight!;
    }
    return CupertinoPageScaffold(
      backgroundColor: const CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.white,
        darkColor: CupertinoColors.black,
      ),
      child: Container(
        height: keyHeight,
        width: _screenWidth / 3,
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .color!
                .withAlpha(48),
            width: 0.5,
          ),
        ),
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: widget.textWidget == null
              ? Text(
                  widget.text!,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(fontSize: 20.0),
                )
              : widget.textWidget!,
          onPressed: widget.callback,
        ),
      ),
    );
  }
}
