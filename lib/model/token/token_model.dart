// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types
import 'dart:convert';
import 'dart:math';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/core/utils/functions.dart';
import 'package:isar/isar.dart';

part 'token_model.g.dart';

@collection
class TokenModel {
  Id get isarId =>
      fastHash('Account:$accountId::ChainId:$chainId::$contract_address');
  late int? chainId;
  late int? accountId;
  late String? chainName;
  late int contract_decimals;
  late String contract_name;
  late String contract_ticker_symbol;
  late String contract_address;
  late String logo_url;
  late String last_transferred_at;
  late bool native_token;
  late String type;
  late bool is_spam;
  late String balance;
  late String quote_rate;
  late double quote;
  late String pretty_quote;
  /*
  final int contract_decimals;
  final String contract_name;
  final String contract_ticker_symbol;
  final String contract_address;
  final String logo_url;
  final String last_transferred_at;
  final bool native_token;
  final String type;
  final bool is_spam;
  final String balance;
  final String quote_rate;
  final double quote;
  final String pretty_quote;
  */
  double get valueInEther =>
      BigInt.parse(balance) / BigInt.from(pow(10, contract_decimals));

  TokenModel({
    required this.contract_decimals,
    required this.contract_name,
    required this.contract_ticker_symbol,
    required this.contract_address,
    required this.logo_url,
    required this.last_transferred_at,
    required this.native_token,
    required this.type,
    required this.is_spam,
    required this.balance,
    required this.quote_rate,
    required this.quote,
    required this.pretty_quote,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contract_decimals': contract_decimals,
      'contract_name': contract_name,
      'contract_ticker_symbol': contract_ticker_symbol,
      'contract_address': contract_address,
      'logo_url': logo_url,
      'last_transferred_at': last_transferred_at,
      'native_token': native_token,
      'type_': type,
      'is_spam': is_spam,
      'balance': balance,
      'quote_rate': quote_rate,
      'quote': quote,
      'pretty_quote': pretty_quote,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      contract_decimals: map['contract_decimals'] ?? '1',
      contract_name: map['contract_name'] ?? '',
      contract_ticker_symbol: map['contract_ticker_symbol'] ?? '',
      contract_address: map['contract_address'] ?? '0x',
      logo_url: map['logo_url'] ?? '',
      last_transferred_at: map['last_transferred_at'] ?? '',
      native_token: map['native_token'] ?? false,
      type: map['type_'] ?? '',
      is_spam: map['is_spam'] ?? true,
      balance: map['balance'] ?? '0',
      quote_rate: (map['quote_rate'] ?? '0.0').toString(),
      quote: map['quote'] ?? 0.0,
      pretty_quote: map['pretty_quote'] ?? '\$0.0',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenModel(contract_decimals: $contract_decimals, contract_name: $contract_name, contract_ticker_symbol: $contract_ticker_symbol, contract_address: $contract_address, logo_url: $logo_url, last_transferred_at: $last_transferred_at, native_token: $native_token, type: $type, is_spam: $is_spam, balance: $balance, quote_rate: $quote_rate, quote: $quote, pretty_quote: $pretty_quote)';
  }

  @override
  bool operator ==(covariant TokenModel other) {
    if (identical(this, other)) return true;

    return other.contract_decimals == contract_decimals &&
        other.contract_name == contract_name &&
        other.contract_ticker_symbol == contract_ticker_symbol &&
        other.contract_address == contract_address &&
        other.logo_url == logo_url &&
        other.last_transferred_at == last_transferred_at &&
        other.native_token == native_token &&
        other.type == type &&
        other.is_spam == is_spam &&
        other.balance == balance &&
        other.quote_rate == quote_rate &&
        other.quote == quote &&
        other.pretty_quote == pretty_quote;
  }

  @override
  int get hashCode {
    return contract_decimals.hashCode ^
        contract_name.hashCode ^
        contract_ticker_symbol.hashCode ^
        contract_address.hashCode ^
        logo_url.hashCode ^
        last_transferred_at.hashCode ^
        native_token.hashCode ^
        type.hashCode ^
        is_spam.hashCode ^
        balance.hashCode ^
        quote_rate.hashCode ^
        quote.hashCode ^
        pretty_quote.hashCode;
  }
}

extension NetworkFromChainIdExtension on TokenModel {
  NetworkChain get networkChainFromId {
    switch (chainId) {
      case 1:
        return NetworkChain.ethereumMainnet;
      case 11155111:
        return NetworkChain.ethereumSepolia;
      case 5:
        return NetworkChain.ethereumGoerli;
      case 137:
        return NetworkChain.polygonMainnet;
      case 80001:
        return NetworkChain.polygonMumbai;
      case 43114:
        return NetworkChain.avalancheMainnet;
      case 43113:
        return NetworkChain.avalancheFuji;
      case 250:
        return NetworkChain.fantomMainnet;
      case 4002:
        return NetworkChain.fantomTestnet;
      case 42161:
        return NetworkChain.arbitrumMainnet;
      case 421613:
        return NetworkChain.arbitrumGoerli;
      case 10:
        return NetworkChain.optimismMainnet;
      case 420:
        return NetworkChain.optimismGoerli;
      case 56:
        return NetworkChain.binanceSmartChainMainnet;
      case 97:
        return NetworkChain.binanceSmartChainTestnet;
      case 25:
        return NetworkChain.cronosMainnet;
      case 338:
        return NetworkChain.cronosTestnet;
      case 997:
        return NetworkChain.fireChainEvm;
      case 1399811149:
        return NetworkChain.solanaMainnet;
      case 50:
        return NetworkChain.xdc;
      default:
        throw Exception("Unknown chainId: $chainId");
    }
  }
}
