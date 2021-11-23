// ===============================================
// PermissionUtils
// 
// Create by Will on 2020/11/6 2:28 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:aa_wallet/core/core_kit_localizations.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog_utils.dart';

class PermissionUtils {
  PermissionUtils();
  static Future<void> requestPermissions({
    required BuildContext context,
    required List<Permission> permissions,
    TextSpan? title,
    TextSpan? content,
    TextSpan? appSettingsTitle,
    TextSpan? appSettingsContent,
    VoidCallback? onAllGranted,
    VoidCallback? onDisallow,
    VoidCallback? onOpenAppSettings,
  }) async {
    if (await permissions.isAllGranted()) {
      return onAllGranted?.call();
    } else if (await permissions.shouldOpenAppSettings()) {
      return showOpenAppSettingsDialog(
        context: context,
        title: appSettingsTitle,
        content: appSettingsContent,
        onProcessed: onOpenAppSettings,
        onDisallow: onDisallow,
      );
    } else {
      return showPermissionsDialog(
        context: context,
        title: title,
        content: content,
        permissions: permissions,
        onProcessed: () async {
          final isAllGranted = await permissions.isAllGranted();
          if (isAllGranted) {
            onAllGranted?.call();
          } else {
            onDisallow?.call();
          }
        },
        onDisallow: onDisallow,
      );
    }
  }

  static Future<void> showPermissionsDialog({
    required BuildContext context,
    TextSpan? title,
    TextSpan? content,
    required List<Permission> permissions,
    VoidCallback? onProcessed,
    VoidCallback? onDisallow,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) async {
    final heyTeaS = CoreKitS.of(context);

    return showAllowDialog(
      context: context,
      title: title ?? TextSpan(text: heyTeaS.dialog_title_permissionRequired),
      content: content,
      onAllow: () async {
        // 去申请权限
        await permissions.request();
        onProcessed?.call();
      },
      onDisallow: onDisallow,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  static Future<void> showOpenAppSettingsDialog({
    required BuildContext context,
    TextSpan? title,
    TextSpan? content,
    VoidCallback? onProcessed,
    VoidCallback? onDisallow,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    final heyTeaS = CoreKitS.of(context);

    return showAllowDialog(
      context: context,
      title: title ?? TextSpan(text: heyTeaS.dialog_title_permissionSettings),
      content: content,
      onAllow: () async {
        final isOpened = await openAppSettings();
        if (isOpened == false) {
          CoreKitToast.showFailure(heyTeaS.error_openAppSettings);
        }
        onProcessed?.call();
      },
      onDisallow: onDisallow,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  static Future<void> showAllowDialog({
    required BuildContext context,
    TextSpan? title,
    TextSpan? content,
    VoidCallback? onAllow,
    VoidCallback? onDisallow,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    final heyTeaS = CoreKitS.of(context);

    return DialogUtils.showAlert(
      context: context,
      title: title,
      content: content,
      actionsBuilder: (context) => [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            onDisallow?.call();
          },
          child: Text(heyTeaS.btn_disallow),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            onAllow?.call();
          },
          isDefaultAction: true,
          child: Text(heyTeaS.btn_allow),
        ),
      ],
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
}

extension PermissionListActions on List<Permission> {
  Future<bool> isAllGranted() async {
    for (final permission in this) {
      final isGranted = await permission.isGranted;
      if (!isGranted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> shouldOpenAppSettings() async {
    for (final permission in this) {
      final status = await permission.status;
      switch (status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
          continue;
        case PermissionStatus.denied:
          if (await permission.shouldShowRequestRationale) {
            continue;
          } else {
            return true;
          }
        case PermissionStatus.restricted:
        case PermissionStatus.permanentlyDenied:
          return true;
      }
    }
    return false;
  }
}