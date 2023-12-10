import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/provider/isar_provider.dart';

final tokenDbListProvider =
    StateNotifierProvider.family<TokenDbNotifier, List<TokenModel>, int>(
        (ref, apprentChainId) {
  final accountId = ref.watch(accountProvider.select((value) => value.current));
  return TokenDbNotifier(ref, apprentChainId, accountId);
});

class TokenDbNotifier extends StateNotifier<List<TokenModel>> {
  Ref ref;
  late Isar isar;
  late Stream<void> userChanged;
  final int apprentChainId;
  final int accountId;
  TokenDbNotifier(this.ref, this.apprentChainId, this.accountId) : super([]) {
    isar = ref.read(isarProvider).requireValue;
    fetchAllTokenChain();
  }

  Future<List<TokenModel>> fetchAllToken() async {
    state = await isar.tokenModels.where().findAll();
    return state;
  }

  Future<void> addTokens(List<TokenModel> tokenList) async {
    await deleteTokenModel();
    await isar.writeTxn(() async {
      await isar.tokenModels.putAll(tokenList);
    });
    fetchAllTokenChain();
  }

  Future<List<TokenModel>> fetchAllTokenChain() async {
    state = await isar.tokenModels
        .filter()
        .chainIdEqualTo(apprentChainId)
        .and()
        .accountIdEqualTo(accountId)
        .findAll();
    return state;
  }

  Future<bool> deleteTokenModel() async {
    bool status = false;
    final len = state.length;
    if (len == 1) return false;
    await isar.writeTxn(() async {
      int count = await isar.tokenModels
          .filter()
          .chainIdEqualTo(apprentChainId)
          .and()
          .accountIdEqualTo(accountId)
          .deleteAll();
      status = count > 0 ? true : false;
    });
    fetchAllTokenChain();
    return status;
  }
}
