import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:avex_mobile/services/portfolio_v2/nft_services.dart';

final allChainNftProvider =
    StateNotifierProvider<AllChainNftStateNotifier, List<NFTModel>>(
  (ref) => AllChainNftStateNotifier(ref),
);

class AllChainNftStateNotifier extends StateNotifier<List<NFTModel>> {
  final StateNotifierProviderRef _ref;
  String? cursor = "";
  List<String> chains = [];
  bool loading = false;
  AllChainNftStateNotifier(this._ref) : super([]) {
    for (var chain in NetworkChain.values) {
      if (chain == NetworkChain.fantomMainnet ||
          chain == NetworkChain.cronosMainnet ||
          chain == NetworkChain.fireChainEvm ||
          chain == NetworkChain.xdc) continue;
      if (!chain.isTestnet) {
        chains.add(chain.apiChainName);
      }
    }
    logger.d(chains);
    fetchNFTs();
    {
      state = [];
    }
  }

  Future<void> fetchNFTs({BuildContext? context}) async {
    final address = getEthAddress(_ref);
    loading = true;
    final res = await NFTService.getListOfNFTOwned(
      address: [
        address,
        NetworkChain.solanaMainnet.address(_ref),
      ],
      chain: chains,
      ref: _ref,
    );
    res.fold(
      (l) {
        final (nftList, cursor) = l;
        state = nftList;
        this.cursor = cursor;
      },
      (r) => showSnackBar(context, r),
    );
    loading = false;
  }

  Future<void> fetchMoreNFTs(BuildContext? context) async {
    final address = getEthAddress(_ref);
    loading = true;
    if (cursor == null || cursor!.isEmpty) return;
    final res = await NFTService.getListOfNFTOwned(
      address: [
        address,
        NetworkChain.solanaMainnet.address(_ref),
      ],
      chain: chains,
      ref: _ref,
      cursor: cursor,
    );
    res.fold(
      (l) {
        final (nftList, cursor) = l;
        state = [...state, ...nftList];
        this.cursor = cursor;
      },
      (r) => {},
    );
    loading = false;
  }

  bool get isLoading => loading;
}
