// ===============================================
// toast
//
// Create by Will on 2020/10/5 5:57 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:aa_wallet/core/utils/error_utils.dart';
import 'package:aa_wallet/core/widget/toast/icon_text.dart';
import 'package:aa_wallet/core/widget/toast/loading.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'animation/fade.dart';
import 'core_kit_const.dart';

const CoreKitToastInit = BotToastInit;

class CoreKitToastNavigatorObserver extends BotToastNavigatorObserver {}

class CoreKitToastContainer extends StatelessWidget {
  const CoreKitToastContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CoreKitConst.toastPadding,
      decoration: const BoxDecoration(
        color: CoreKitConst.toastBackgroundColor,
        borderRadius: CoreKitConst.toastRadius,
      ),
      child: DefaultTextStyle(
        style: CoreKitConst.toastTextStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        child: child,
      ),
    );
  }
}

class CoreKitToast {
  CoreKitToast();

  static CancelFunc showLoading({
    String? text,
    ValueListenable<String>? textListenable,
    BackButtonBehavior backButtonBehavior = BackButtonBehavior.ignore,
    bool crossPage = false,
    bool clickClose = false,
  }) {
    return BotToast.showCustomLoading(
      toastBuilder: (_) => LoadingWidget(
        text ?? 'Loading',
        textListenable: textListenable,
      ),
      clickClose: clickClose,
      ignoreContentClick: true,
      crossPage: crossPage,
    );
  }

  static CancelFunc showSuccess(
    String text, {
    bool crossPage = false,
    bool clickClose = false,
    VoidCallback? onClose,
    Duration duration = CoreKitConst.toastDuration,
  }) {
    return showIconText(
      icon: const Icon(
        CupertinoIcons.check_mark_circled,
        size: 30,
        color: Colors.red,
      ),
      text: text,
      color: Colors.green,
      crossPage: crossPage,
      clickClose: clickClose,
      onClose: () {
        if (onClose != null) onClose();
      },
      duration: duration,
    );
  }

  static CancelFunc showFailure(
    String? text, {
    bool crossPage = false,
    bool clickClose = false,
    VoidCallback? onClose,
    Duration duration = CoreKitConst.toastDuration,
  }) {
    return showIconText(
      icon: const Icon(
        CupertinoIcons.xmark_circle,
        size: 30,
        color: Colors.red,
      ),
      text: text,
      crossPage: crossPage,
      clickClose: clickClose,
      onClose: () {
        if (onClose != null) onClose();
      },
      duration: duration,
    );
  }

  static CancelFunc showError(
    dynamic error, {
    bool crossPage = false,
    bool clickClose = false,
  }) {
    final errMessage = ErrorUtils.messageFrom(error);
    return showFailure(
      errMessage,
      crossPage: crossPage,
      clickClose: clickClose,
    );
  }

  static CancelFunc showIconText({
    Widget? icon,
    String? text,
    Color color = Colors.white,
    bool crossPage = false,
    bool clickClose = false,
    Color backgroundColor = Colors.transparent,
    Duration duration = CoreKitConst.toastDuration,
    VoidCallback? onClose,
  }) {
    return showWidget(
      IconTextWidget(
        icon: icon,
        text: text,
        color: color,
      ),
      crossPage: crossPage,
      clickClose: clickClose,
      backgroundColor: backgroundColor,
      onClose: () {
        if (onClose != null) onClose();
      },
      duration: duration,
    );
  }

  static CancelFunc showWidget(
    Widget child, {
    bool crossPage = false,
    bool clickClose = false,
    Color backgroundColor = Colors.transparent,
    Duration duration = CoreKitConst.toastDuration,
    VoidCallback? onClose,
  }) {
    return BotToast.showAnimationWidget(
      toastBuilder: (_) => SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: child,
        ),
      ),
      animationDuration: CoreKitConst.toastAnimationDuration,
      wrapToastAnimation:
          (AnimationController controller, CancelFunc _, Widget child) {
        return FadeAnimation(
          controller: controller,
          child: child,
        );
      },
      crossPage: crossPage,
      clickClose: clickClose,
      backgroundColor: backgroundColor,
      duration: duration,
      onClose: () =>
          WidgetsBinding.instance!.addPostFrameCallback((_) => onClose!()),
    );
  }

  static CancelFunc showCustomDialog({
    required Widget child,
    bool crossPage = false,
    bool clickClose = false,
  }) {
    return BotToast.showCustomLoading(
      toastBuilder: (_) => SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: child,
        ),
      ),
      clickClose: clickClose,
      ignoreContentClick: true,
      crossPage: crossPage,
    );
  }
}
