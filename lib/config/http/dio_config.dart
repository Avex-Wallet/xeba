import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class DioLogger {
  static const useDefault = true;
  static const request = true;
  static const requestHeader = false;
  static const requestBody = true;
  static const responseHeader = false;
  static const responseBody = true;
  static const error = true;
  static const compact = true;
}

CacheOptions? dioCacheOption(
        {String? dir = '/data/user/0/com.example.avex_mobile/app_flutter'}) =>
    CacheOptions(
      store: HiveCacheStore(dir, hiveBoxName: 'Dio Cache'),
      // Default.
      policy: CachePolicy.forceCache,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: true,
    );
