import 'dart:convert';

import 'package:avex_mobile/features/swap/view/components/network_change.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final swapTokenListProvider =
    FutureProvider.autoDispose<List<TokenModel>>((ref) {
  final chain = ref.watch(swapNetworkProvider);
  final address = ref.watch(accountProvider);
  Map body = {"chain": chain.chainName, "wallet_address": address.address};
  final request = http.Request(
    'GET',
    Uri.parse(ApiEndpoint.getListOfTokenOwned),
  )
    ..headers.addAll({'Content-Type': 'application/json'})
    ..body = json.encode(body);

  return request
      .send()
      .then((value) => value.stream.bytesToString())
      .then((value) => jsonDecode(value))
      .then((value) {
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
