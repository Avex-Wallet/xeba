// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:isar/isar.dart';

import 'contracts.model.dart';
import 'extra_metadata.dart';
import 'previews.model.dart';

part 'nft_model.g.dart';

@collection
class NFTModel {
  Id? id;
  String? chain;
  String? contract_address;
  String? token_id;
  String? name;
  String? description;
  Previews? previews;
  String? image_url;
  String? image_properties;
  String? video_url;
  String? video_properties;
  String? audio_url;
  String? audio_properties;
  String? model_url;
  String? model_properties;
  int? token_count;
  int? owner_count;
  String? created_date;
  String? status;
  Contract? contract;
  ExtraMetadata? extra_metadata;
  // final String? chain;
  // final String? contract_address;
  // final String? token_id;
  // final String? name;
  // final String? description;
  // final Previews? previews;
  // final String? image_url;
  // final Map<String, dynamic>? image_properties;
  // final String? video_url;
  // final Map<String, dynamic>? video_properties;
  // final String? audio_url;
  // final Map<String, dynamic>? audio_properties;
  // final String? model_url;
  // final Map<String, dynamic>? model_properties;
  // final int? token_count;
  // final int? owner_count;
  // final String? created_date;
  // final String? status;
  // final Contract? contract;
  // final ExtraMetadata? extra_metadata;
  NFTModel({
    this.chain,
    this.contract_address,
    this.token_id,
    this.name,
    this.description,
    this.previews,
    this.image_url,
    this.image_properties,
    this.video_url,
    this.video_properties,
    this.audio_url,
    this.audio_properties,
    this.model_url,
    this.model_properties,
    this.token_count,
    this.owner_count,
    this.created_date,
    this.status,
    this.contract,
    this.extra_metadata,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chain': chain,
      'contract_address': contract_address,
      'token_id': token_id,
      'name': name,
      'description': description,
      'previews': previews?.toMap(),
      'image_url': image_url,
      'image_properties': image_properties,
      'video_url': video_url,
      'video_properties': video_properties,
      'audio_url': audio_url,
      'audio_properties': audio_properties,
      'model_url': model_url,
      'model_properties': model_properties,
      'token_count': token_count,
      'owner_count': owner_count,
      'created_date': created_date,
      'status': status,
      'contract': contract?.toMap(),
      'extra_metadata': extra_metadata?.toMap(),
    };
  }

  factory NFTModel.fromMap(Map<String, dynamic> map) {
    return NFTModel(
      chain: map['chain'] != null ? map['chain'] as String : null,
      contract_address: map['contract_address'] != null
          ? map['contract_address'] as String
          : null,
      token_id: map['token_id'] != null ? map['token_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      previews: map['previews'] != null
          ? Previews.fromMap(map['previews'] as Map<String, dynamic>)
          : null,
      image_url: map['image_url'] != null ? map['image_url'] as String : null,
      image_properties: map['image_properties'] != null
          ? jsonEncode(['image_properties'])
          : null,
      video_url: map['video_url'] != null ? map['video_url'] as String : null,
      video_properties: map['video_properties'] != null
          ? jsonEncode(map['video_properties'])
          : null,
      audio_url: map['audio_url'] != null ? map['audio_url'] as String : null,
      audio_properties: map['audio_properties'] != null
          ? jsonEncode(map['audio_properties'])
          : null,
      model_url: map['model_url'] != null ? map['model_url'] as String : null,
      model_properties: map['model_properties'] != null
          ? jsonEncode(map['model_properties'])
          : null,
      token_count:
          map['token_count'] != null ? map['token_count'] as int : null,
      owner_count:
          map['owner_count'] != null ? map['owner_count'] as int : null,
      created_date:
          map['created_date'] != null ? map['created_date'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      contract: map['contract'] != null
          ? Contract.fromMap(map['contract'] as Map<String, dynamic>)
          : null,
      extra_metadata: map['extra_metadata'] != null
          ? ExtraMetadata.fromMap(map['extra_metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NFTModel.fromJson(String source) =>
      NFTModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NFTModel(chain: $chain, contract_address: $contract_address, token_id: $token_id, name: $name, description: $description, previews: $previews, image_url: $image_url, image_properties: $image_properties, video_url: $video_url, video_properties: $video_properties, audio_url: $audio_url, audio_properties: $audio_properties, model_url: $model_url, model_properties: $model_properties, token_count: $token_count, owner_count: $owner_count, created_date: $created_date, status: $status, contract: $contract, extra_metadata: $extra_metadata)';
  }
}
