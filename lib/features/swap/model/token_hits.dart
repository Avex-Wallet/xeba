import 'dart:convert';

class TokenHit {
  final String key;
  final String address;
  final int decimals;
  final String symbol;
  final int chainId;
  final String coinKey;
  final String name;
  final String logoURI;
  final String priceUSD;
  TokenHit({
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

  TokenHit copyWith({
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
    return TokenHit(
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

  factory TokenHit.fromMap(Map<String, dynamic> map) {
    return TokenHit(
      key: map['key'] as String,
      address: map['address'] as String,
      decimals: map['decimals'].toInt() as int,
      symbol: map['symbol'] as String,
      chainId: map['chainId'].toInt() as int,
      coinKey: map['coinKey'] as String,
      name: map['name'] as String,
      logoURI: map['logoURI'] as String,
      priceUSD: map['priceUSD'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenHit.fromJson(String source) => TokenHit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenHit(key: $key, address: $address, decimals: $decimals, symbol: $symbol, chainId: $chainId, coinKey: $coinKey, name: $name, logoURI: $logoURI, priceUSD: $priceUSD)';
  }

  @override
  bool operator ==(covariant TokenHit other) {
    if (identical(this, other)) return true;
  
    return 
      other.key == key &&
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