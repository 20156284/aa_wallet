// ===============================================
// ${NAME}
// 
// Create by ${USER} on ${DATE} ${TIME}
// Copyright @${PROJECT_NAME}.All rights reserved.
// ===============================================

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:${PROJECT_NAME}/core/http/dior.dart';
part '${NAME}.g.dart';

@RestApi(baseUrl: '')
abstract class ${CLASS_NAME} {
  //static final _cache = <String, ${CLASS_NAME}>{};

  static ${CLASS_NAME} acquire() {
    return ${CLASS_NAME}(Dior.appDio);
  }

  //factory ${CLASS_NAME}(Dio dio, {String? baseUrl}) {
  //  return _cache.putIfAbsent(baseUrl!, () {
  //  return _${CLASS_NAME}(dio, baseUrl: baseUrl);
  //  });
  //}
  factory ${CLASS_NAME}(Dio dio, {String baseUrl}) = _${CLASS_NAME};

  @POST("/example/post")
  Future<void> methodName({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Field("field0") int? field0,
    @Field("field1") int? field1,
  });
}