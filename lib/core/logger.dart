// ===============================================
// logger
//
// Create by Will on 2020/10/5 4:37 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class CoreKitLogger {
  /// http://www.dartdoc.cn/guides/language/language-tour#factory-constructors
  /// 使用 factory 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，这将意味着使用该构造函数构造类的实例时并非总是会返回新的实例对象。
  /// 例如，工厂构造函数可能会从缓存中返回一个实例，或者返回一个子类型的实例。
  factory CoreKitLogger() {
    return _shared;
  }

  CoreKitLogger._internal() {
    if (kDebugMode) {
      Logger.level = Level.debug;
    } else if (kProfileMode) {
      Logger.level = Level.error;
    } else {
      Logger.level = Level.nothing;
    }
  }

  static final _shared = CoreKitLogger._internal();
  final _logger = Logger(
    printer: PrettyPrinter(
      // number of method calls to be displayed
      methodCount: 5,
      // number of method calls if stacktrace is provided
      errorMethodCount: 10,
      // width of the output
      lineLength: 120,
      // Colorful log messages
      colors: true,
      // debugPrint an emoji for each log message
      printEmojis: true,
      // Should each log debugPrint contain a timestamp
      printTime: true,
    ),
  );

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }
}
