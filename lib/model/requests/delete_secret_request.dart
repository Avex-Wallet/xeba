import 'package:json_annotation/json_annotation.dart';

part "delete_secret_request.g.dart";

@JsonSerializable()
class DeleteSecretRequest {
  final String signature;

  const DeleteSecretRequest(
      { required this.signature});
  Map<String, dynamic> toJson() => _$DeleteSecretRequestToJson(this);
}
