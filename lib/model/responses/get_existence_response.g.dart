// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_existence_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExistenceResponse _$GetExistenceResponseFromJson(
        Map<String, dynamic> json) =>
    GetExistenceResponse(
      exists: json['exists'] as bool,
      cloudFile: json['cloudFile'] as List<dynamic>?,
      secret: json['secret'] as String?,
    );

Map<String, dynamic> _$GetExistenceResponseToJson(
        GetExistenceResponse instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'cloudFile': instance.cloudFile,
      'secret': instance.secret,
    };
