// ===============================================
// text_input
//
// Create by Will on 2020/11/17 4:33 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextInputWordsType { interior, without }

// ignore: must_be_immutable
class CoreKitTextInput extends StatefulWidget {
  CoreKitTextInput({
    Key? key,
    this.placeholder,
    this.defaultText,
    this.onChanged,
    this.height,
    this.words,
    this.isAutofocus = false,
    this.onSubmitted,
    this.onCancel,
    this.keyboardType = TextInputType.text,
    this.color = CupertinoColors.secondarySystemFill,
    this.textInputWordsType = TextInputWordsType.without,
    this.maxLines = 10,
  }) : super(key: key);

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

  @override
  CoreKitTextInputState createState() => CoreKitTextInputState();
}

class CoreKitTextInputState extends State<CoreKitTextInput>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultText);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.defaultText != null && widget.defaultText!.isNotEmpty) {
        setState(() {
          result = widget.defaultText!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _textInput(widget.placeholder!),
    );
  }

  String result = '';

  Widget _textInput(String hint) {
    return Column(children: [
      Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
//              border: Border.all(color: Color(0xFFDEDEDE)),
        ),
        alignment: AlignmentDirectional.topStart,
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoTextField(
              autofocus: widget.isAutofocus!,
              placeholder: hint,
              style: const TextStyle(fontSize: 15, color: Colors.black),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              maxLines: widget.maxLines,
              controller: _controller,
              maxLength: widget.words,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              textInputAction: TextInputAction.unspecified,
              onChanged: (str) {
                setState(() {
                  result = str;
                });
                widget.onChanged!(result);
              },
              onSubmitted: (str) => widget.onSubmitted!(result),
              keyboardType: widget.keyboardType,
            ),
            Offstage(
              offstage: widget.textInputWordsType == TextInputWordsType.without,
              child: Container(
                padding: const EdgeInsets.only(bottom: 4, right: 8),
                alignment: Alignment.bottomRight,
                child: Text(
                  result.length.toString() +
                      '/' +
                      widget.words.toString() +
                      '字',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
      Offstage(
        offstage: widget.textInputWordsType == TextInputWordsType.interior,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 65,
                height: 30,
                child: CupertinoButton(
                  child: const Text(
                    '取消',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  disabledColor: Colors.blue,
                  color: Colors.black12,
                  onPressed: () {
                    widget.onCancel!();
                  },
                  pressedOpacity: 0.9,
                  padding: const EdgeInsets.all(1),
                ),
              ),
              Offstage(
                offstage: widget.words == null,
                child: Text(
                  result.length.toString() +
                      '/' +
                      widget.words.toString() +
                      '字',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                width: 65,
                height: 30,
                child: CupertinoButton(
                  child: const Text(
                    '完成',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  disabledColor: Colors.blue,
                  color: Colors.black12,
                  onPressed: () {
                    widget.onSubmitted!(result);
                  },
                  pressedOpacity: 0.9,
                  padding: const EdgeInsets.all(1),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
