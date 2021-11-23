// ===============================================
// app_tool
// 
// Create by will on 2/23/21 7:45 PM
// Copyright @aa_wallet.All rights reserved.
// ===============================================


import 'dart:io';
import 'dart:typed_data';

import 'package:aa_wallet/core/exception/directory_extension.dart';
import 'package:aa_wallet/core/logger.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class AppTool {
  AppTool();
  static final _key = encrypt.Key.fromUtf8('Fight for rights');
  static final _iv = encrypt.IV.fromUtf8('');

  static final _aes = encrypt.AES(_key);
  static final _aesEncrypter = encrypt.Encrypter(_aes);

  static List<int> encryptBytes(List<int> data) {
    return _aesEncrypter.encryptBytes(data, iv: _iv).bytes;
  }

  static List<int> decryptBytes(List<int> data) {
    final encrypted = encrypt.Encrypted(Uint8List.fromList(data));
    return _aesEncrypter.decryptBytes(encrypted, iv: _iv);
  }

  // static String friendlyOnlineTime(BuildContext context, DateTime dateTime) {
  //   if (dateTime == null) {
  //     return '';
  //   }
  //
  //   final now = DateTime.now();
  //   final pastDuration = now.difference(dateTime);
  //   final appS = AppS() ;
  //
  //   if (pastDuration > const Duration(days: 3)) {
  //     return appS.last_online_time_days_ago(3);
  //   } else if (pastDuration > const Duration(days: 1)) {
  //     return appS.last_online_time_days_ago(pastDuration.inDays);
  //   } else if (pastDuration > const Duration(hours: 1)) {
  //     return appS.last_online_time_hours_ago(pastDuration.inHours);
  //   }
  //
  //   return appS.last_online_time_minutes_ago;
  // }
  //
  // static Future showSignInFromDifferentDeviceDialog({
  //   @required BuildContext context,
  //   bool useRootNavigator = true,
  //   RouteSettings routeSettings,
  // }) {
  //   final AppS = AppS() ;
  //
  //   return showSugarAlertDialog(
  //     context: context,
  //     title: TextSpan(
  //       text: AppS.sign_in_from_different_device_dialog_title,
  //     ),
  //     content: TextSpan(
  //       text: AppS.sign_in_from_different_device_dialog_content,
  //     ),
  //     actionsBuilder: (context) => [
  //       SugarDialogAction(
  //         onPressed: () => Navigator.pop(context),
  //         child: Text(AppS.sign_in_from_different_device_dialog_btn_ignore),
  //       ),
  //       SugarDialogAction(
  //         onPressed: () {
  //           ExtendedNavigator.of(context).popAndPush(Routes.signInPage);
  //         },
  //         isDefaultAction: true,
  //         child: Text(AppS.btn_to_sign_in),
  //       ),
  //     ],
  //     useRootNavigator: useRootNavigator,
  //     routeSettings: routeSettings,
  //   );
  // }

  static Future<Directory> getAppDocDirectory(
      AppDirectoryType type, {
        bool createIfNotExist = true,
      }) async {
    final parent = await getApplicationDocumentsDirectory();
    String dirName = type.toString();
    dirName = dirName.substring(dirName.indexOf('.') + 1);

    return parent.getChild(
      childName: dirName,
      createIfNotExist: createIfNotExist,
    );
  }

  static Future<Directory> getTempDirectory(
      AppDirectoryType type, {
        bool createIfNotExist = true,
      }) async {
    final parent = await getTemporaryDirectory();
    String dirName = type.toString();
    dirName = dirName.substring(dirName.indexOf('.') + 1);

    return parent.getChild(
      childName: dirName,
      createIfNotExist: createIfNotExist,
    );
  }

  static Future<void> clearTempDirectory([
    List<AppDirectoryType> types = const [],
  ]) async {
    for (final type in types) {
      final directory = await getTempDirectory(
        type,
        createIfNotExist: false,
      );
      if (await directory.exists() == false) continue;
      directory.delete(recursive: true).catchError((error) {
        CoreKitLogger().e('清理临时文件时出错，path: ${directory.path}', error);
      });
    }
  }
}

enum AppDirectoryType {
  voiceMessage,
}

void dPrint(dynamic object) {
  if (kDebugMode == false) {
    return;
  }

  final dateTime = DateTime.now();
  debugPrint('[$dateTime] $object');
}
