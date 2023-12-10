// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:eddsa_hmac/services/evm/erc721.service.dart';
import 'package:eddsa_hmac/services/evm/token.service.dart' as token;
import 'package:eddsa_hmac/swap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/enums/enums.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';

Future<BigInt?> getGas({
  required WidgetRef ref,
  required String to,
  required String nftContractAddress,
  required int transactionSpeed,
  required int chainId,
  required int tokenId,
}) async {
  try {
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    final toAddress = EthereumAddress.fromHex(to);
    var network = Network.ethereumMainnet;

    for (var i in Network.values) {
      if (i.chainId == chainId) {
        network = i;
        break;
      }
    }
    final tokenIdBigInt = BigInt.from(tokenId);
    final client = await getSafeConnection(network);
    logger.t({
      'address': credentials.address,
      'toAddress': toAddress,
      'network': network,
      'tokenId': tokenIdBigInt.toString(),
    });
    var rawTransaction = await transactionObjectForNftTransfer(
      credentials.address,
      nftContractAddress,
      credentials.address,
      toAddress,
      tokenIdBigInt,
    );

    BigInt? maxFeePerGas;
    BigInt? maxPriorityFeePerGas;
    EtherAmount? gasPrice;

    // Start
    if (network.isEip1559) {
      var gasFee = await getGasFee(client);
      maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
      maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
    } else {
      gasPrice = await getGasPrice(client);
    }
    logger.t({
      "v": 1,
      "maxFeePerGas": maxFeePerGas,
      "maxPriorityFeePerGas": maxPriorityFeePerGas,
      "gasPrice": gasPrice
    });

    // * Update Transaction Parameters
    rawTransaction = updateGasOptions(rawTransaction, null, gasPrice?.getInWei,
        maxFeePerGas, maxPriorityFeePerGas, null);
    logger.t({
      "v": 2,
      "maxFeePerGas": maxFeePerGas,
      "maxPriorityFeePerGas": maxPriorityFeePerGas,
      "gasPrice": gasPrice
    });

    // * Estimate Gas

    BigInt estimatedGas = await estimateGas(client, rawTransaction);
    //print("estimatedGas: $estimatedGas");
    BigInt totalGasFee = BigInt.from(0);
    logger.t({
      "v": 3,
      "maxFeePerGas": maxFeePerGas,
      "maxPriorityFeePerGas": maxPriorityFeePerGas,
      "gasPrice": gasPrice,
      "estimate": estimatedGas,
      "totalGasFree": totalGasFee,
    });

    // * Total Gas Fee
    if (network.isEip1559) {
      totalGasFee = estimatedGas * maxFeePerGas!;
      //print("totalGasFee: $totalGasFee"); // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    } else {
      totalGasFee = estimatedGas * gasPrice!.getInWei;
      //print("totalGasFee: $totalGasFee"); // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    }
    return totalGasFee;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
  }
  return null;
}

Future<TransactionState> transferNFT({
  BuildContext? context,
  required WidgetRef ref,
  required String to,
  required String nftContractAddress,
  required int transactionSpeed,
  required int chainId,
  required int tokenId,
}) async {
  TransactionState state = TransactionState.waiting;
  try {
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    final toAddress = EthereumAddress.fromHex(to);
    var network = Network.ethereumMainnet;

    for (var i in Network.values) {
      if (i.chainId == chainId) {
        network = i;
        break;
      }
    }
    final tokenIdBigInt = BigInt.from(tokenId);
    final client = await getSafeConnection(network);
    var balance = await token.getBalance(client, credentials.address);

    var rawTransaction = await transactionObjectForNftTransfer(
      credentials.address,
      nftContractAddress,
      credentials.address,
      toAddress,
      tokenIdBigInt,
    );

    BigInt? maxFeePerGas;
    BigInt? maxPriorityFeePerGas;
    EtherAmount? gasPrice;

    // Start
    if (network.isEip1559) {
      var gasFee = await getGasFee(client);
      maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
      maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
    } else {
      gasPrice = await getGasPrice(client);
    }

    // * Update Transaction Parameters
    rawTransaction = updateGasOptions(rawTransaction, null, gasPrice?.getInWei,
        maxFeePerGas, maxPriorityFeePerGas, null);

    // * Estimate Gas

    BigInt estimatedGas = await estimateGas(client, rawTransaction);
    //print("estimatedGas: $estimatedGas");
    BigInt totalGasFee = BigInt.from(0);

    // * Total Gas Fee
    if (network.isEip1559) {
      totalGasFee = estimatedGas * maxFeePerGas!;
      //print("totalGasFee: $totalGasFee"); // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    } else {
      totalGasFee = estimatedGas * gasPrice!.getInWei;
      //print("totalGasFee: $totalGasFee"); // * Compare totalGasFee with User Input Value for native token transaction + totalGasFee
    }

    final totalNativeTokenBeingDeducted = totalGasFee +
        (rawTransaction.value == null
            ? BigInt.from(0)
            : rawTransaction.value!.getInWei);
    //print("totalOutValue: $totalNativeTokenBeingDeducted");
    if (balance.getInWei < totalNativeTokenBeingDeducted) {
      throw Exception(
          "Insufficient Balance, Need Additional: ${totalNativeTokenBeingDeducted - balance.getInWei}");
    } else {
      //print("Sufficient Balance");
    }

    // * Get Nonce
    var nonce = await getNonce(client, credentials.address);
    //print("nonce: $nonce");

    // * Update Transaction Parameters
    rawTransaction = updateGasOptions(
        rawTransaction, estimatedGas.toInt(), null, null, null, nonce);
    // ! REFRESH BLOCK::END

    // ! Send Transaction
    var nativeTokenTransaction =
        await sendTransaction(client, network, credentials, rawTransaction);
    //print("transaction: $nativeTokenTransaction");
    state = TransactionState.cacncelled;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
    showSnackBar(context, e.toString());
    state = TransactionState.error;
  }
  return state;
}
