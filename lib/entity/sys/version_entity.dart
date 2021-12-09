// ===============================================
// version_entity
//
// Create by will on 2021/12/9 11:20
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:json_annotation/json_annotation.dart';

/// This allows the `VersionEntity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'version_entity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class VersionEntity {
  const VersionEntity(this.create_time, this.downloadCode, this.versionNo,
      this.downloadAddress, this.isUpdates, this.type, this.content);

  /// A necessary factory constructor for creating a new VersionEntity instance
  /// from a map. Pass the map to the generated `_$VersionEntityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, VersionEntity.
  factory VersionEntity.fromJson(Map<String, dynamic> json) =>
      _$VersionEntityFromJson(json);

  final String? create_time;
  final String? downloadCode;
  final String? versionNo;
  final String? downloadAddress;
  final String? isUpdates;
  final String? type;
  final String? content;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$VersionEntityToJson`.
  Map<String, dynamic> toJson() => _$VersionEntityToJson(this);
}
