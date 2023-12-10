import 'package:json_annotation/json_annotation.dart';

part "create_cloud_file_id_request.g.dart";

@JsonSerializable()
class CreateCloudFileIdRequest {
  final String provider;
  @JsonKey(name: "file_id")
  final String fileId;
  final String signature;

  const CreateCloudFileIdRequest(
      {required this.provider, required this.fileId, required this.signature});
  Map<String, dynamic> toJson() => _$CreateCloudFileIdRequestToJson(this);
}
