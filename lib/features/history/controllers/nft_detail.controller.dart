// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/main.dart';

class NftDetailBody {
  String contractAddress;
  String? chain;
  String tokenId;
  NftDetailBody({
    required this.contractAddress,
    required this.chain,
    required this.tokenId,
  });
}

final nftDetailProvider =
    FutureProvider.autoDispose.family<List<String>, NftDetailBody>((ref, body) {
  final chain = ref.watch(currentNetworkChainProvider);
  return http
      .post(Uri.parse('http://portfolio.panic0.com//nft/metadata'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "address": body.contractAddress,
            "chain": body.chain ?? chain.chainName,
            "token_id": body.tokenId
          }))
      .then((value) => jsonDecode(value.body))
      .then((data) {
    final metadata = data['metadata'] ?? '';
    final token_uri = data['token_uri'] ?? "";
    return [metadata, token_uri];
  });
  // .then((value) => NFTModel.fromMap(value));
});

Future<List<String>?> fetchNFTDetail(NftDetailBody body) async {
  final res = await http.post(
    Uri.parse('https://api.panic0.com/portfolio/v1/nft/metadata'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "address": body.contractAddress,
      "chain": body.chain ?? 'eth',
      "token_id": body.tokenId
    }),
  );
  //print(res.statusCode);
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final metadata = data['metadata'] ?? '';
    final token_uri = data['token_uri'] ?? "";
    //print('$metadata => $token_uri');
    return [metadata, token_uri];
  }
  return null;
}
