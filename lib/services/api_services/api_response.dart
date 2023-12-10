/// Generic ApiResponse
class ApiResponse<T> {
  final ApiStatus status;
  final String? errorMessage;
  final int code;
  final T? data;

  ApiResponse.error(this.errorMessage, this.code)
      : status = ApiStatus.error,
        data = null;

  ApiResponse.success(T this.data, this.code)
      : status = ApiStatus.success,
        errorMessage = null;
}

enum ApiStatus {
  success,
  authError,
  error,
}

class CustomHttpException implements Exception {
  final String message;
  final int code;

  CustomHttpException(this.message, this.code);
}
