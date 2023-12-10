import 'dart:convert';

import 'package:avex_mobile/features/send_transaction/views/components/select_asset_bottomsheet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final sendTokenListProvider = FutureProvider<List<TokenModel>>((ref) async {
  final chain = ref.watch(sendNetworkProvider);
  if (chain == NetworkChain.xdc) {
    String data = await rootBundle.loadString('assets/json/data.json');
    final res = json.decode(data);
    final String chainName = res['data']['chain_name'];
    final int chainId = res['data']['chain_id'];
    final nftList = res['data']['items'] as List;
    final List<TokenModel> result = nftList
        .map<TokenModel>(
          (element) => TokenModel.fromMap(element)
            ..accountId = 1
            ..chainId = chainId
            ..chainName = chainName,
        )
        .toList();
    return result;
  }
  final address = ref.watch(accountProvider);
  Map body = {"chain": chain.chainName, "wallet_address": address.address};
  final request = http.Request(
    'GET',
    Uri.parse(ApiEndpoint.getListOfTokenOwned),
  )
    ..headers.addAll({'Content-Type': 'application/json'})
    ..body = jsonEncode(body);

  return request
      .send()
      .then((value) => value.stream.bytesToString())
      .then((value) {
    logger.i(value);
    return jsonDecode(value);
  }).then((value) {
    logger.t(value);
    final nftList = value['data']['items'] as List;
    final List<TokenModel> result = nftList
        .map<TokenModel>((element) => TokenModel.fromMap(element))
        .toList();
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
