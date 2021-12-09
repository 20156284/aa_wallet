// ===============================================
// sys_api
//
// Create by will on 2021/12/9 11:18
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/http/dior.dart';
import 'package:aa_wallet/entity/sys/version_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'sys_api.g.dart';

@RestApi(baseUrl: '')
abstract class SysApi {
  factory SysApi(Dio dio, {String baseUrl}) = _SysApi;
  //static final _cache = <String, SysApi>{};

  static SysApi acquire() {
    return SysApi(Dior.appDio, baseUrl: '${Env.envConfig.baseUrl}/token');
  }

  //factory SysApi(Dio dio, {String? baseUrl}) {
  //  return _cache.putIfAbsent(baseUrl!, () {
  //  return _SysApi(dio, baseUrl: baseUrl);
  //  });
  //}

  @POST('/wallet/assets/queryversion')
  Future<VersionEntity> getVersion({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field('type') String? type,
  });
}
