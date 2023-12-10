import 'package:json_annotation/json_annotation.dart';

part "create_address_request.g.dart";

@JsonSerializable()
class CreateAddressRequest {
  final String chain;
  @JsonKey(name: "public_address")
  final String publicAddress;
  final String signature;

  const CreateAddressRequest(
      {required this.chain, required this.publicAddress, required this.signature});
  Map<String, dynamic> toJson() => _$CreateAddressRequestToJson(this);
}
