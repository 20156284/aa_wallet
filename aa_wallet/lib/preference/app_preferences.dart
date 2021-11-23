// ===============================================
// app_preferences
//
// Create by will on 2/23/21 7:43 PM
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/entity/language_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_preferences.g.dart';

@CopyWith()
@JsonSerializable()
class AppPreferences {
  AppPreferences({
    this.languageInfo,
  });

  factory AppPreferences.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesFromJson(json);

  // 用户设置的语言编码
  LanguageInfo? languageInfo;

  Map<String, dynamic> toJson() => _$AppPreferencesToJson(this);
}
