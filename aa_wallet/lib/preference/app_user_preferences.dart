// ===============================================
// app_user_preferences
//
// Create by Will on 2020/10/19 2:45 PM
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:async';
import 'dart:convert';
import 'package:aa_wallet/core/logger.dart';
import 'package:aa_wallet/utils/app_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_preferences.dart';

class AppUserPreferences {
  AppUserPreferences._(this._preferences);

  final SharedPreferences _preferences;

  static Completer<AppUserPreferences>? _completer;

  static Future<AppUserPreferences> getInstance() async {
    if (_completer == null) {
      _completer = Completer<AppUserPreferences>();
      final preferences = await SharedPreferences.getInstance();
      _completer!.complete(AppUserPreferences._(preferences));
    }
    return _completer!.future;
  }

  Set<String> getKeys() => _preferences.getKeys();

  Future<bool> set(String key, dynamic value) {
    if (value == null) {
      _preferences.remove(key);
      return Future.value(true);
    }

    final utf8Encoded = utf8.encode(value.toString());
    final encrypted = AppTool.encryptBytes(utf8Encoded);
    final stringList = List.generate(
      encrypted.length,
      (index) => encrypted[index].toString(),
      growable: false,
    );

    return _preferences.setStringList(key, stringList);
  }

  String get(String key) {
    final stringList = _preferences.getStringList(key);

    final intList = List.generate(
      stringList!.length,
      (index) => int.parse(stringList[index]),
      growable: false,
    );
    final decrypted = AppTool.decryptBytes(intList);
    final utf8Decoded = utf8.decode(decrypted);

    CoreKitLogger().d('key: $key, value: $utf8Decoded');

    return utf8Decoded;
  }
}

extension AppUserPreferencesExt on AppUserPreferences {
  static const _app = 'app';
  // static const _user = 'user';

  AppPreferences get app {
    return tryGetEntity(_app, (map) {
          return AppPreferences.fromJson(map);
        }) ??
        AppPreferences();
  }

  Future<bool> setApp(AppPreferences entity) async {
    final json = entity.toJson();
    return trySetEntity(_app, json);
  }

  T? tryGetEntity<T>(String key, T Function(Map<String, dynamic>) converter) {
    try {
      final jsonString = get(key);
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return converter(map);
    } catch (error) {
      CoreKitLogger().e('读取$key配置时出错', error);
    }
    return null;
  }

  Future<bool> trySetEntity<T>(String key, Map<String, dynamic> entity) {
    try {
      final value = jsonEncode(entity);
      return set(key, value);
    } catch (error) {
      CoreKitLogger().e('保存$key配置时出错', error);
    }

    return Future.value(false);
  }
}
