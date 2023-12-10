import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/view/view_more_account_page.dart';
import 'package:avex_mobile/provider/provider.dart';
import 'package:avex_mobile/model/account/account_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getBalance(
    {required String address, required NetworkChain chain}) async {
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
    return g;
  }
  return '0';
}

final allChainBalanceProvider =
    FutureProvider.family<double, Account>((ref, account) async {
  final dio = ref.watch(dioClientProvider);
  final response = await Future.wait(
    [
      NetworkChain.ethereumMainnet.apiChainName,
      NetworkChain.polygonMainnet.apiChainName,
      NetworkChain.avalancheMainnet.apiChainName,
      NetworkChain.arbitrumMainnet.apiChainName,
      NetworkChain.optimismMainnet.apiChainName,
      'solana'
    ]
        .map((e) =>
            dio.get('https://api.panic0.com/portfolio/v2/token/balance', data: {
              "chain": e,
              "wallet_address": switch (e) {
                'solana' => account.solanaAddress,
                'bitcoin' => account.bitcoinAddress,
                _ => account.ethAddress
              }
            }))
        .toList(),
  );
  List<double> result = response.map<double>((res) {
    if (res.statusCode != 200) return 0;

    final List items = res.data['data']['items'] ?? [];
    for (var item in items) {
      if (item['native_token']) {
        return item['quote'];
      }
    }
    return 0;
  }).toList();
  double ans = 0;
  result.map((e) => ans += e).toList();
  ref.read(totalBal.notifier).state = {
    ...ref.read(totalBal),
    account.id.toString(): ans
  };
  return ans;
});
