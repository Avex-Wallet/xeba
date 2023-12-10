import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:avex_mobile/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio();
  if (!kProductionMode || true) {
    dio.interceptors.add(
      DioLogger.useDefault
          ? PrettyDioLogger()
          : PrettyDioLogger(
              requestBody: DioLogger.requestBody,
              responseBody: DioLogger.responseBody,
              compact: DioLogger.compact,
              requestHeader: DioLogger.requestHeader,
              request: DioLogger.request,
              error: DioLogger.error,
              responseHeader: DioLogger.responseHeader,
            ),
    );
  }
  return dio;
  // ..interceptors.add(DioCacheInterceptor(options: dioCacheOption()!));
});

final sharePrefProvider =
    FutureProvider((ref) => SharedPreferences.getInstance());
