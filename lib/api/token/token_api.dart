// ===============================================
// token_api
//
// Create by will on 2021/11/19 17:54
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/http/dior.dart';
import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:aa_wallet/entity/token/transaction_records_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'token_api.g.dart';

@RestApi(baseUrl: '')
abstract class ToKenApi {
  factory ToKenApi(Dio dio, {String baseUrl}) = _ToKenApi;
  //static final _cache = <String, ToKenApi>{};

  static ToKenApi acquire() {
    return ToKenApi(Dior.appDio, baseUrl: '${Env.envConfig.baseUrl}/token');
  }

  //factory ToKenApi(Dio dio, {String? baseUrl}) {
  //  return _cache.putIfAbsent(baseUrl!, () {
  //  return _ToKenApi(dio, baseUrl: baseUrl);
  //  });
  //}

  @POST('/wallet/addAddress')
  Future<void> walletAddAddress({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('protocol') String? protocol,
    @Field('address') String? address,
  });

  @POST('/wallet/deleteAddress')
  Future<void> walletDeleteAddress({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('protocol') String? protocol,
    @Field('address') String? address,
  });

  @POST('/wallet/getCoinKey')
  Future<List<CoinKeyEntity>> walletGetCoinKey({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('type') String? type,
    @Field('protocol') String? protocol,
  });

  @POST('/wallet/transactionRecords')
  Future<List<TransactionRecordsEntity>> transactionRecords({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('protocol') String? protocol,
    @Field('address') String? address,
    @Field('type') String? type,
    @Field('coinKey') String? coinKey,
  });
}
