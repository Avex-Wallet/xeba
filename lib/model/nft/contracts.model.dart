// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:isar/isar.dart';

part 'contracts.model.g.dart';

@embedded
class Contract {
  String? type;
  String? name;
  String? symbol;
  String? deployed_by;
  String? deployed_via_contract;

  // final String? type;
  // final String? name;
  // final String? symbol;
  // final String? deployed_by;
  // final String? deployed_via_contract;

  Contract({
    this.type,
    this.name,
    this.symbol,
    this.deployed_by,
    this.deployed_via_contract,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'symbol': symbol,
      'deployed_by': deployed_by,
      'deployed_via_contract': deployed_via_contract,
    };
  }

  factory Contract.fromMap(Map<String, dynamic> map) {
    return Contract(
      type: map['type'] != null ? map['type'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      deployed_by:
          map['deployed_by'] != null ? map['deployed_by'] as String : null,
      deployed_via_contract: map['deployed_via_contract'] != null
          ? map['deployed_via_contract'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contract.fromJson(String source) =>
      Contract.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contract(type: $type, name: $name, symbol: $symbol, deployed_by: $deployed_by, deployed_via_contract: $deployed_via_contract)';
  }
}
