// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/model/token/token_model.dart';

class SwapValue {
  final TokenModel? token1;
  final TokenModel? token2;
  final BigInt val1;
  final BigInt val2;
  final NetworkChain? chain1;
  final NetworkChain? chain2;
  final BigInt estimatedGas;
  SwapValue({
    this.token1,
    this.token2,
    required this.val1,
    required this.val2,
    this.chain1,
    this.chain2,
    required this.estimatedGas,
  });

  double? get getToken1Value {
    if (token1 == null) {
      return null;
    } else {
      return val1 / BigInt.from(pow(10, token2?.contract_decimals ?? 0));
    }
  }

  double? get getToken2Value {
    if (token2 == null) {
      return null;
    } else {
      return val2 / BigInt.from(pow(10, token2?.contract_decimals ?? 0));
    }
  }

  @override
  String toString() {
    return 'SwapValue(token1: $token1, token2: $token2, val1: $val1, val2: $val2, chain1: $chain1, chain2: $chain2, estimatedGas: $estimatedGas)';
  }

  SwapValue copyWith({
    TokenModel? token1,
    TokenModel? token2,
    BigInt? val1,
    BigInt? val2,
    NetworkChain? chain1,
    NetworkChain? chain2,
    BigInt? estimatedGas,
  }) {
    return SwapValue(
      token1: token1 ?? this.token1,
      token2: token2 ?? this.token2,
      val1: val1 ?? this.val1,
      val2: val2 ?? this.val2,
      chain1: chain1 ?? this.chain1,
      chain2: chain2 ?? this.chain2,
      estimatedGas: estimatedGas ?? this.estimatedGas,
    );
  }
}
