//
//  my_input
//  sugar_park
//
//  Created by Will on 2020/7/31 .
//  Copyright ©sugar_park. All rights reserved.
//

import 'package:aa_wallet/core/widget/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//有bug 要强制 条用方来刷新当前的页面才能获取动态字数

class EditTextInputDialog {
  EditTextInputDialog();

  static Future<T?> showEditDialog<T>(
      {required BuildContext context,
      String? placeholder,
      String? defaultText,
      double? height,
      int? words,
      bool isAutofocus = true,
      TextInputType? keyboardType,
      Function(String?)? onChanged,
      Function(String?)? onSubmitted,
      Color? color,
      TextInputWordsType? textInputWordsType,
      int? maxLines,
      bool? isScrollControlled,
      ScrollPhysics physics = const NeverScrollableScrollPhysics(),
      bool useRootNavigator = true,
      RouteSettings? routeSettings,
      Future<bool> Function(String?)? verify}) async {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled ?? false, // !important
      context: context,
      builder: (BuildContext context) {
        return TextInputWidget(
          context: context,
          placeholder: placeholder,
          defaultText: defaultText,
          words: words,
          height: height,
          onChanged: (result) => onChanged!(result),
          onCancel: () {
            Navigator.pop(context);
          },
          onSubmitted: (result) async {
            if (verify == null || await verify(result)) {
              onSubmitted!(result);
              Navigator.pop(context);
            }
          },
          keyboardType: keyboardType,
          color: color,
          textInputWordsType: textInputWordsType,
          maxLines: maxLines,
          isAutofocus: isAutofocus,
          physics: physics,
        );
      },
    );
  }

  static Future<T?> showCupertinoDatePicker<T>(
      {required BuildContext context,
      String? title,
      bool use24hFormat = true,
      bool useRootNavigator = true,
      Function(DateTime?)? onDateTimeChanged,
      RouteSettings? routeSettings,
      int? maximumYear,
      DateTime? initialDateTime}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 44 + 200 + MediaQuery.of(context).padding.bottom,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  color: Colors.white,
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 44,
                        child: CupertinoButton(
                          child: const Text('取消'),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(title!),
                      SizedBox(
                        height: 44,
                        child: CupertinoButton(
                          child: const Text('确定'),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    maximumYear: maximumYear,
                    initialDateTime: initialDateTime,
                    use24hFormat: use24hFormat,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date) => onDateTimeChanged!(date),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  TextInputWidget({
    Key? key,
    required this.context,
    this.placeholder,
    this.defaultText,
    this.height,
    this.words,
    this.isAutofocus = false,
    this.keyboardType,
    this.onSubmitted,
    this.onCancel,
    this.onChanged,
    this.color,
    this.textInputWordsType,
    this.maxLines,
    this.physics = const NeverScrollableScrollPhysics(),
  }) : super(key: key);

  late BuildContext context;
  final String? placeholder;
  final String? defaultText;
  final double? height;
  final int? words;
  final bool? isAutofocus;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Function()? onCancel;
  final TextInputType? keyboardType;
  final Color? color;
  final TextInputWordsType? textInputWordsType;
  final int? maxLines;
  final ScrollPhysics? physics;

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: widget.physics,
      // !important
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ), // !important
        child: CoreKitTextInput(
          placeholder: widget.placeholder,
          defaultText: widget.defaultText,
          words: widget.words,
          height: widget.height,
          isAutofocus: widget.isAutofocus,
          color: widget.color,
          textInputWordsType: widget.textInputWordsType,
          onChanged: (result) {
            setState(() {});
            widget.onChanged!(result);
          },
          onSubmitted: (result) {
            widget.onSubmitted!(result);
          },
          onCancel: () {
            widget.onCancel!();
          },
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
        ),
      ),
    );
  }
}
