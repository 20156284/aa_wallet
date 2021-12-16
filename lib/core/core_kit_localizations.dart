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

  static const CoreKitLocalizationsDelegate delegate =
      CoreKitLocalizationsDelegate();
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

class CoreKitLocalizationsDelegate
    extends LocalizationsDelegate<CoreKitLocalizations> {
  const CoreKitLocalizationsDelegate();

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
  String get btnAllow;

  String get btnDisallow;

  String get dialogTitlePermissionRequired;

  String get dialogTitlePermissionSettings;

  String get emojiInputBtnSend;

  String get errorScreenBtnRefresh;

  String get errorScreenBtnReload;

  String get errorScreenContentNetworkUnavailable;

  String get errorScreenContentFetchingDataFailed;

  String get errorScreenTitleNetworkUnavailable;

  String get errorScreenTitleFetchingDataFailed;

  String get errorOpenAppSettings;

  String get inAppMap;

  String get aMapTitle;

  String get aMapError;

  String get tencentMapTitle;

  String get tencentMapError;

  String get baiduMapTitle;

  String get baiduMapError;

  String get appleMapTitle;

  String get savePhotos;

  String get cancel;

  String get savePhotosFailure;

  String get savePhotosSuccess;

  String get album;

  String get camera;

  String get permissionPhotosClose;

  String get permissionCameraClose;

  String get permissionStorageClose;

  String get reset;

  String get finish;

  String get storage;

  static CoreKitS of(BuildContext context) {
    return CoreKitLocalizations.of(context)!.currentLocalization;
  }
}

/// Chinese
class ChS implements CoreKitS {
  @override
  String get btnAllow => '允许';

  @override
  String get btnDisallow => '不允许';

  @override
  String get dialogTitlePermissionRequired => '需要权限';

  @override
  String get dialogTitlePermissionSettings => '打开设置';

  @override
  String get emojiInputBtnSend => '发送';

  @override
  String get errorScreenBtnRefresh => '刷新试试';

  @override
  String get errorScreenBtnReload => '重新加载';

  @override
  String get errorScreenContentFetchingDataFailed => '数据获取失败';

  @override
  String get errorScreenContentNetworkUnavailable => '网络异常，请检查您的网络连接';

  @override
  String get errorScreenTitleFetchingDataFailed => '数据获取失败';

  @override
  String get errorScreenTitleNetworkUnavailable => '网络异常';

  @override
  String get errorOpenAppSettings => '打开设置时出错';

  @override
  String get inAppMap => 'App内打开';

  @override
  String get aMapTitle => '高德地图';

  @override
  String get aMapError => '未安装高德地图';

  @override
  String get tencentMapTitle => '腾讯地图';

  @override
  String get tencentMapError => '未安装腾讯地图';

  @override
  String get baiduMapTitle => '百度地图';

  @override
  String get baiduMapError => '未安装百度地图';

  @override
  String get appleMapTitle => '苹果地图';

  @override
  String get savePhotos => '保存照片';

  @override
  String get cancel => '取消';

  @override
  String get savePhotosFailure => '保存照片失败';

  @override
  String get savePhotosSuccess => '保存照片成功';

  @override
  String get album => '相册';

  @override
  String get camera => '拍照';

  @override
  String get permissionPhotosClose => '照片权限被您关闭';

  @override
  String get permissionCameraClose => '相机权限被您关闭';

  @override
  String get permissionStorageClose => '内存读写权限被您关闭';

  @override
  String get reset => '重置';

  @override
  String get finish => '完成';

  @override
  String get storage => '读写内存权限';
}

/// English
class EnS implements CoreKitS {
  @override
  String get btnAllow => 'Allow';

  @override
  String get btnDisallow => 'Disallow';

  @override
  String get dialogTitlePermissionRequired => 'Permission Required';

  @override
  String get dialogTitlePermissionSettings => 'Open Settings';

  @override
  String get emojiInputBtnSend => 'Send';

  @override
  String get errorScreenBtnRefresh => 'Refresh';

  @override
  String get errorScreenBtnReload => 'Reload';

  @override
  String get errorScreenContentFetchingDataFailed => 'Fetching data failed';

  @override
  String get errorScreenContentNetworkUnavailable =>
      'Network unavailable，check your internet connection';

  @override
  String get errorScreenTitleFetchingDataFailed => 'Fetching data failed';

  @override
  String get errorScreenTitleNetworkUnavailable => 'Network unavailable';

  @override
  String get errorOpenAppSettings => 'Open app settings failed';

  @override
  String get inAppMap => 'In App';

  @override
  String get aMapTitle => 'AMap';

  @override
  String get aMapError => 'AMap No Install';

  @override
  String get tencentMapTitle => 'Tencnet Map';

  @override
  String get tencentMapError => 'Tencnet Map No Install';

  @override
  String get baiduMapTitle => 'Baidu Map';

  @override
  String get baiduMapError => 'Baidu Map No Install';

  @override
  String get appleMapTitle => 'Apple Map';

  @override
  String get savePhotos => 'Save photos';

  @override
  String get cancel => 'Cancel';

  @override
  String get savePhotosFailure => 'Save Photos Failure';

  @override
  String get savePhotosSuccess => 'Save Photos Success';

  @override
  String get album => 'Album';

  @override
  String get camera => 'Camera';

  @override
  String get permissionPhotosClose => 'No have album permission';

  @override
  String get permissionCameraClose => 'No have camera permission';

  @override
  String get permissionStorageClose => 'No have storage permission';

  @override
  String get reset => 'Reset';

  @override
  String get finish => 'Finish';

  @override
  String get storage => 'Edit photo need Storage permission';
}
