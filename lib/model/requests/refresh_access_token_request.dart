import 'package:json_annotation/json_annotation.dart';

part "refresh_access_token_request.g.dart";

@JsonSerializable()
class RefreshAccessTokenRequest {
  final String refresh;
  const RefreshAccessTokenRequest({
    required this.refresh,
  });
  Map<String, dynamic> toJson() => _$RefreshAccessTokenRequestToJson(this);
}
