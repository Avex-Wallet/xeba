import 'dart:convert';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/model/token/token_hits.dart';
import 'package:avex_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final tokenDetailProvider =
    FutureProvider.autoDispose.family<TokenHits, String>((ref, address) {
  final chain = ref.watch(currentNetworkChainProvider);
  return http
      .post(
        Uri.parse(
            'https://api.panic0.com/search/multi-search?matchingStrategy=all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer d2b52a2ef1de239afb73de5d09cd61f3969c5bf9110233713580553a31ffe08e'
        },
        body: jsonEncode({
          "queries": [
            {
              "indexUid": "tokens",
              "filter": "chainId=${chain.chainId} AND address=$address",
              "limit": 1
            }
          ]
        }),
      )
      .then((value) => jsonDecode(value.body))
      .then((value) => TokenHits.fromMap(value['results'][0]['hits'][0]));
});
