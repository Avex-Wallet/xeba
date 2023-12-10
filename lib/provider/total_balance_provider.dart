import 'dart:convert';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:avex_mobile/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final totalBalanceProvider =
    StateNotifierProvider<TotalBalanceNotifier, double>((ref) {
  ref.watch(accountProvider.select((value) => value.address));
  ref.watch(allChainSelected);
  ref.watch(currentNetworkChainProvider);
  return TotalBalanceNotifier(ref);
});

class TotalBalanceNotifier extends StateNotifier<double> {
  final StateNotifierProviderRef ref;
  TotalBalanceNotifier(this.ref) : super(0.0) {
    reload();
  }

  reload() {
    state = 0;
    if (ref.read(allChainSelected)) {
      _getAllTokenBalance();
      _getNFTPrice();
    } else {
      _getTokenBalance();
    }
  }

  void _getAllTokenBalance() async {
    try {
      for (var i in NetworkChain.values) {
        if (!i.isTestnet) {
          ref.watch(allTokenListFutureProvider(i)).when(
                error: (e, s) => [],
                loading: () => [],
                data: (data) {
                  double value = 0;
                  for (var i in data) {
                    value += i.quote;
                  }
                  state = state + value;
                },
              );
        }
      }
    } catch (e) {
      //
    }
  }

  void _getTokenBalance() async {
    try {
      double value = 0.0;
      final chain = ref.read(currentNetworkChainProvider);
      ref.read(allTokenListFutureProvider(chain)).when<void>(
            data: (data) {
              for (var i in data) {
                value += i.quote;
              }
              state = state + value;
            },
            error: (Object error, StackTrace stackTrace) {},
            loading: () {},
          );
    } catch (e) {
      //
    }
  }

  void _getNFTPrice() async {
    try {
      final address = ref.watch(accountProvider).address;
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'GET',
        Uri.parse('https://api.panic0.com/portfolio/v2/nft/wallet/value'),
      );
      request.body = json.encode({
        "wallet_addresses": [address]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = jsonDecode(await response.stream.bytesToString());
        final value = body['wallets'][1]['usd_value'] ?? 0.0;
        logger.f(value);
        if (value > 0.0) {
          state = state + value;
        }
      } else {}
    } catch (e) {
      if (kDebugMode) {
        //print('Erro : e');
      }
    }
  }
}
