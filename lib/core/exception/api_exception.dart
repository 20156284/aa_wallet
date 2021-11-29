// ===============================================
// api_exception
//
// Create by Will on 2020/10/5 5:06 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:dio/dio.dart';

class CoreKitAPIException implements Exception {
  const CoreKitAPIException(this.code, {this.message});

  CoreKitAPIException.fromDioError(DioError dioError)
      : this(dioError.error as int, message: dioError.toString());

  final int code;
  final String? message;

  @override
  String toString() {
    return 'CoreAPIException [code]: $code, [message]: $message';
  }
}
