import 'package:avex_mobile/provider/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/model/account/account_collection.dart';
import 'package:avex_mobile/services/local_services/shared_pref/shared_pref.dart';

export 'package:avex_mobile/model/account/account_collection.dart';

final accountListProvider =
    StateNotifierProvider<AccountDbNotifier, List<Account>>(
        (ref) => AccountDbNotifier(ref));

class AccountDbNotifier extends StateNotifier<List<Account>> {
  Ref ref;
  late Isar isar;
  late Stream<void> userChanged;
  AccountDbNotifier(this.ref) : super([]) {
    isar = ref.read(isarProvider).requireValue;
  }

  Future<void> init() async {
    try {
      if ((await fetchAllAccount()).isEmpty) {
        await ref.read(sharedPref).setCurrentAccountCount(0);
        await createAccount(id: 0);
      }
      userChanged = isar.accounts.watchLazy(fireImmediately: true);
      userChanged.listen((event) {
        fetchAllAccount();
      });
    } catch (e, s) {
      logger.e(e.toString());
      logger.f(s);
    }
  }

  Future<List<Account>> fetchAllAccount() async {
    state = await isar.accounts.where().findAll();
    return state;
  }

  Future<int> createAccount({int? id}) async {
    final len = state.length;
    final Account acc;
    final ethAddress = ref.read(accountProvider.notifier).getPublicAddress(len);
    final solAddress =
        await ref.read(accountProvider.notifier).getSolPublicAddress(len);
    acc = Account()
      ..id = (id ?? len)
      ..ethAddress = ethAddress
      ..solanaAddress = solAddress
      ..bitcoinAddress = null;

    id = await isar.writeTxn<int>(() => isar.accounts.put(acc));
    // fetchAllAccount();
    return id;
  }

  Future<int> putAccount(Account account) async {
    final id = await isar.writeTxn<int>(() => isar.accounts.put(account));
    // fetchAllAccount();
    return id;
  }

  Future<bool> deleteAccount() async {
    bool status = false;
    final len = state.length;
    if (len == 1) return false;
    await isar.writeTxn(() async {
      status = await isar.accounts.delete(state.last.id);
    });
    // fetchAllAccount();
    return status;
  }

  Future<int?> changeAccountName(int id, String newName) async {
    final len = state.length;
    if (len > len) return null;
    Account account = state.elementAt(id)..name = newName.trim();
    id = await isar.writeTxn<int>(() => isar.accounts.put(account));
    // fetchAllAccount();
    return id;
  }
}
