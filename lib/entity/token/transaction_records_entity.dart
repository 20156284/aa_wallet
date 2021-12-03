// ===============================================
// transaction_records_entity
//
// Create by will on 2021/12/2 11:03
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:json_annotation/json_annotation.dart';

/// This allows the `TransactionRecordsEntity` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'transaction_records_entity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class TransactionRecordsEntity {
  const TransactionRecordsEntity(
    this.number,
    this.protocol,
    this.coinKey,
    this.transferType,
    this.txId,
    this.fromAddress,
    this.toAddress,
    this.status,
    this.txFee,
    this.createTime,
  );

  /// A necessary factory constructor for creating a new TransactionRecordsEntity instance
  /// from a map. Pass the map to the generated `_$TransactionRecordsEntityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, TransactionRecordsEntity.
  factory TransactionRecordsEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionRecordsEntityFromJson(json);

  // final String? number;
  // final String? protocol;
  // final String? coinKey;
  // final int? transferType;
  // final String? txId;
  // final String? fromAddress;
  // final String? toAddress;
  // final String? status;
  // final String? txFee;
  // final int? createTime;

  final String? number;
  final String? protocol;
  final String? coinKey;
  final int? createTime;
  final String? txFee;
  final String? txId;
  final String? transferType;
  final String? fromAddress;
  final String? toAddress;
  final String? status;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TransactionRecordsEntityToJson`.
  Map<String, dynamic> toJson() => _$TransactionRecordsEntityToJson(this);
}
