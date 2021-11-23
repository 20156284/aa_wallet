// ===============================================
// core_kit_localizations
//
// Create by Will on 2020/10/30 5:53 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CoreKitLocalizations {
  CoreKitLocalizations(this.locale);

  static const HeyTeaLocalizationsDelegate delegate =
      HeyTeaLocalizationsDelegate();
  static final Map<String, CoreKitS> values = {
    'en': EnS(),
    'zh': ChS(),
  };

  final Locale locale;

  CoreKitS get currentLocalization {
    return values[locale.languageCode] ?? values.values.first;
  }

  static CoreKitLocalizations? of(BuildContext context) {
    return Localizations.of(context, CoreKitLocalizations);
  }
}

class HeyTeaLocalizationsDelegate
    extends LocalizationsDelegate<CoreKitLocalizations> {
  const HeyTeaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return CoreKitLocalizations.values.containsKey(locale.languageCode);
  }

  @override
  Future<CoreKitLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreKitLocalizations>(
        CoreKitLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CoreKitLocalizations> old) {
    return false;
  }
}

/// interface implements different language
abstract class CoreKitS {
  String get btn_allow;

  String get btn_disallow;

  String get dialog_title_permissionRequired;

  String get dialog_title_permissionSettings;

  String get emojiInput_btn_send;

  String get errorScreen_btn_refresh;

  String get errorScreen_btn_reload;

  String get errorScreen_content_networkUnavailable;

  String get errorScreen_content_fetchingDataFailed;

  String get errorScreen_title_networkUnavailable;

  String get errorScreen_title_fetchingDataFailed;

  String get error_openAppSettings;

  static CoreKitS of(BuildContext context) {
    return CoreKitLocalizations.of(context)!.currentLocalization;
  }
}

/// Chinese
class ChS implements CoreKitS {
  @override
  String get btn_allow => '允许';

  @override
  String get btn_disallow => '不允许';

  @override
  String get dialog_title_permissionRequired => '需要权限';

  @override
  String get dialog_title_permissionSettings => '打开设置';

  @override
  String get emojiInput_btn_send => '发送';

  @override
  String get errorScreen_btn_refresh => '刷新试试';

  @override
  String get errorScreen_btn_reload => '重新加载';

  @override
  String get errorScreen_content_fetchingDataFailed => '数据获取失败';

  @override
  String get errorScreen_content_networkUnavailable => '网络异常，请检查您的网络连接';

  @override
  String get errorScreen_title_fetchingDataFailed => '数据获取失败';

  @override
  String get errorScreen_title_networkUnavailable => '网络异常';

  @override
  String get error_openAppSettings => '打开设置时出错';
}

/// English
class EnS implements CoreKitS {
  @override
  String get btn_allow => 'Allow';

  @override
  String get btn_disallow => 'Disallow';

  @override
  String get dialog_title_permissionRequired => 'Permission Required';

  @override
  String get dialog_title_permissionSettings => 'Open Settings';

  @override
  String get emojiInput_btn_send => 'Send';

  @override
  String get errorScreen_btn_refresh => 'Refresh';

  @override
  String get errorScreen_btn_reload => 'Reload';

  @override
  String get errorScreen_content_fetchingDataFailed => 'Fetching data failed';

  @override
  String get errorScreen_content_networkUnavailable =>
      'Network unavailable，check your internet connection';

  @override
  String get errorScreen_title_fetchingDataFailed => 'Fetching data failed';

  @override
  String get errorScreen_title_networkUnavailable => 'Network unavailable';

  @override
  String get error_openAppSettings => 'Open app settings failed';
}
