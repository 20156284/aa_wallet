// ===============================================
// BaseResponse
//
// Create by Will on 2020/10/5 4:36 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'dart:convert';
import 'package:aa_wallet/core/logger.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `BaseResponse` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'base_response.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  const BaseResponse({
    required this.retcode,
    this.data,
    this.msg,
    this.err,
  });

  /// A necessary factory constructor for creating a new BaseResponse instance
  /// from a map. Pass the map to the generated `_$BaseResponseFromJson()` constructor.
  /// The constructor is named after the source class, in this case, BaseResponse.
  factory BaseResponse.fromJson(Map<String, dynamic> json,
          [T Function(Object? json)? fromJsonT]) =>
      _$BaseResponseFromJson(
        json,
        fromJsonT ?? (dynamic json) => json as T,
      );

  final int retcode;
  final String? msg;
  final String? err;
  final T? data;

  bool get isSuccess => retcode == 0;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$BaseResponseToJson`.
  Map<String, dynamic> toJson([Object Function(T value)? toJsonT]) =>
      _$BaseResponseToJson(
        this,
        toJsonT ?? (dynamic value) => value,
      );

  static BaseResponse<T>? tryParse<T>(dynamic data) {
    if (data == null) {
      return null;
    }

    Map dataMap;
    if (data is Map) {
      dataMap = data;
    } else if (data is String) {
      try {
        dataMap = jsonDecode(data) as Map;
      } catch (error) {
        // 非标准的JSON，跳过
        CoreKitLogger().e("Can't parse data to json map. data: $data", error);
        return null;
      }
    } else {
      return null;
    }

    try {
      return BaseResponse.fromJson(dataMap.cast());
    } catch (error) {
      // 非标准的BaseResponse，跳过
      CoreKitLogger().e("Can't convert to BaseResponse. Skipped.", error);
    }

    return null;
  }
}
