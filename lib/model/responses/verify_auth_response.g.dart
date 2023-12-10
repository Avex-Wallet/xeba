// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAuthResponse _$VerifyAuthResponseFromJson(Map<String, dynamic> json) =>
    VerifyAuthResponse(
      refresh: _Refresh.fromJson(json['refresh'] as Map<String, dynamic>),
      access: _Access.fromJson(json['access'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyAuthResponseToJson(VerifyAuthResponse instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
    };

_Access _$AccessFromJson(Map<String, dynamic> json) => _Access(
      expires: json['expires'] as String,
      access: json['access'] as String,
    );

Map<String, dynamic> _$AccessToJson(_Access instance) => <String, dynamic>{
      'access': instance.access,
      'expires': instance.expires,
    };

_Refresh _$RefreshFromJson(Map<String, dynamic> json) => _Refresh(
      expires: json['expires'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$RefreshToJson(_Refresh instance) => <String, dynamic>{
      'refresh': instance.refresh,
      'expires': instance.expires,
    };
