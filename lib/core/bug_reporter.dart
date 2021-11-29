// ===============================================
// bug_reporter
//
// Create by Will on 2020/10/17 12:24 PM
// Copyright @treasure-app.All rights reserved.
// ===============================================

import 'dart:async';

import 'package:flutter/foundation.dart';

/// https://flutter.cn/docs/cookbook/maintenance/error-reporting
///
/// Dart线程模型及异常捕获
/// - https://book.flutterchina.club/chapter2/thread_model_and_error_report.html
///
/// More about zones:
/// - https://api.dart.dev/stable/dart-async/Zone-class.html
/// - https://www.dartlang.org/articles/libraries/zones
class CoreKitBugReporter {
  CoreKitBugReporter();

  /// 创建处理异常的函数
  static void Function(Object error, StackTrace stack) onError =
      (error, stack) async {
    return onReportError!.call(
      error.runtimeType.toString(),
      error.toString(),
      stack.toString(),
      null,
    );
  };

  /// 创建上报异常的函数
  static ErrorReporter? onReportError;

  /// 现在已经有了一个能够根据环境上报异常的函数了，接着还需要知道如何去捕获 Dart 异常。
  /// 为了实现这一目的，把应用运行在一个自定义的 Zone 里面。Zones 为代码建立执行上下文环境。
  /// 在这个上下文环境中，所有发生的异常在抛出 onError 时都能够很容易地被捕获到。
  static R? runZoned<R>(
    R Function() body, {
    Map<Object, Object?>? zoneValues,
    ZoneSpecification? zoneSpecification,
  }) {
    /// 在包含了 Dart 2.8 的 Flutter 1.17 中，使用 runZonedGuarded：
    return runZonedGuarded(
      body,
      onError,
      zoneValues: zoneValues,
      zoneSpecification: zoneSpecification,
    );
  }

  /// 除了 Dart 异常，Flutter 也能抛出其他的异常，比如调用原生代码发生的平台异常。这种类型的异常也同样是需要上报的。
  static forwardFlutterErrorToCurrentZone() {
    /// 为了捕获 Flutter 异常，需要重写 FlutterError.onError 属性。
    /// 在开发环境下，可以将异常格式化输出到控制台。
    /// 在生产环境下，可以把异常传递给上个步骤中的 onError 回调。
    FlutterError.onError = (details) {
      if (kDebugMode) {
        // In development mode, simply print to console.
        FlutterError.dumpErrorToConsole(details);
      } else {
        // In production mode, report to the application zone to report to Server.
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.empty);
      }
    };
  }
}

/// 上报自定义异常.
///
/// @param type 错误类型
/// @param error 错误信息
/// @param stackTrace 出错堆栈
/// @param extraInfo 额外信息
typedef ErrorReporter = Future<void> Function(
  String? type,
  String? error,
  String? stackTrace,
  Map<String, String?>? extraInfo,
);
