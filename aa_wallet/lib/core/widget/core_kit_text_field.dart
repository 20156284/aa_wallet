// ===============================================
// core_kit_text_field
//
// Create by Will on 2020/10/10 3:12 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 控制 prefix + suffix 显示逻辑
enum CoreKitTextFieldWidgetMode {
  never,
  whileEditing,
  always,
}

class CoreKitTextField extends StatefulWidget {
  const CoreKitTextField({
    Key? key,
    this.controller,
    this.prefix,
    this.suffix,
    this.prefixMode = CoreKitTextFieldWidgetMode.never,
    this.suffixMode = CoreKitTextFieldWidgetMode.whileEditing,
    this.clearButtonMode = CoreKitTextFieldWidgetMode.whileEditing,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLength,
    this.hintText,
    TextInputType? keyboardType,
    this.textInputAction,
    this.contentPadding = const EdgeInsets.all(0),
  })  : assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        keyboardType = keyboardType ?? TextInputType.text,
        super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// 输入款前面的小部件
  final Widget? prefix;

  /// 是否显示suffix ，default is never
  final CoreKitTextFieldWidgetMode prefixMode;

  /// 输入框后面的小部件
  final Widget? suffix;

  /// 是否显示suffix ，default is whileEditing
  final CoreKitTextFieldWidgetMode suffixMode;

  /// 清除按钮的 default is whileEditing
  final CoreKitTextFieldWidgetMode clearButtonMode;

  /// 控制聚焦
  final FocusNode? focusNode;

  // 输入格式
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  // 最大输入字符
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String?>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String?>? onSubmitted;

  /// hintText
  final String? hintText;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// [EdgeInsets.zero].
  final EdgeInsetsGeometry contentPadding;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// 构建
  @override
  _CoreKitTextFieldState createState() => _CoreKitTextFieldState();
}

class _CoreKitTextFieldState extends State<CoreKitTextField> {
  // 控制输入
  late TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  // 控制聚焦
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();

    // 容错处理
    _controller = TextEditingController();

    // 👉 - [Flutter开发中的一些Tips（二）](https://www.jianshu.com/p/d1c98b49ab43)
    // Fixed Bug: 这里不要这样监听，否则等到销毁的时候 报错 setState() called after dispose()
    _effectiveFocusNode.addListener(_listenAction);
    _effectiveController.addListener(_listenAction);
  }

  @override
  void dispose() {
    // 有监听就有移除
    _effectiveFocusNode.removeListener(_listenAction);
    _effectiveController.removeListener(_listenAction);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildPrefixWidget(),
        _buildTextFieldWidget(),
        _buildSuffixWidget(),
      ],
    );
  }

  void _listenAction() {
    setState(() {});
  }

  /// 构建prefix Widget
  Widget _buildPrefixWidget() {
    bool offstage = widget.prefix == null;
    if (!offstage) {
      offstage = _getWidgetOffstage(widget.prefixMode);
    }
    final Widget prefix = Offstage(
      offstage: offstage,
      child: widget.prefix,
    );
    return prefix;
  }

  /// 构建textField Widget
  Widget _buildTextFieldWidget() {
    // 输入款格式
    final List<TextInputFormatter> formatters =
        widget.inputFormatters ?? <TextInputFormatter>[];
    if (widget.maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
    return Expanded(
      child: TextField(
        controller: _effectiveController,
        focusNode: _effectiveFocusNode,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(0),
          contentPadding: widget.contentPadding,
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color(0xFFb3b3b3), fontSize: 17.0),
          fillColor: Colors.transparent,
          filled: true,
        ),
        // Fixed Bug：如果限制4个字符，会导致底部出现 0/4 这个鬼东西，影响布局
        // maxLength: 4,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: formatters,
        // cursorColor: Style.pTintColor,
        obscureText: widget.obscureText,
        style:const TextStyle(
          // color: Style.pTextColor,
          fontSize: 17.0,
        ),
        onChanged: (valueText) {
          setState(() {});
          if (widget.onChanged != null) widget.onChanged!(valueText);
        },
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }

  /// 构建suffix Widget
  Widget _buildSuffixWidget() {
    bool offstage = false;
    if (widget.suffix == null) {
      offstage = _getWidgetOffstage(widget.clearButtonMode);
    } else {
      offstage = _getWidgetOffstage(widget.suffixMode);
    }
    final Widget suffix = Offstage(
      offstage: offstage,
      child: widget.suffix ?? _defaultSuffixWidget(),
    );
    return suffix;
  }

  // 默认suffix Widget 即删除按钮
  Widget _defaultSuffixWidget() {
    return Container(
      width: 24.0,
      height: 24.0,
      alignment: Alignment.center,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 20.0,
        icon: const Icon(
          Icons.cancel,
          color: Color.fromRGBO(177, 177, 177, 1),
        ),
        onPressed: () {
          setState(() {
            _effectiveController.text = '';
          });
          // 回调数据
          if (widget.onChanged != null) widget.onChanged!('');
        },
      ),
    );
  }

  /// 返回 suffix Widget or prefix Widget 的显示逻辑
  bool _getWidgetOffstage(CoreKitTextFieldWidgetMode mode) {
    bool offstage = false;
    switch (mode) {
      case CoreKitTextFieldWidgetMode.never:
        offstage = true;
        break;
      case CoreKitTextFieldWidgetMode.whileEditing:
        offstage = !(_effectiveFocusNode.hasFocus &&
            _effectiveController.text.isNotEmpty);
        break;
      default:
    }
    return offstage;
  }
}
