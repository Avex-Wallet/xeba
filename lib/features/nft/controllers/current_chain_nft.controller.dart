import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:avex_mobile/services/portfolio_v2/nft_services.dart';

typedef NetworkNFT = Map<NetworkChain, List<NFTModel>>;

final nftProvider = StateNotifierProvider<NftTabController, NetworkNFT>(
    (ref) => NftTabController(ref));

class NftTabController extends StateNotifier<NetworkNFT> {
  final StateNotifierProviderRef _ref;
  late Map<NetworkChain, String> cursor = {};
  bool loading = false;
  NftTabController(this._ref) : super({}) {
    fetchNFTs();
  }

  Future<void> fetchNFTs({BuildContext? context}) async {
    logger.i(state[NetworkChain.solanaMainnet]);
    final chain = _ref.read(currentNetworkChainProvider);
    if (chain == NetworkChain.xdc) {
      logger.f('hello');
      String data = await rootBundle.loadString('assets/json/dd.json');
      final res = jsonDecode(data);
      final List<NFTModel> result =
          res.map<NFTModel>((element) => NFTModel.fromMap(element)).toList();
      state = {...state, chain: result};
      return;
    }

    final address = chain.address(_ref);
    loading = true;
    final res = await NFTService.getListOfNFTOwned(
      address: [address],
      chain: [chain.chainName],
      ref: _ref,
    );
    res.fold(
      (l) {
        state = {...state, chain: l.$1};
        cursor = {
          ...cursor,
          chain: l.$2,
        };
      },
      (r) => context != null ? showSnackBar(context, r) : {},
    );
    loading = false;
  }

  Future<void> fetchMoreNFTs(BuildContext? context) async {
    final chain = _ref.read(currentNetworkChainProvider);
    final address = chain.address(_ref);
    loading = true;
    if (cursor[chain] == null) return;
    if (cursor[chain]!.isEmpty) return;
    final res = await NFTService.getListOfNFTOwned(
      address: [address],
      chain: [chain.chainName],
      cursor: cursor[chain],
      ref: _ref,
    );
    res.fold(
      (l) {
        final oldList = state[chain] ?? [];
        state = {
          ...state,
          chain: [...oldList, ...l.$1],
        };
        cursor = {
          ...cursor,
          chain: l.$2,
        };
      },
      (r) {},
    );
    loading = false;
  }

  bool get isLoading => loading;
}
