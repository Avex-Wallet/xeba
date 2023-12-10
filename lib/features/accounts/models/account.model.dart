// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:bip32/bip32.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';

// import 'package:eddsa_hmac/services/wallet/key.service.dart' as key;

class Account {
  BIP32? _root;
  Uint8List? _seed;
  final String address;
  final String solAddress;
  final String? bitAddress;
  final int current;

  Account({
    required this.address,
    required this.current,
    required this.solAddress,
    required this.bitAddress,
    String? mnemonic,
  }) {
    if (mnemonic == null) return;
    _seed = bip39.mnemonicToSeed(mnemonic);
    _root = BIP32.fromSeed(_seed!);
  }

  setMnemonic(mnemonic) {}

  @override
  String toString() => 'Account(address: $address, current: $current)';

  String _derivedPath({
    int account = 1,
  }) {
    return "m/44'/60'/0'/0/$account";
  }

  String get getEthPrivateKey {
    final child = _root!.derivePath(_derivedPath(account: current));
    final privateKey = HEX.encode(child.privateKey!);
    return privateKey;
  }

  // Future<Ed25519HDKeyPair> get getSolanaPrivateKey async {
  //   var sourceKeypair = await key.createSolanaKey(_seed!, 0);
  //   Ed25519HDKeyPair source =
  //       await key.createSolanaAccount(sourceKeypair.sublist(32));
  //   return source.publicKey;
  // }

  Account copyWith({
    String? address,
    String? solAddress,
    String? bitAddress,
    int? current,
  }) {
    return Account(
      address: address ?? this.address,
      solAddress: solAddress ?? this.solAddress,
      bitAddress: bitAddress ?? this.bitAddress,
      current: current ?? this.current,
    )..setMnemonic(_root);
  }
}
