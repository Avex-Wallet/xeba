// ignore_for_file: non_constant_identifier_names

import 'package:isar/isar.dart';
import 'dart:convert';
part 'attribute.model.g.dart';

@embedded
class Attribute {
  String? trait_type;
  String? value;
  // final String? trait_type;
  // final String? value;
  Attribute({
    this.trait_type,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trait_type': trait_type,
      'value': value,
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      trait_type:
          map['trait_type'] != null ? map['trait_type'] as String : null,
      value: map['value'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) =>
      Attribute.fromMap(json.decode(source) as Map<String, dynamic>);
}
