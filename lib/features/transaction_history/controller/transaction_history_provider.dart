// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/transaction_history/views/screens/transaction_history_screen.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';
import 'package:avex_mobile/provider/provider.dart';

final chainList = [
  "ethereum",
  // "ethereum-goerli",
  "polygon",
  // "polygon-mumbai",
  "avalanche",
  "arbitrum",
  "optimism",
  "bsc",
];

final transactionHistoryProvider =
    FutureProvider.family<List<TokenTransactionModel>, int>((ref, page) {
  final selectedAllChain = ref.watch(allChainSelected);
  final chain = ref.watch(currentNetworkChainProvider);
  final dio = ref.watch(dioClientProvider);
  final address = ref.watch(accountProvider.select((value) => value.address));
  if (selectedAllChain) {
    return Future.wait(chainList
            .map(
              (e) => dio.get(
                'https://api.panic0.com/portfolio/v2/token/transaction',
                options: Options(headers: {'Content-Type': 'application/json'}),
                data: {
                  "chain": e,
                  "wallet_address": address,
                  "query": {"page": page}
                },
              ),
            )
            .toList())
        .then(
      (value) {
        List<TokenTransactionModel> list = [];
        bool flag = false;
        for (var item in value) {
          flag = flag || (item.data['pagination'] != null);
          final int chain = item.data['data']['chain_id'] as int;
          final body = item.data['data']['items'] as List?;
          final d = (body ?? []).map((e) {
            e['chain_id'] = chain;
            return TokenTransactionModel.fromMap(e);
          }).toList();
          list = [...list, ...d];
        }
        ref.read(txnPaginateProvider.notifier).update((state) => flag);
        list.sort((a, b) {
          if (b.block_signed_at == null) return 0;
          return a.block_signed_at?.compareTo(b.block_signed_at!) ?? 0;
        });
        return list;
      },
    );
  } else {
    return dio.get(
      'https://api.panic0.com/portfolio/v2/token/transaction',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {
        "chain": chain.apiChainName,
        "wallet_address": address,
        "query": {"page": page}
      },
    ).then(
      (value) {
        ref.read(txnPaginateProvider.notifier).state =
            value.data['pagination'] != null;
        final int chain = value.data['data']['chain_id'] as int;
        final body = value.data['data']['items'] as List?;
        final list = (body ?? []).map((e) {
          e['chain_id'] = chain;
          return TokenTransactionModel.fromMap(e);
        }).toList();

        return list;
      },
    );
  }
});
