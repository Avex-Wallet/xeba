// ignore_for_file: library_private_types_in_public_api

import 'package:json_annotation/json_annotation.dart';

part "verify_auth_response.g.dart";

@JsonSerializable()
class VerifyAuthResponse {
  final _Refresh refresh;
  final _Access access;

  const VerifyAuthResponse({required this.refresh, required this.access});
  factory VerifyAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyAuthResponseFromJson(json);
}

@JsonSerializable()
class _Access {
  final String access;
  final String expires;

  const _Access({required this.expires, required this.access});

  factory _Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);
}

@JsonSerializable()
class _Refresh {
  final String refresh;
  final String expires;

  const _Refresh({required this.expires, required this.refresh});
  factory _Refresh.fromJson(Map<String, dynamic> json) =>
      _$RefreshFromJson(json);
}
