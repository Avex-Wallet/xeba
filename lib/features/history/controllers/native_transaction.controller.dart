// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/history/models/native_transaction.model.dart';
import 'package:avex_mobile/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:avex_mobile/core/core.dart' as core;

typedef _stateType = Map<NetworkChain, List<NativeTransaction>>;

final nativeTransactionProvider = StateNotifierProvider.autoDispose<
    NativeTransactionStateNotifier, _stateType>(
  (ref) => NativeTransactionStateNotifier(ref),
);

class NativeTransactionStateNotifier extends StateNotifier<_stateType> {
  final StateNotifierProviderRef _ref;
  bool isLoading = false;
  late Map<NetworkChain, String?> cursor;
  NativeTransactionStateNotifier(this._ref) : super({}) {
    cursor = {};
  }

  Future<void> fetchData({NetworkChain? chain}) async {
    chain ??= _ref.read(currentNetworkChainProvider);
    final address = _ref.read(accountProvider).address;
    isLoading = true;
    try {
      const String endpoint =
          'https://api.panic0.com/portfolio/v1/native/transaction/detail';
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "address": address,
          "chain": chain!.chainName,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        cursor[chain] = data['cursor'];
        if (data['result'] != null) {
          final list = (data['result'] as List)
              .map((e) => NativeTransaction.fromMap(e))
              .toList();
          state = {...state, chain: list};
          logger.t(state);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        //print(e.toString());
      }
    }
    isLoading = false;
  }

  Future<void> paginate({NetworkChain? chain}) async {
    chain ??= _ref.read(currentNetworkChainProvider);
    if (cursor[chain] == null || cursor[chain]!.isEmpty) return;
    isLoading = true;
    const String endpoint =
        'https://api.panic0.com/portfolio/v1/native/transaction/detail';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "address": _ref.read(accountProvider).address,
        "chain": chain!.chainName,
        'cursor': cursor[chain]!,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      cursor[chain] = data['cursor'];
      if (data['result'] != null) {
        final String? cur = data['cursor'];
        cursor[chain] = cur;
        final list = (data['result'] as List)
            .map((e) => NativeTransaction.fromMap(e))
            .toList();

        state = {
          ...state,
          chain: [...state[chain] ?? [], ...list]
        };
      }
    }
    isLoading = false;
  }
}
