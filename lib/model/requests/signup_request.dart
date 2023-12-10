import 'package:json_annotation/json_annotation.dart';

part "signup_request.g.dart";

@JsonSerializable()
class SignupRequest {
  final String email;
  const SignupRequest({
    required this.email,
  });
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
