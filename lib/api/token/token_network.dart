// ===============================================
// token_network
//
// Create by will on 2021/11/24 14:54
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/http/dior.dart';
import 'package:aa_wallet/entity/token/token_network_entity.dart';

import 'package:dio/dio.dart';

import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'token_network.g.dart';

@RestApi(baseUrl: '')
abstract class TokenNetwork {
  factory TokenNetwork(Dio dio, {String baseUrl}) = _TokenNetwork;

  //static final _cache = <String, TokenNetwork>{};

  static TokenNetwork acquire() {
    return TokenNetwork(Dior.appDio, baseUrl: Env.envConfig.aaaRpcUrl);
  }

  //factory TokenNetwork(Dio dio, {String? baseUrl}) {
  //  return _cache.putIfAbsent(baseUrl!, () {
  //  return _TokenNetwork(dio, baseUrl: baseUrl);
  //  });
  //}

  @POST('')
  Future<TokenNetworkEntity> network({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('jsonrpc') String? jsonrpc,
    @Field('method') String? method,
    @Field('id') int? id,
    @Field('params') List? params,
  });
}
