// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';

part 'millisearch_search_token.g.dart';

@JsonSerializable()
class MilliSearch_SearchToken {
  final List<MilliSearch_SearchTokenDocument> hits;
  final String query;
  final double processingTimeMs;
  final int limit;
  final int offset;
  final int estimatedTotalHits;
  const MilliSearch_SearchToken({
    required this.hits,
    required this.query,
    required this.processingTimeMs,
    required this.limit,
    required this.offset,
    required this.estimatedTotalHits,
  });
  factory MilliSearch_SearchToken.fromJson(Map<String, dynamic> json) =>
      _$MilliSearch_SearchTokenFromJson(json);
}

@JsonSerializable()
class MilliSearch_SearchTokenDocument {
  final String key;
  final String address;
  final int decimals;
  final String symbol;
  final int chainId;
  final String coinKey;
  final String name;
  final String logoURI;
  final String priceUSD;

  const MilliSearch_SearchTokenDocument({
    required this.key,
    required this.address,
    required this.decimals,
    required this.symbol,
    required this.chainId,
    required this.coinKey,
    required this.name,
    required this.logoURI,
    required this.priceUSD,
  });
  factory MilliSearch_SearchTokenDocument.fromJson(Map<String, dynamic> json) =>
      _$MilliSearch_SearchTokenDocumentFromJson(json);
}
