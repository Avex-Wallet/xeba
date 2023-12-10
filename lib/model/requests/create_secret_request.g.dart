// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_secret_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSecretRequest _$CreateSecretRequestFromJson(Map<String, dynamic> json) =>
    CreateSecretRequest(
      secret: json['secret'] as String,
      pubKey: json['pub_key'] as String,
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$CreateSecretRequestToJson(
        CreateSecretRequest instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'pub_key': instance.pubKey,
      'signature': instance.signature,
    };
