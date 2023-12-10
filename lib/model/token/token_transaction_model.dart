// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class TokenTransactionModel {
  final int? chain_id;
  final String? block_signed_at;
  final int? block_height;
  final String? tx_hash;
  final bool? successful;
  final String? from_address;
  final String? to_address;
  final String? value;
  final double? value_quote;
  final String? pretty_value_quote;
  final int? gas_offered;
  final int? gas_spent;
  final int? gas_price;
  final String? fees_paid;
  final double? gas_quote;
  final String? pretty_gas_quote;
  final double? gas_quote_rate;
  // final List<Transfer> transfers;
  TokenTransactionModel({
    this.chain_id,
    required this.block_signed_at,
    required this.block_height,
    required this.tx_hash,
    required this.successful,
    required this.from_address,
    required this.to_address,
    required this.value,
    required this.value_quote,
    required this.pretty_value_quote,
    required this.gas_offered,
    required this.gas_spent,
    required this.gas_price,
    required this.fees_paid,
    required this.gas_quote,
    required this.pretty_gas_quote,
    required this.gas_quote_rate,
  });

  TokenTransactionModel copyWith({
    int? chain_id,
    String? block_signed_at,
    int? block_height,
    String? tx_hash,
    bool? successful,
    String? from_address,
    String? to_address,
    String? value,
    double? value_quote,
    String? pretty_value_quote,
    int? gas_offered,
    int? gas_spent,
    int? gas_price,
    String? fees_paid,
    double? gas_quote,
    String? pretty_gas_quote,
    double? gas_quote_rate,
  }) {
    return TokenTransactionModel(
      chain_id: chain_id ?? this.chain_id,
      block_signed_at: block_signed_at ?? this.block_signed_at,
      block_height: block_height ?? this.block_height,
      tx_hash: tx_hash ?? this.tx_hash,
      successful: successful ?? this.successful,
      from_address: from_address ?? this.from_address,
      to_address: to_address ?? this.to_address,
      value: value ?? this.value,
      value_quote: value_quote ?? this.value_quote,
      pretty_value_quote: pretty_value_quote ?? this.pretty_value_quote,
      gas_offered: gas_offered ?? this.gas_offered,
      gas_spent: gas_spent ?? this.gas_spent,
      gas_price: gas_price ?? this.gas_price,
      fees_paid: fees_paid ?? this.fees_paid,
      gas_quote: gas_quote ?? this.gas_quote,
      pretty_gas_quote: pretty_gas_quote ?? this.pretty_gas_quote,
      gas_quote_rate: gas_quote_rate ?? this.gas_quote_rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chain_id': chain_id,
      'block_signed_at': block_signed_at,
      'block_height': block_height,
      'tx_hash': tx_hash,
      'successful': successful,
      'from_address': from_address,
      'to_address': to_address,
      'value': value,
      'value_quote': value_quote,
      'pretty_value_quote': pretty_value_quote,
      'gas_offered': gas_offered,
      'gas_spent': gas_spent,
      'gas_price': gas_price,
      'fees_paid': fees_paid,
      'gas_quote': gas_quote,
      'pretty_gas_quote': pretty_gas_quote,
      'gas_quote_rate': gas_quote_rate,
    };
  }

  factory TokenTransactionModel.fromMap(Map<String, dynamic> map) {
    return TokenTransactionModel(
      chain_id: map['chain_id'] != null ? map['chain_id'] as int : null,
      block_signed_at: map['block_signed_at'] != null
          ? map['block_signed_at'] as String
          : null,
      block_height:
          map['block_height'] != null ? map['block_height'] as int : null,
      tx_hash: map['tx_hash'] != null ? map['tx_hash'] as String : null,
      successful: map['successful'] != null ? map['successful'] as bool : null,
      from_address:
          map['from_address'] != null ? map['from_address'] as String : null,
      to_address:
          map['to_address'] != null ? map['to_address'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      value_quote:
          map['value_quote'] != null ? map['value_quote'] as double : null,
      pretty_value_quote: map['pretty_value_quote'] != null
          ? map['pretty_value_quote'] as String
          : null,
      gas_offered:
          map['gas_offered'] != null ? map['gas_offered'] as int : null,
      gas_spent: map['gas_spent'] != null ? map['gas_spent'] as int : null,
      gas_price: map['gas_price'] != null ? map['gas_price'] as int : null,
      fees_paid: map['fees_paid'] != null ? map['fees_paid'] as String : null,
      gas_quote: map['gas_quote'] != null ? map['gas_quote'] as double : null,
      pretty_gas_quote: map['pretty_gas_quote'] != null
          ? map['pretty_gas_quote'] as String
          : null,
      gas_quote_rate: map['gas_quote_rate'] != null
          ? map['gas_quote_rate'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenTransactionModel.fromJson(String source) =>
      TokenTransactionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenTransactionModel(chain_id: $chain_id, block_signed_at: $block_signed_at, block_height: $block_height, tx_hash: $tx_hash, successful: $successful, from_address: $from_address, to_address: $to_address, value: $value, value_quote: $value_quote, pretty_value_quote: $pretty_value_quote, gas_offered: $gas_offered, gas_spent: $gas_spent, gas_price: $gas_price, fees_paid: $fees_paid, gas_quote: $gas_quote, pretty_gas_quote: $pretty_gas_quote, gas_quote_rate: $gas_quote_rate)';
  }

  @override
  bool operator ==(covariant TokenTransactionModel other) {
    if (identical(this, other)) return true;

    return other.chain_id == chain_id &&
        other.block_signed_at == block_signed_at &&
        other.block_height == block_height &&
        other.tx_hash == tx_hash &&
        other.successful == successful &&
        other.from_address == from_address &&
        other.to_address == to_address &&
        other.value == value &&
        other.value_quote == value_quote &&
        other.pretty_value_quote == pretty_value_quote &&
        other.gas_offered == gas_offered &&
        other.gas_spent == gas_spent &&
        other.gas_price == gas_price &&
        other.fees_paid == fees_paid &&
        other.gas_quote == gas_quote &&
        other.pretty_gas_quote == pretty_gas_quote &&
        other.gas_quote_rate == gas_quote_rate;
  }

  @override
  int get hashCode {
    return chain_id.hashCode ^
        block_signed_at.hashCode ^
        block_height.hashCode ^
        tx_hash.hashCode ^
        successful.hashCode ^
        from_address.hashCode ^
        to_address.hashCode ^
        value.hashCode ^
        value_quote.hashCode ^
        pretty_value_quote.hashCode ^
        gas_offered.hashCode ^
        gas_spent.hashCode ^
        gas_price.hashCode ^
        fees_paid.hashCode ^
        gas_quote.hashCode ^
        pretty_gas_quote.hashCode ^
        gas_quote_rate.hashCode;
  }

  elementAt(int index) {}
}

class Transfer {
  final String? block_signed_at;
  final String? tx_hash;
  final String? from_address;
  final String? to_address;
  final int? contract_decimals;
  final String? contract_name;
  final String? contract_ticker_symbol;
  final String? contract_address;
  final String? transfer_type;
  final String? delta;
  final String? logo_url;
  final double? qoute_rate;
  final double? delta_qoute;
  final double? delta_quote;
  final String? pretty_delta_quote;

  Transfer({
    required this.block_signed_at,
    required this.tx_hash,
    required this.from_address,
    required this.to_address,
    required this.contract_decimals,
    required this.contract_name,
    required this.contract_ticker_symbol,
    required this.contract_address,
    required this.transfer_type,
    required this.delta,
    required this.logo_url,
    required this.qoute_rate,
    required this.delta_qoute,
    required this.delta_quote,
    required this.pretty_delta_quote,
  });

  Transfer copyWith({
    String? block_signed_at,
    String? tx_hash,
    String? from_address,
    String? to_address,
    int? contract_decimals,
    String? contract_name,
    String? contract_ticker_symbol,
    String? contract_address,
    String? transfer_type,
    String? delta,
    String? logo_url,
    double? qoute_rate,
    double? delta_qoute,
    double? delta_quote,
    String? pretty_delta_quote,
  }) {
    return Transfer(
      block_signed_at: block_signed_at ?? this.block_signed_at,
      tx_hash: tx_hash ?? this.tx_hash,
      from_address: from_address ?? this.from_address,
      to_address: to_address ?? this.to_address,
      contract_decimals: contract_decimals ?? this.contract_decimals,
      contract_name: contract_name ?? this.contract_name,
      contract_ticker_symbol:
          contract_ticker_symbol ?? this.contract_ticker_symbol,
      contract_address: contract_address ?? this.contract_address,
      transfer_type: transfer_type ?? this.transfer_type,
      delta: delta ?? this.delta,
      logo_url: logo_url ?? this.logo_url,
      qoute_rate: qoute_rate ?? this.qoute_rate,
      delta_qoute: delta_qoute ?? this.delta_qoute,
      delta_quote: delta_quote ?? this.delta_quote,
      pretty_delta_quote: pretty_delta_quote ?? this.pretty_delta_quote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'block_signed_at': block_signed_at,
      'tx_hash': tx_hash,
      'from_address': from_address,
      'to_address': to_address,
      'contract_decimals': contract_decimals,
      'contract_name': contract_name,
      'contract_ticker_symbol': contract_ticker_symbol,
      'contract_address': contract_address,
      'transfer_type': transfer_type,
      'delta': delta,
      'logo_url': logo_url,
      'qoute_rate': qoute_rate,
      'delta_qoute': delta_qoute,
      'delta_quote': delta_quote,
      'pretty_delta_quote': pretty_delta_quote,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      block_signed_at: map['block_signed_at'] != null
          ? map['block_signed_at'] as String
          : null,
      tx_hash: map['tx_hash'] != null ? map['tx_hash'] as String : null,
      from_address:
          map['from_address'] != null ? map['from_address'] as String : null,
      to_address:
          map['to_address'] != null ? map['to_address'] as String : null,
      contract_decimals: map['contract_decimals'] != null
          ? map['contract_decimals'] as int
          : null,
      contract_name:
          map['contract_name'] != null ? map['contract_name'] as String : null,
      contract_ticker_symbol: map['contract_ticker_symbol'] != null
          ? map['contract_ticker_symbol'] as String
          : null,
      contract_address: map['contract_address'] != null
          ? map['contract_address'] as String
          : null,
      transfer_type:
          map['transfer_type'] != null ? map['transfer_type'] as String : null,
      delta: map['delta'] != null ? map['delta'] as String : null,
      logo_url: map['logo_url'] != null ? map['logo_url'] as String : null,
      qoute_rate:
          map['qoute_rate'] != null ? map['qoute_rate'] as double : null,
      delta_qoute:
          map['delta_qoute'] != null ? map['delta_qoute'] as double : null,
      delta_quote:
          map['delta_quote'] != null ? map['delta_quote'] as double : null,
      pretty_delta_quote: map['pretty_delta_quote'] != null
          ? map['pretty_delta_quote'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transfer(block_signed_at: $block_signed_at, tx_hash: $tx_hash, from_address: $from_address, to_address: $to_address, contract_decimals: $contract_decimals, contract_name: $contract_name, contract_ticker_symbol: $contract_ticker_symbol, contract_address: $contract_address, transfer_type: $transfer_type, delta: $delta, logo_url: $logo_url, qoute_rate: $qoute_rate, delta_qoute: $delta_qoute, delta_quote: $delta_quote, pretty_delta_quote: $pretty_delta_quote)';
  }

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) return true;

    return other.block_signed_at == block_signed_at &&
        other.tx_hash == tx_hash &&
        other.from_address == from_address &&
        other.to_address == to_address &&
        other.contract_decimals == contract_decimals &&
        other.contract_name == contract_name &&
        other.contract_ticker_symbol == contract_ticker_symbol &&
        other.contract_address == contract_address &&
        other.transfer_type == transfer_type &&
        other.delta == delta &&
        other.logo_url == logo_url &&
        other.qoute_rate == qoute_rate &&
        other.delta_qoute == delta_qoute &&
        other.delta_quote == delta_quote &&
        other.pretty_delta_quote == pretty_delta_quote;
  }

  @override
  int get hashCode {
    return block_signed_at.hashCode ^
        tx_hash.hashCode ^
        from_address.hashCode ^
        to_address.hashCode ^
        contract_decimals.hashCode ^
        contract_name.hashCode ^
        contract_ticker_symbol.hashCode ^
        contract_address.hashCode ^
        transfer_type.hashCode ^
        delta.hashCode ^
        logo_url.hashCode ^
        qoute_rate.hashCode ^
        delta_qoute.hashCode ^
        delta_quote.hashCode ^
        pretty_delta_quote.hashCode;
  }
}
