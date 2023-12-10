// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'millisearch_search_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MilliSearch_SearchToken _$MilliSearch_SearchTokenFromJson(
        Map<String, dynamic> json) =>
    MilliSearch_SearchToken(
      hits: (json['hits'] as List<dynamic>)
          .map((e) => MilliSearch_SearchTokenDocument.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      query: json['query'] as String,
      processingTimeMs: (json['processingTimeMs'] as num).toDouble(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      estimatedTotalHits: json['estimatedTotalHits'] as int,
    );

Map<String, dynamic> _$MilliSearch_SearchTokenToJson(
        MilliSearch_SearchToken instance) =>
    <String, dynamic>{
      'hits': instance.hits,
      'query': instance.query,
      'processingTimeMs': instance.processingTimeMs,
      'limit': instance.limit,
      'offset': instance.offset,
      'estimatedTotalHits': instance.estimatedTotalHits,
    };

MilliSearch_SearchTokenDocument _$MilliSearch_SearchTokenDocumentFromJson(
        Map<String, dynamic> json) =>
    MilliSearch_SearchTokenDocument(
      key: json['key'] as String,
      address: json['address'] as String,
      decimals: json['decimals'] as int,
      symbol: json['symbol'] as String,
      chainId: json['chainId'] as int,
      coinKey: json['coinKey'] as String,
      name: json['name'] as String,
      logoURI: json['logoURI'] as String,
      priceUSD: json['priceUSD'] as String,
    );

Map<String, dynamic> _$MilliSearch_SearchTokenDocumentToJson(
        MilliSearch_SearchTokenDocument instance) =>
    <String, dynamic>{
      'key': instance.key,
      'address': instance.address,
      'decimals': instance.decimals,
      'symbol': instance.symbol,
      'chainId': instance.chainId,
      'coinKey': instance.coinKey,
      'name': instance.name,
      'logoURI': instance.logoURI,
      'priceUSD': instance.priceUSD,
    };
