// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_model.dart';

typedef FutureTokenList = Future<Either<List<TokenModel>, String>>;

class TokenService {
  static FutureTokenList getListOfTokenOwned(
      {required String address, required String chain}) async {
    try {
      Map body = {
        "chain": chain,
        "wallet_address": address,
      };
      final request = http.Request(
        'GET',
        Uri.parse(ApiEndpoint.getListOfTokenOwned),
      )
        ..headers.addAll({'Content-Type': 'application/json'})
        ..body = json.encode(body);

      http.StreamedResponse response = await request.send();
      final data1 = await response.stream.bytesToString();
      final data = jsonDecode(data1);
      if (response.statusCode == 200) {
        final String cursor = data['next_cursor'] ?? '';
        final nftList = data['data']['items'] as List;
        final List<TokenModel> result = nftList
            .map<TokenModel>((element) => TokenModel.fromMap(element))
            .toList();
        logger.t(result);
        return left(result);
      } else {
        logger.e('Code ${data['code']}: " + ${data['message']}');
        return right('Code ${data['code']}: " + ${data['message']}');
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  static Future<String> getNativeTransaction(
      {required NetworkChain chain,
      int? page = 0,
      required String address}) async {
    Map body = {
      "chain": chain.chainName,
      "wallet_address": address,
      "query": {"page": page},
    };
    final request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.nativeTokenTransactionHistory),
    )
      ..headers.addAll({'Content-Type': 'application/json'})
      ..body = json.encode(body);
    http.StreamedResponse response = await request.send();
    final data1 = await response.stream.bytesToString();
    return data1;
  }
}
