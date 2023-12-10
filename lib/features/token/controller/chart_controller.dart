import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/enums/chart_enum.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final chartTabIndex = StateProvider<ChartDay>((ref) => ChartDay.D);

final chartDataProvider =
    FutureProvider.family<List<double>, TokenModel>((ref, token) {
  final chain = token.networkChainFromId;
  final index = ref.watch(chartTabIndex);
  final url = token.native_token
      ? 'https://api.coingecko.com/api/v3/coins/${chain.coinGeckoId}/market_chart?vs_currency=usd&days=${index.days}'
      : 'https://api.coingecko.com/api/v3/coins/${chain.coinGeckoId}/contract/${token.contract_address}/market_chart?vs_currency=usd&days=${index.days}';

  final endpoint = Uri.parse(url);
  return http
      .get(endpoint)
      .then((value) => (jsonDecode(value.body)['prices'] ?? []))
      .then((value) {
    return value.map<double>((e) => double.parse(e[1].toString())).toList();
  });
});
