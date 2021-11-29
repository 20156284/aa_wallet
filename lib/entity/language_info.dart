// ===============================================
// language_info
//
// Create by will on 2021/11/16 14:44
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:json_annotation/json_annotation.dart';

/// This allows the `LanguageInfo` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'language_info.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class LanguageInfo {
  LanguageInfo({this.name, this.icon, this.languageCode, this.countryCode});

  /// A necessary factory constructor for creating a new LanguageInfo instance
  /// from a map. Pass the map to the generated `_$LanguageInfoFromJson()` constructor.
  /// The constructor is named after the source class, in this case, LanguageInfo.
  factory LanguageInfo.fromJson(Map<String, dynamic> json) =>
      _$LanguageInfoFromJson(json);

  String? name;
  String? icon;
  String? languageCode;
  String? countryCode;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LanguageInfoToJson`.
  Map<String, dynamic> toJson() => _$LanguageInfoToJson(this);
}
