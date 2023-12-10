// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/nft/controllers/all_chain_nft.controller.dart';
import 'package:avex_mobile/features/nft/controllers/current_chain_nft.controller.dart';
import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart'
    // ignore: library_prefixes
    as AccountDB;
import 'package:solana/solana.dart';
import 'package:bip32/bip32.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:eddsa_hmac/eddsa_hmac.dart';
import 'package:eddsa_hmac/services/wallet/key.service.dart' as key;
import 'package:eddsa_hmac/swap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart' show EthPrivateKey;
import 'package:avex_mobile/features/accounts/models/account.model.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:avex_mobile/services/local_services/shared_pref/shared_pref.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, Account>((ref) {
  // ref.watch(currentNetworkChainProvider);
  return AccountNotifier(ref);
});

class AccountNotifier extends StateNotifier<Account> {
  Ref ref;
  IPref get pref => ref.read(sharedPref);
  Uint8List? _seed;

  bool isInitialized = false;

  AccountNotifier(this.ref)
      : super(Account(
          address: '0x0000000000000000000000000000000000000000',
          solAddress: '00000000000000000000000000000000',
          bitAddress: '00000000000000000000000000000000',
          current: 0,
        )) {
    init();
  }

  Future<void> init() async {
    try {
      final authCheck = await SecureStorage.seedPhase.value;
      if (bip39.validateMnemonic(authCheck)) {
        final seed = bip39.mnemonicToSeed(authCheck);
        _seed = seed;
        await ref.read(AccountDB.accountListProvider.notifier).init();
        int current = pref.currentAccountCount;
        state = state.copyWith(
          address:
              (ref.read(AccountDB.accountListProvider))[current].ethAddress,
          solAddress:
              (ref.read(AccountDB.accountListProvider))[current].ethAddress,
          bitAddress:
              (ref.read(AccountDB.accountListProvider))[current].bitcoinAddress,
          current: current,
        );
        Future.wait([
          for (NetworkChain chain in NetworkChain.values)
            ref.read(allTokenListFutureProvider(chain).future)
        ]);
        ref.read(allChainNftProvider);
        ref.watch(nftProvider)[ref.read(currentNetworkChainProvider)];
      }
      isInitialized = true;
    } catch (e) {
      // ignore
    }
  }

  Uint8List? getSeed() => _seed;

  Future<bool> changeAddress(int account, {BuildContext? ctx}) async {
    final accountList = ref.read(AccountDB.accountListProvider)[account];
    state = state.copyWith(
      current: account,
      address: accountList.ethAddress,
      bitAddress: accountList.bitcoinAddress,
      solAddress: accountList.solanaAddress,
    );
    final status = await pref.setCurrentAccountCount(account);
    HapticFeedback.mediumImpact();
    if (status) {
      showSnackBar(ctx, 'Active account set to ${account + 1}');
    }
    return status;
  }

  String _getEthPrivateKey(int account) {
    final child = BIP32.fromSeed(_seed!).derivePath("m/44'/60'/0'/0/$account");
    final privateKey = HEX.encode(child.privateKey!);
    return privateKey;
  }

  Future<Ed25519HDKeyPair> _getSolPrivateKey(int account) async {
    var sourceKeypair = await key.createSolanaKey(_seed!, account);
    final v = sourceKeypair.sublist(0, 32);
    Ed25519HDKeyPair source = await key.createSolanaAccount(v);
    return source;
  }

  String getPublicAddress(int account) {
    if (account >= 20) return '';
    final address =
        EthPrivateKey.fromHex(_getEthPrivateKey(account)).address.hex;
    return address;
  }

  Future<String> getSolPublicAddress(int account) async {
    final source = await _getSolPrivateKey(account);
    return source.publicKey.toBase58();
  }

  String getCredential({int? account}) =>
      _getEthPrivateKey(account ?? state.current);

  Future<void> deleteAccount({BuildContext? context}) async {
    if (numberOfAccount == 1) return;
    if (currentAccount == numberOfAccount - 1) {
      showSnackBar(context, 'Change your active account first');
      return;
    }
    final status =
        await ref.read(AccountDB.accountListProvider.notifier).deleteAccount();
    if (status) {
      showSnackBar(context, 'Account $numberOfAccount removed');
    }
  }

  int get numberOfAccount => ref.read(AccountDB.accountListProvider).length;
  int get currentAccount => pref.currentAccountCount;
}
