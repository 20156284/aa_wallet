// ===============================================
// dialog_utils
// 
// Create by Will on 2020/11/6 2:29 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';

typedef ListWidgetBuilder = List<Widget> Function(BuildContext context);

class DialogUtils {
  DialogUtils();
  static Future<T?> showAlert<T>({
    required BuildContext context,
    TextSpan? title,
    TextSpan? content,
    ListWidgetBuilder? actionsBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null
              ? null
              : Text.rich(
            title,
            textAlign: TextAlign.center,
          ),
          content: content == null
              ? null
              : Center(
            child: Text.rich(
              content,
              textAlign: TextAlign.start,
            ),
          ),
          actions: actionsBuilder?.call(context) ?? [],
        );
      },
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
}