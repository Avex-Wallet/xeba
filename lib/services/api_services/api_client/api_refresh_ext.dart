import '../api_response.dart';

extension ApiRefreshExt<T> on Future<ApiResponse<T>> {
  Future<ApiResponse<T>> bounce(Future<ApiResponse<T>> bouncerApiCall) async {
    final response = await this;
    if (response.code == 401) {
      return bouncerApiCall;
    }
    return response;
  }
}
