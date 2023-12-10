// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cloud_file_id_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCloudFileIdRequest _$CreateCloudFileIdRequestFromJson(
        Map<String, dynamic> json) =>
    CreateCloudFileIdRequest(
      provider: json['provider'] as String,
      fileId: json['file_id'] as String,
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$CreateCloudFileIdRequestToJson(
        CreateCloudFileIdRequest instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'file_id': instance.fileId,
      'signature': instance.signature,
    };
