// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class NativeTransaction {
  final String hash;
  final String nonce;
  final String transaction_index;
  final String from_address;
  final String to_address;
  final String value;
  final String gas;
  final String gas_price;
  final String input;
  final String receipt_cumulative_gas_used;
  final String receipt_gas_used;
  final String? receipt_contract_address;
  final String? receipt_root;
  final String receipt_status;
  final String block_timestamp;
  final String block_number;
  final String block_hash;
  final String? internal_transactions;
  NativeTransaction({
    required this.hash,
    required this.nonce,
    required this.transaction_index,
    required this.from_address,
    required this.to_address,
    required this.value,
    required this.gas,
    required this.gas_price,
    required this.input,
    required this.receipt_cumulative_gas_used,
    required this.receipt_gas_used,
    this.receipt_contract_address,
    this.receipt_root,
    required this.receipt_status,
    required this.block_timestamp,
    required this.block_number,
    required this.block_hash,
    this.internal_transactions,
  });

  NativeTransaction copyWith({
    String? hash,
    String? nonce,
    String? transaction_index,
    String? from_address,
    String? to_address,
    String? value,
    String? gas,
    String? gas_price,
    String? input,
    String? receipt_cumulative_gas_used,
    String? receipt_gas_used,
    String? receipt_contract_address,
    String? receipt_root,
    String? receipt_status,
    String? block_timestamp,
    String? block_number,
    String? block_hash,
    String? internal_transactions,
  }) {
    return NativeTransaction(
      hash: hash ?? this.hash,
      nonce: nonce ?? this.nonce,
      transaction_index: transaction_index ?? this.transaction_index,
      from_address: from_address ?? this.from_address,
      to_address: to_address ?? this.to_address,
      value: value ?? this.value,
      gas: gas ?? this.gas,
      gas_price: gas_price ?? this.gas_price,
      input: input ?? this.input,
      receipt_cumulative_gas_used:
          receipt_cumulative_gas_used ?? this.receipt_cumulative_gas_used,
      receipt_gas_used: receipt_gas_used ?? this.receipt_gas_used,
      receipt_contract_address:
          receipt_contract_address ?? this.receipt_contract_address,
      receipt_root: receipt_root ?? this.receipt_root,
      receipt_status: receipt_status ?? this.receipt_status,
      block_timestamp: block_timestamp ?? this.block_timestamp,
      block_number: block_number ?? this.block_number,
      block_hash: block_hash ?? this.block_hash,
      internal_transactions:
          internal_transactions ?? this.internal_transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'nonce': nonce,
      'transaction_index': transaction_index,
      'from_address': from_address,
      'to_address': to_address,
      'value': value,
      'gas': gas,
      'gas_price': gas_price,
      'input': input,
      'receipt_cumulative_gas_used': receipt_cumulative_gas_used,
      'receipt_gas_used': receipt_gas_used,
      'receipt_contract_address': receipt_contract_address,
      'receipt_root': receipt_root,
      'receipt_status': receipt_status,
      'block_timestamp': block_timestamp,
      'block_number': block_number,
      'block_hash': block_hash,
      'internal_transactions': internal_transactions,
    };
  }

  factory NativeTransaction.fromMap(Map<String, dynamic> map) {
    return NativeTransaction(
      hash: map['hash'] as String,
      nonce: map['nonce'] as String,
      transaction_index: map['transaction_index'] as String,
      from_address: map['from_address'] as String,
      to_address: map['to_address'] ?? '0x',
      value: map['value'] as String,
      gas: map['gas'] as String,
      gas_price: map['gas_price'] as String,
      input: map['input'] as String,
      receipt_cumulative_gas_used: map['receipt_cumulative_gas_used'] as String,
      receipt_gas_used: map['receipt_gas_used'] as String,
      receipt_contract_address: map['receipt_contract_address'] != null
          ? map['receipt_contract_address'] as String
          : null,
      receipt_root:
          map['receipt_root'] != null ? map['receipt_root'] as String : null,
      receipt_status: map['receipt_status'] as String,
      block_timestamp: map['block_timestamp'] as String,
      block_number: map['block_number'] as String,
      block_hash: map['block_hash'] as String,
      internal_transactions: map['internal_transactions'] != null
          ? map['internal_transactions'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NativeTransaction.fromJson(String source) =>
      NativeTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NativeTransaction(hash: $hash, nonce: $nonce, transaction_index: $transaction_index, from_address: $from_address, to_address: $to_address, value: $value, gas: $gas, gas_price: $gas_price, input: $input, receipt_cumulative_gas_used: $receipt_cumulative_gas_used, receipt_gas_used: $receipt_gas_used, receipt_contract_address: $receipt_contract_address, receipt_root: $receipt_root, receipt_status: $receipt_status, block_timestamp: $block_timestamp, block_number: $block_number, block_hash: $block_hash, internal_transactions: $internal_transactions)';
  }

  @override
  bool operator ==(covariant NativeTransaction other) {
    if (identical(this, other)) return true;

    return other.hash == hash &&
        other.nonce == nonce &&
        other.transaction_index == transaction_index &&
        other.from_address == from_address &&
        other.to_address == to_address &&
        other.value == value &&
        other.gas == gas &&
        other.gas_price == gas_price &&
        other.input == input &&
        other.receipt_cumulative_gas_used == receipt_cumulative_gas_used &&
        other.receipt_gas_used == receipt_gas_used &&
        other.receipt_contract_address == receipt_contract_address &&
        other.receipt_root == receipt_root &&
        other.receipt_status == receipt_status &&
        other.block_timestamp == block_timestamp &&
        other.block_number == block_number &&
        other.block_hash == block_hash &&
        other.internal_transactions == internal_transactions;
  }

  @override
  int get hashCode {
    return hash.hashCode ^
        nonce.hashCode ^
        transaction_index.hashCode ^
        from_address.hashCode ^
        to_address.hashCode ^
        value.hashCode ^
        gas.hashCode ^
        gas_price.hashCode ^
        input.hashCode ^
        receipt_cumulative_gas_used.hashCode ^
        receipt_gas_used.hashCode ^
        receipt_contract_address.hashCode ^
        receipt_root.hashCode ^
        receipt_status.hashCode ^
        block_timestamp.hashCode ^
        block_number.hashCode ^
        block_hash.hashCode ^
        internal_transactions.hashCode;
  }
}
