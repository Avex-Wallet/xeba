// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/services/portfolio_v2/token_service.dart';

typedef TokenState = Map<NetworkChain, List<TokenModel>?>;

class TokenProviderState {
  TokenState networkTokenMap;
  bool isLoading;
  TokenProviderState({
    required this.networkTokenMap,
    required this.isLoading,
  });

  TokenProviderState copyWith({
    TokenState? networkTokenMap,
    bool? isLoading,
  }) {
    return TokenProviderState(
      networkTokenMap: networkTokenMap ?? this.networkTokenMap,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final tokenListProvider =
    StateNotifierProvider<_PortfolioV2TokenNotifier, TokenProviderState>((ref) {
  return _PortfolioV2TokenNotifier(ref);
});

class _PortfolioV2TokenNotifier extends StateNotifier<TokenProviderState> {
  final StateNotifierProviderRef ref;
  _PortfolioV2TokenNotifier(this.ref)
      : super(TokenProviderState(isLoading: false, networkTokenMap: {})) {
    fetch();
  }

  Future<void> fetch({BuildContext? context}) async {
    final response = await TokenService.getListOfTokenOwned(
        address: address, chain: chain.chainName);
    response.fold((l) {
      state = state.copyWith(networkTokenMap: {
        ...state.networkTokenMap,
        chain: l,
      });
    }, (r) => context != null ? showSnackBar(context, r) : {});
  }

  List<TokenModel>? get tokenList => state.networkTokenMap[chain];

  //** Helper function */
  NetworkChain get chain => ref.read(currentNetworkChainProvider);
  String get address => ref.read(accountProvider).address;
}
