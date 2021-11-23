// ===============================================
// error_utils
//
// Create by Will on 2020/10/5 6:09 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'dart:io';
import 'package:aa_wallet/core/exception/api_exception.dart';
import 'package:aa_wallet/core/http/dio_error.dart';
import 'package:dio/dio.dart';

class ErrorUtils {
  ErrorUtils();
  static dynamic errorFrom(dynamic error) {
    dynamic originalError;

    switch (error.runtimeType) {
      case DioError:
        final DioError dioError = error as DioError;
        originalError = dioError.error;
        break;
    }

    return originalError == null ? error : errorFrom(originalError);
  }

  static String? messageFrom(dynamic error) {
    final originalError = errorFrom(error);
    String? message;

    switch (originalError.runtimeType) {
      case DioError:
        final DioError dioError = originalError as DioError;
        message = dioError.toDisplayText();
        break;
      case CoreKitAPIException:
        final apiException = originalError as CoreKitAPIException;
        message = apiException.message;
        break;
      case HttpException:
      case SocketException:
        message = '网络异常，请检查您的网络连接';
        break;
      default:
        message = '$originalError';
        break;
    }

    return message;
  }

  static int? apiExceptionCodeFrom(dynamic error) {
    final err = ErrorUtils.errorFrom(error);
    if (err is CoreKitAPIException) {
      return err.code;
    }

    return null;
  }
}
