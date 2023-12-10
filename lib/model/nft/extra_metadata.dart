// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:isar/isar.dart';

part 'extra_metadata.g.dart';

@embedded
class ExtraMetadata {
  List<String>? attributes;
  String? image_original_url;
  String? animation_original_url;
  String? metadata_original_url;
  // final List<Attribute>? attributes;
  // final String? image_original_url;
  // final String? animation_original_url;
  // final String? metadata_original_url;
  ExtraMetadata({
    this.attributes,
    this.image_original_url,
    this.animation_original_url,
    this.metadata_original_url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attributes': attributes,
      'image_original_url': image_original_url,
      'animation_original_url': animation_original_url,
      'metadata_original_url': metadata_original_url,
    };
  }

  factory ExtraMetadata.fromMap(Map<String, dynamic> map) {
    return ExtraMetadata(
      attributes: map['attributes'] != null
          ? List<String>.from(
              (map['attributes']).map((x) => jsonEncode(x)),
            )
          : null,
      image_original_url: map['image_original_url'] != null
          ? map['image_original_url'] as String
          : null,
      animation_original_url: map['animation_original_url'] != null
          ? map['animation_original_url'] as String
          : null,
      metadata_original_url: map['metadata_original_url'] != null
          ? map['metadata_original_url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtraMetadata.fromJson(String source) =>
      ExtraMetadata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExtraMetadata(attributes: $attributes, image_original_url: $image_original_url, animation_original_url: $animation_original_url, metadata_original_url: $metadata_original_url)';
  }
}
