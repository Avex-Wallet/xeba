// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names

import 'package:avex_mobile/model/token/token_model.dart';

enum Speed { Slow, Average, Fast }

class Txn {
  final String address;
  final TokenModel? token;
  final String value;
  final String toAddress;
  final String? gas;
  final Speed speed;
  Txn({
    required this.address,
    this.token,
    required this.value,
    required this.toAddress,
    this.gas,
    required this.speed,
  });

  Txn copyWith({
    String? address,
    TokenModel? token,
    String? value,
    String? toAddress,
    String? gas,
    Speed? speed,
  }) {
    return Txn(
      address: address ?? this.address,
      token: token ?? this.token,
      value: value ?? this.value,
      toAddress: toAddress ?? this.toAddress,
      gas: gas ?? this.gas,
      speed: speed ?? this.speed,
    );
  }

  @override
  String toString() {
    return 'Txn(address: $address, token: $token, value: $value, toAddress: $toAddress, gas: $gas, speed: $speed)';
  }

  @override
  bool operator ==(covariant Txn other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.token == token &&
        other.value == value &&
        other.toAddress == toAddress &&
        other.gas == gas &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        token.hashCode ^
        value.hashCode ^
        toAddress.hashCode ^
        gas.hashCode ^
        speed.hashCode;
  }
}
