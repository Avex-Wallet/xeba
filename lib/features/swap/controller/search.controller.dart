import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/swap/model/token_hits.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';

final searchTokenProvider = StateNotifierProvider.autoDispose<
    SearchTokenNotifier, (List<TokenHit>, bool)>(
  (ref) {
    final chainTabIndex = ref.watch(chainTabIndexProvider);
    final chainId = NetworkChain.values[chainTabIndex].chainId;
    return SearchTokenNotifier(ref, chainId);
  },
);

class SearchTokenNotifier extends StateNotifier<(List<TokenHit>, bool)> {
  Ref ref;
  final int chainId;
  SearchTokenNotifier(this.ref, this.chainId) : super(([], true)) {
    search();
  }

  Future<bool> search({String? q, int? page, int? hitPerPage}) async {
    logger.i('q => $q');
    state = (state.$1, true);
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.panic0.com/search/indexes/evm_tokens/search?page=1&hitsPerPage=100&filter=chainId=$chainId&q=${q ?? ""}'),
        headers: {
          'Authorization':
              'Bearer 4c709bab8214057cdf2b875cab2317cce874bfcdfb99d8ae3839d5b22ab59644'
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["hits"] as List;
        final result = data.map((e) => TokenHit.fromMap(e)).toList();
        // logger.t(result);
        state = (result, false);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        //print(e.toString());
      }
    }
    state = (state.$1, false);
    return false;
  }
}

final q = StateProvider<String>((ref) => '');
final searchTokenListProviders = FutureProvider<List<TokenHit>>(
  (ref) {
    final chainTabIndex = ref.watch(chainTabIndexProvider);
    final chainId = NetworkChain.values[chainTabIndex].chainId;
    final qtoken = ref.watch(q);
    return http
        .get(
          Uri.parse(
              'https://api.panic0.com/search/indexes/tokens/search?page=1&hitsPerPage=100&filter=chainId=$chainId&q=$qtoken'),
          headers: {
            'Authorization':
                'Bearer d2b52a2ef1de239afb73de5d09cd61f3969c5bf9110233713580553a31ffe08e'
          },
        )
        .then((response) => jsonDecode(response.body)["hits"] as List)
        .then((data) => data.map((e) {
              logger.t(e);
              return TokenHit.fromMap(e);
            }).toList())
        .then((v) {
          logger.t(v);
          return v;
        });
  },
);
