import 'package:json_annotation/json_annotation.dart';

part 'get_existence_response.g.dart';

@JsonSerializable()
class GetExistenceResponse {
  final bool exists;

  final List<dynamic>? cloudFile;
  final String? secret;

  const GetExistenceResponse({
    required this.exists,
    required this.cloudFile,
    required this.secret,
  });

  factory GetExistenceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetExistenceResponseFromJson(json);
}
