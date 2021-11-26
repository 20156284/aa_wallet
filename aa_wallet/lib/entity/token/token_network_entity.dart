// ===============================================
// token_network_entity
//
// Create by will on 2021/11/24 16:49
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:json_annotation/json_annotation.dart';

/// This allows the `TokenNetworkEntity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'token_network_entity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class TokenNetworkEntity {
  const TokenNetworkEntity({this.id, this.jsonrpc, this.result});

  /// A necessary factory constructor for creating a new TokenNetworkEntity instance
  /// from a map. Pass the map to the generated `_$TokenNetworkEntityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, TokenNetworkEntity.
  factory TokenNetworkEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenNetworkEntityFromJson(json);

  final String? jsonrpc;
  final int? id;
  final String? result;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TokenNetworkEntityToJson`.
  Map<String, dynamic> toJson() => _$TokenNetworkEntityToJson(this);
}
