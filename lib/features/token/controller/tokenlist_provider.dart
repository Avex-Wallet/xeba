import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/provider/provider.dart';
import 'package:avex_mobile/services/local_services/db/token_db.dart';

final allTokenListFutureProvider =
    FutureProvider.family<List<TokenModel>, NetworkChain?>((ref, chain) async {
  final accountId = ref.watch(accountProvider.select((value) => value.current));
  chain = chain ?? ref.watch(currentNetworkChainProvider);
  final dio = ref.watch(dioClientProvider);
  if (chain == NetworkChain.xdc) {
    String data = await rootBundle.loadString('assets/json/data.json');
    final res = json.decode(data);
    final String chainName = res['data']['chain_name'];
    final int chainId = res['data']['chain_id'];
    final nftList = res['data']['items'] as List;
    final List<TokenModel> result = nftList
        .map<TokenModel>(
          (element) => TokenModel.fromMap(element)
            ..accountId = accountId
            ..chainId = chainId
            ..chainName = chainName,
        )
        .toList();
    ref.read(tokenDbListProvider(chainId).notifier).addTokens(result);
    return result;
  }
  final request = dio.get(ApiEndpoint.getListOfTokenOwned, data: {
    "chain": chain!.chainName,
    "wallet_address": chain.address(ref),
  });
  return request.then((value) {
    final String chainName = value.data['data']['chain_name'];
    final int chainId = value.data['data']['chain_id'];
    final nftList = value.data['data']['items'] as List;
    final List<TokenModel> result = nftList
        .map<TokenModel>(
          (element) => TokenModel.fromMap(element)
            ..accountId = accountId
            ..chainId = chainId
            ..chainName = chainName,
        )
        .toList();
    ref.read(tokenDbListProvider(chainId).notifier).addTokens(result);
    return result;
  });
});

Future<String> fetchNativePrice(WidgetRef ref, {NetworkChain? chain}) async {
  chain = chain ?? ref.read(currentNetworkChainProvider);
  final address = ref.watch(accountProvider).address;
  var response = await http.post(
    Uri.parse('https://api.panic0.com/portfolio/v1/native/balance'),
    body: json.encode({"address": address, "chain": chain!.chainName}),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["balance"].toString();
  } else {
    return '0';
  }
}
