// ignore_for_file: depend_on_referenced_packages

import 'package:avex_mobile/features/send_transaction/views/components/select_asset_bottomsheet.dart';
import 'package:eddsa_hmac/constants/network.dart';
import 'package:eddsa_hmac/services/evm/core/main.service.dart' as evm;
import 'package:eddsa_hmac/services/evm/erc20.service.dart' as erc20;
import 'package:eddsa_hmac/services/evm/token.service.dart' as token;
import 'package:eddsa_hmac/services/wallet/key.service.dart' as key;
import 'package:eip1559/eip1559.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart'
    show Credentials, EtherAmount, EthereumAddress, Transaction, Web3Client;

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/send_transaction/models/txn.model.dart';

final txnProvider = StateNotifierProvider<TxnNotifier, Txn>((ref) {
  final address = ref.watch(accountProvider).address;
  ref.watch(sendNetworkProvider);
  return TxnNotifier(
    Txn(address: address, value: '0', toAddress: address, speed: Speed.Average),
    ref: ref,
  );
});

class TxnNotifier extends StateNotifier<Txn> {
  Ref ref;
  late Credentials credentials;
  Transaction? rawTransaction;
  late Web3Client? web3client;
  late Network network;
  TxnNotifier(super._state, {required this.ref}) {
    final cred = ref.read(accountProvider.notifier).getCredential();
    credentials = key.createEthereumAccountFromHex(cred);
    final chain = ref.read(sendNetworkProvider);
    network = Network.values[chain.index];
    _initClient();
  }

  Future _initClient() async {
    web3client = await evm.getSafeConnection(network);
  }

  void setState(Txn txn) {
    state = txn;
  }

  void setSpeed(Speed newSpeed) {
    state.copyWith(speed: newSpeed);
  }

  void changeSpeed() {
    switch (state.speed) {
      case Speed.Slow:
        state = state.copyWith(speed: Speed.Average);
        break;
      case Speed.Average:
        state = state.copyWith(speed: Speed.Fast);
        break;
      case Speed.Fast:
        state = state.copyWith(speed: Speed.Slow);
        break;
      default:
        state = state.copyWith(speed: Speed.Average);
    }
    initiateTransaction();
  }

  Future<String?> initiateTransaction({bool send = false}) async {
    Transaction rawTransaction;
    final to = EthereumAddress.fromHex(state.toAddress);
    final transactionSpeed = state.speed.index;
    final value = BigInt.parse(state.value);

    log(state.token?.contract_address.toString());
    final client = web3client ?? await evm.getSafeConnection(network);

    var balance = await token.getBalance(client, credentials.address);
    log("balance: $balance"); // * Compare balance.inWei() with User Input Value for native token transaction + gas fee

    // * Native Token Transfer Object
    if (state.token == null || (state.token?.native_token ?? false)) {
      rawTransaction = token.transactionObjectForNativeTokenTransfer(
          credentials.address, to, value);
    } else {
      rawTransaction = await erc20.transactionObjectForTokenTransfer(
          credentials.address, state.token!.contract_address, to, value);
    }

    BigInt? maxFeePerGas;
    BigInt? maxPriorityFeePerGas;
    EtherAmount? gasPrice;

    // ! REFRESH BLOCK::START (Update every 5 Seconds, until the transaction is sent)
    // * Get Gas Fee
    if (network.isEip1559) {
      List<Fee> gasFee = await evm.getGasFee(client);
      maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
      maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
    } else {
      gasPrice = await evm.getGasPrice(client);
    }

    // * Update Transaction Parameters
    rawTransaction = evm.updateGasOptions(rawTransaction, null,
        gasPrice?.getInWei, maxFeePerGas, maxPriorityFeePerGas, null);

    // * Estimate Gas
    var estimatedGas = await evm.estimateGas(client, rawTransaction);
    log("estimatedGas: $estimatedGas");

    // * Total Gas Fee
    if (network.isEip1559) {
      var totalGasFee = estimatedGas * maxFeePerGas!;
      state = state.copyWith(gas: totalGasFee.toString());
      log("totalGasFee eip1559: $totalGasFee");
      // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    } else {
      var totalGasFee = estimatedGas * gasPrice!.getInWei;
      state = state.copyWith(gas: totalGasFee.toString());
      log("totalGasFee: $totalGasFee");
      // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    }

    // * Get Nonce
    var nonce = await evm.getNonce(client, credentials.address);
    log("nonce: $nonce");

    // * Update Transaction Parameters
    rawTransaction = evm.updateGasOptions(
        rawTransaction, estimatedGas.toInt(), null, null, null, nonce);
    // ! REFRESH BLOCK::END
    if (!send) return null;
    // ! Send Transaction
    var nativeTokenTransaction =
        await evm.sendTransaction(client, network, credentials, rawTransaction);
    log("transaction: $nativeTokenTransaction");
    return nativeTokenTransaction;
  }

  Future getTransactionReciept(String nativeTokenTransaction) async {
    final client = web3client ?? await evm.getSafeConnection(network);
    var recipt =
        await evm.getTransactionReceipt(client, nativeTokenTransaction);
    var status = recipt?.status;
    log("recipt: $status"); // * Can return null ass well
  }
}

void log(String? log) {
  if (log == null) return;
  if (kDebugMode) {
    //print(log);
  }
}
