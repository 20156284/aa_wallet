// ===============================================
// base_framework_kit
//
// Create by Will on 2020/10/5 4:34 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CoreKit {
  CoreKit();

  static const String packageName = 'core_kit';
  static const MethodChannel _channel = MethodChannel(packageName);

  static Future<String> get platformVersion async {
    final String version =
        _channel.invokeMethod('getPlatformVersion').toString();
    return version;
  }

  /// 请在APP启动时配置 CoreKit
  static CoreKitConfig? config;

  static void popRoute<T extends Object>(BuildContext context, [T? result]) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    } else {
      SystemNavigator.pop();
    }
  }
}

class CoreKitConfig {
  const CoreKitConfig({
    this.apiBaseUrlsGetter,
    this.apiHeadersGenerator,
  });

  final Future<List<String>?>? apiBaseUrlsGetter;
  final Future<Map<String, dynamic>?>? apiHeadersGenerator;
}
