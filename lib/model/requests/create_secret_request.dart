import 'package:json_annotation/json_annotation.dart';

part "create_secret_request.g.dart";

@JsonSerializable()
class CreateSecretRequest {
  final String secret;
  @JsonKey(name: "pub_key")
  final String pubKey;
  final String signature;

  const CreateSecretRequest(
      {required this.secret, required this.pubKey, required this.signature});
  Map<String, dynamic> toJson() => _$CreateSecretRequestToJson(this);
}
