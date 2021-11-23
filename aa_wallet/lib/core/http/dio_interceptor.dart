// ===============================================
// dio_interceptor
//
// Create by Will on 2020/10/5 4:13 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:aa_wallet/core/core_kit.dart';
import 'package:aa_wallet/core/entity/response/base_response.dart';
import 'package:aa_wallet/core/exception/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CoreKitInterceptor extends Interceptor {
  static int? _lastTimestamp;

  static int? get lastTimestamp => _lastTimestamp;

  static set lastTimestamp(int? value) {
    final oldValue = lastTimestamp;
    if (oldValue == null || oldValue < value!) {
      _lastTimestamp = value;
    }
  }

  /// 在此处改造请求，统一加入Token
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await options.isFromBaseUrl()) {
      final headers = options.headers;
      final apiHeaders = await CoreKit.config?.apiHeadersGenerator;
      if (apiHeaders != null) {
        for (final apiHeader in apiHeaders.entries) {
          headers.putIfAbsent(apiHeader.key, () => apiHeader.value);
        }
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (await response.requestOptions.isFromBaseUrl()) {
      final entity = BaseResponse.tryParse(response.data);

      if (entity != null) {
        if (entity.isSuccess) {
          // 抛掉BaseResponse的包装，直接返回result
          response.data = entity.data;
          // return handler.next(response);
          return super.onResponse(response, handler);
        }

        if (kDebugMode) {
          debugPrint('*** Response ***');
          _printResponse(response);
        }

        // 触发异常
        return handler.reject(
          DioError(
            requestOptions: response.requestOptions,
            response: response,
            type: DioErrorType.response,
            error: CoreKitAPIException(
              entity.retcode,
              message: entity.err,
            ),
          ),
        );
      }
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioErrorType.response &&
        await err.response?.requestOptions.isFromBaseUrl() == true) {
      final entity = BaseResponse.tryParse(err.response?.data);

      if (entity != null) {
        // 触发异常
        return handler.reject(
          DioError(
            requestOptions: err.requestOptions,
            response: err.response,
            type: DioErrorType.response,
            error: CoreKitAPIException(
              entity.retcode,
              message: entity.err,
            ),
          ),
        );
      }
    }

    return super.onError(err, handler);
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    _printKV('statusCode', response.statusCode);
    if (response.isRedirect == true) {
      _printKV('redirect', response.realUri);
    }
    debugPrint('headers:');
    response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    debugPrint('Request Data:');
    _printAll(response.requestOptions.data);
    debugPrint('Response Text:');
    _printAll(response.toString());
    debugPrint('');
  }

  void _printKV(String key, Object? v) {
    debugPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(debugPrint);
  }
}

extension RequestOptionsExt on RequestOptions {
  Future<bool> isFromBaseUrl() async {
    final baseUrls = await CoreKit.config?.apiBaseUrlsGetter;
    final test = (String baseUrl) => uri.toString().startsWith(baseUrl);
    return baseUrls?.any(test) == true;
  }
}
