// ===============================================
// dior
//
// Create by Will on 2020/10/5 4:25 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:aa_wallet/core/logger.dart';
import 'package:aa_wallet/core/toast.dart';
import 'dio_interceptor.dart';

class Dior {
  Dior();
  static final appDio = newDioInstance();

  static Dio newDioInstance({
    Duration? connectTimeout = const Duration(seconds: 30),
    Duration? receiveTimeout = const Duration(seconds: 30),
    String baseUrl = '',
    ResponseType? responseType = ResponseType.json,
    String? contentType,
    bool? receiveDataWhenStatusError = true,
  }) {
    final options = BaseOptions(
      connectTimeout: connectTimeout?.inMilliseconds,
      receiveTimeout: receiveTimeout?.inMilliseconds,
      baseUrl: baseUrl,
      responseType: responseType,
      contentType: contentType,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
    );

    final dio = Dio(options);
    dio.interceptors.add(CoreKitInterceptor());
    if (kDebugMode) {
      // 开启请求日志
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    // A dio transformer especially for flutter, by which the json decoding will be in background with [compute] function.
    // dio.transformer = FlutterTransformer();

    return dio;
  }

  /// 一般场景下处理异常的逻辑
  static void handleError(
    dynamic error, [
    dynamic message,
  ]) {
    CoreKitLogger().e(message, error);
    CoreKitToast.showError(error);
  }
}
