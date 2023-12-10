// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:isar/isar.dart';

part 'previews.model.g.dart';

@embedded
class Previews {
  String? image_small_url;
  String? image_medium_url;
  String? image_large_url;
  String? image_opengraph_url;
  String? blurhash;
  String? predominant_color;
  // final String? image_small_url;
  // final String? image_medium_url;
  // final String? image_large_url;
  // final String? image_opengraph_url;
  // final String? blurhash;
  // final String? predominant_color;

  Previews(
      {this.image_small_url,
      this.image_medium_url,
      this.image_large_url,
      this.image_opengraph_url,
      this.blurhash,
      this.predominant_color});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_small_url': image_small_url,
      'image_medium_url': image_medium_url,
      'image_large_url': image_large_url,
      'image_opengraph_url': image_opengraph_url,
      'blurhash': blurhash,
      'predominant_color': predominant_color,
    };
  }

  factory Previews.fromMap(Map<String, dynamic> map) {
    return Previews(
      image_small_url: map['image_small_url'] != null
          ? map['image_small_url'] as String
          : null,
      image_medium_url: map['image_medium_url'] != null
          ? map['image_medium_url'] as String
          : null,
      image_large_url: map['image_large_url'] != null
          ? map['image_large_url'] as String
          : null,
      image_opengraph_url: map['image_opengraph_url'] != null
          ? map['image_opengraph_url'] as String
          : null,
      blurhash: map['blurhash'] != null ? map['blurhash'] as String : null,
      predominant_color: map['predominant_color'] != null
          ? map['predominant_color'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Previews.fromJson(String source) =>
      Previews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Previews(image_small_url: $image_small_url, image_medium_url: $image_medium_url, image_large_url: $image_large_url, image_opengraph_url: $image_opengraph_url, blurhash: $blurhash, predominant_color: $predominant_color)';
  }
}
