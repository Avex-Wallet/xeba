import 'package:json_annotation/json_annotation.dart';

part 'get_secret_response.g.dart';

@JsonSerializable()
class GetSecretResponse {
  final String secret ;
  const GetSecretResponse({
    required this.secret,
  });
  factory GetSecretResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSecretResponseFromJson(json);

}
