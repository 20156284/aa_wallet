// ===============================================
// dio_interceptor
//
// Create by Will on 2020/10/5 4:13 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core_kit.dart';
import '../entity/response/base_response.dart';
import '../exception/api_exception.dart';


class CoreKitInterceptor extends Interceptor {
  static int? _lastTimestamp;

  static int? get lastTimestamp => _lastTimestamp;

  static set lastTimestamp(int? value) {
    final int? oldValue = lastTimestamp;
    if (oldValue == null || oldValue < value!) {
      _lastTimestamp = value;
    }
  }

  /// 在此处改造请求，统一加入Token
  @override
  Future<dynamic> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final Map<String, dynamic> headers = options.headers;
    final Map<String, dynamic>? apiHeaders =
    await CoreKit.config?.apiHeadersGenerator;
    if (apiHeaders != null) {
      for (final MapEntry<String, dynamic> apiHeader in apiHeaders.entries) {
        headers.putIfAbsent(apiHeader.key, () => apiHeader.value);
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) async {
    final BaseResponse<dynamic>? entity = BaseResponse.tryParse(response.data);

    if (entity != null) {
      // lastTimestamp = entity.timestamp;

      if (entity.isSuccess) {
        // 抛掉BaseResponse的包装，直接返回result
        response.data = entity.data;
        // return handler.next(response);
        return super.onResponse(response, handler);
      }


      // 触发异常
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: CoreKitAPIException(
           300,
            message: entity.msg,
          ),
        ),
      );
    }

    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final BaseResponse<dynamic>? entity =
    BaseResponse.tryParse(err.response?.data);

    if (entity != null) {
      // lastTimestamp = entity.timestamp;

      // 触发异常
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: CoreKitAPIException(
            400,
            message: entity.msg,
          ),
        ),
      );
    }

    return super.onError(err, handler);
  }

}

extension RequestOptionsExt on RequestOptions {
  Future<bool> isFromBaseUrl() async {
    final List<String>? baseUrls = await CoreKit.config?.apiBaseUrlsGetter;
    bool test(String baseUrl) => uri.toString().startsWith(baseUrl);
    return baseUrls?.any(test) == true;
  }
}
