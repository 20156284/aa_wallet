// ===============================================
// coin_key_entity
//
// Create by will on 2021/11/19 18:03
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:json_annotation/json_annotation.dart';

/// This allows the `CoinKeyEntity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'coin_key_entity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class CoinKeyEntity {
  final String? protocol;
  final String? coinKey;
  final String? contractAddress;
  final String? imageUrl;

  const CoinKeyEntity(
      this.protocol, this.coinKey, this.contractAddress, this.imageUrl);

  /// A necessary factory constructor for creating a new CoinKeyEntity instance
  /// from a map. Pass the map to the generated `_$CoinKeyEntityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, CoinKeyEntity.
  factory CoinKeyEntity.fromJson(Map<String, dynamic> json) =>
      _$CoinKeyEntityFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CoinKeyEntityToJson`.
  Map<String, dynamic> toJson() => _$CoinKeyEntityToJson(this);
}
