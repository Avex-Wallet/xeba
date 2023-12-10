// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:eddsa_hmac/constants/network.dart';
import 'package:eddsa_hmac/services/evm/core/main.service.dart' as evm;
import 'package:ens_dart/ens_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/accounts/view/view_more_account_page.dart';
import 'package:avex_mobile/main.dart';

Future<String> getBalance(String address, int i, WidgetRef ref) async {
  final chain = ref.read(currentNetworkChainProvider);
  final response = await http.post(
    Uri.parse('https://api.panic0.com/portfolio/v1/native/balance'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      "address": address,
      "chain": chain.chainName,
    }),
  );

  if (response.statusCode == 200) {
    final g = jsonDecode(response.body)["balance"]?.toString() ?? '0';
    ref.read(totalBalance.notifier).update((state) {
      var d = {...state, address: g};
      return d;
    });
    return g;
  }
  return '0';
}

Future<String> fetchNativePrice({NetworkChain? chain, required Ref ref}) async {
  chain = chain ?? ref.read(currentNetworkChainProvider);
  var response = await http.post(
    Uri.parse('https://api.panic0.com/portfolio/v1/native/balance'),
    body: json.encode({
      "address": ref.read(accountProvider).address,
      "chain": chain!.chainName
    }),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["balance"].toString();
  } else {
    return '0';
  }
}

Future<String?> getAddressFromEns(String ensName) async {
  const network = Network.ethereumMainnet;
  var client = await evm.getSafeConnection(network);

  final ens = Ens(client: client);
  // final name = await ens
  //     .withAddress('0x1a5cdcFBA600e0c669795e0B65c344D5A37a4d5A')
  //     .getName();

  final addr = await ens.withName(ensName).getAddress();
  return addr.hex;
}
