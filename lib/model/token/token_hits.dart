// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenHits {
  final String key;
  final String address;
  final int decimals;
  final String symbol;
  final int chainId;
  final String coinKey;
  final String name;
  final String logoURI;
  final String priceUSD;
  TokenHits({
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

  TokenHits copyWith({
    String? key,
    String? address,
    int? decimals,
    String? symbol,
    int? chainId,
    String? coinKey,
    String? name,
    String? logoURI,
    String? priceUSD,
  }) {
    return TokenHits(
      key: key ?? this.key,
      address: address ?? this.address,
      decimals: decimals ?? this.decimals,
      symbol: symbol ?? this.symbol,
      chainId: chainId ?? this.chainId,
      coinKey: coinKey ?? this.coinKey,
      name: name ?? this.name,
      logoURI: logoURI ?? this.logoURI,
      priceUSD: priceUSD ?? this.priceUSD,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'address': address,
      'decimals': decimals,
      'symbol': symbol,
      'chainId': chainId,
      'coinKey': coinKey,
      'name': name,
      'logoURI': logoURI,
      'priceUSD': priceUSD,
    };
  }

  factory TokenHits.fromMap(Map<String, dynamic> map) {
    return TokenHits(
      key: map['key'] ?? '',
      address: map['address'] ?? '',
      decimals: map['decimals'] ?? 0,
      symbol: map['symbol'] ?? '',
      chainId: map['chainId'] ?? -1,
      coinKey: map['coinKey'] ?? '',
      name: map['name'] ?? '',
      logoURI: map['logoURI'] ?? '',
      priceUSD: map['priceUSD'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenHits.fromJson(String source) =>
      TokenHits.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenHits(key: $key, address: $address, decimals: $decimals, symbol: $symbol, chainId: $chainId, coinKey: $coinKey, name: $name, logoURI: $logoURI, priceUSD: $priceUSD)';
  }

  @override
  bool operator ==(covariant TokenHits other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.address == address &&
        other.decimals == decimals &&
        other.symbol == symbol &&
        other.chainId == chainId &&
        other.coinKey == coinKey &&
        other.name == name &&
        other.logoURI == logoURI &&
        other.priceUSD == priceUSD;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        address.hashCode ^
        decimals.hashCode ^
        symbol.hashCode ^
        chainId.hashCode ^
        coinKey.hashCode ^
        name.hashCode ^
        logoURI.hashCode ^
        priceUSD.hashCode;
  }
}
