import 'package:avex_mobile/model/token/token_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';
import 'package:avex_mobile/provider/provider.dart';

final possibleConnectionProvider = FutureProvider.autoDispose<Set<String>>(
  (ref) {
    final token1 = ref.watch(token1Provider);
    final dio = ref.watch(dioClientProvider);
    final chainTabIndex = ref.watch(chainTabIndexProvider);
    final chainId = NetworkChain.values[chainTabIndex].chainId;
    if (token1 == null) return {};
    logger.e(
        'https://li.quest/v1/connections?fromChain=${token1.$2.chainId}&fromToken=${token1.$1.contract_ticker_symbol}');
    return dio
        .get(
            'https://li.quest/v1/connections?fromChain=${token1.$2.chainId}&toChain=$chainId&fromToken=${token1.$1.contract_ticker_symbol}')
        .then((value) => value.data['connections'][0]['toTokens'] as List?)
        .then(
          (value) => (value ?? [])
              .map((e) => e['address'].toString().toLowerCase())
              .toSet(),
        );
  },
);

final possibleConnectionProviderT =
    FutureProvider.family<Set<String>, (TokenModel, NetworkChain)?>(
  (ref, token1) {
    final dio = ref.watch(dioClientProvider);
    final chainTabIndex = ref.watch(chainTabIndexProvider);
    final chainId = NetworkChain.values[chainTabIndex].chainId;
    if (token1 == null) return {};
    logger.e(
        'https://li.quest/v1/connections?fromChain=${token1.$2.chainId}&fromToken=${token1.$1.contract_ticker_symbol}');
    return dio
        .get(
            'https://li.quest/v1/connections?fromChain=${token1.$2.chainId}&toChain=$chainId&fromToken=${token1.$1.contract_ticker_symbol}')
        .then((value) => value.data['connections'][0]['toTokens'] as List?)
        .then(
          (value) => (value ?? [])
              .map((e) => e['address'].toString().toLowerCase())
              .toSet(),
        );
  },
);
