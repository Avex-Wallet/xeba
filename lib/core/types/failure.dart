// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure {
  final String message;
  final StackTrace stackTrace;
  const Failure(this.message, this.stackTrace);
}

class ServerError {
  final int code;
  final String message;
  ServerError({
    required this.code,
    required this.message,
  });

  factory ServerError.fromMap(Map<String, dynamic> map) {
    return ServerError(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }
}
