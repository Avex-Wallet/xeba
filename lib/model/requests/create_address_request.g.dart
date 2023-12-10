// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAddressRequest _$CreateAddressRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAddressRequest(
      chain: json['chain'] as String,
      publicAddress: json['public_address'] as String,
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$CreateAddressRequestToJson(
        CreateAddressRequest instance) =>
    <String, dynamic>{
      'chain': instance.chain,
      'public_address': instance.publicAddress,
      'signature': instance.signature,
    };
