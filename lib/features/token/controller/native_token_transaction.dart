import 'dart:convert';

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';
import 'package:avex_mobile/services/portfolio_v2/token_service.dart';

typedef ChainPageTuple = (NetworkChain, int?);
final nativeTokenTransaction =
    FutureProvider.family<List<TokenTransactionModel>, ChainPageTuple>(
        (ref, chainPageTuple) {
  final (NetworkChain chain, int? page) = chainPageTuple;
  final address = ref.watch(accountProvider.select((value) => value.address));
  return TokenService.getNativeTransaction(
          chain: chain, page: page, address: address)
      .then((value) => jsonDecode(value)['data']['items'] as List?)
      .then((value) =>
          (value ?? []).map((e) => TokenTransactionModel.fromMap(e)).toList());
});
