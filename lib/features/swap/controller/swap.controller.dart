// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, unused_local_variable, duplicate_ignore

import 'dart:math';

import 'package:eddsa_hmac/constants/network.dart' as ee;
import 'package:eddsa_hmac/constants/network.dart';
import 'package:eddsa_hmac/services/evm/core/main.service.dart' as evm;
import 'package:eddsa_hmac/services/evm/erc20.service.dart' as erc20;
import 'package:eddsa_hmac/services/swap.service.dart' as swap;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/enums/enums.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';

Future<TransactionState> initiateTransactionRouter(
    {bool send = false, required WidgetRef ref, BuildContext? context}) async {
  TransactionState transactionState = TransactionState.waiting;
  try {
    const apiUrl = "api.pathfinder.routerprotocol.com";
    final String fromChain = ref.read(token1Provider)!.$2.chainId.toString();
    final String toChain = ref.read(token2Provider)!.$2.chainId.toString();
    final String fromToken = ref.read(token1Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token1Provider)!.$1.contract_address; //Matic
    final String toToken = ref.read(token2Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token2Provider)!.$1.contract_address;
    final String fromAmount = BigInt.from(
      (ref.read(valueToSwapProvider) *
          pow(10, ref.read(token1Provider)!.$1.contract_decimals)),
    ).toString();
    logger.t({
      'fromChain': fromChain,
      'toChain': toChain,
      'fromToken': fromToken,
      'toToken': toToken,
      'fromAmount': fromAmount,
    });

    //!-------START------------//
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    var quote = await swap.getQuote(apiUrl, fromChain, fromToken, toChain,
        toToken, fromAmount, credentials.address.toString());
    var network = Network.polygonMainnet;
    for (var i in Network.values) {
      if (i.chainId.toString() == fromChain) {
        network = i;
        break;
      }
    }
    var client = await evm.getSafeConnection(network);
    final transactionSpeed = ee.GasOption.standard.multiplier;

    // Check and set Allowance
    var hasAllowance = await erc20.checkAllowance(
      client,
      credentials,
      fromToken,
      EthereumAddress.fromHex(credentials.address.toString()),
      BigInt.parse(fromAmount),
    );
    if (!hasAllowance) {
      var rawTransaction = await erc20.transactionObjectForSetAllowance(
        credentials.address,
        fromToken,
        EthereumAddress.fromHex(credentials.address.toString()),
        BigInt.parse(fromAmount),
      );
      BigInt? maxFeePerGas;
      BigInt? maxPriorityFeePerGas;
      EtherAmount? gasPrice;
      if (network.isEip1559) {
        var gasFee = await evm.getGasFee(client);
        maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
        maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
      } else {
        gasPrice = await evm.getGasPrice(client);
      }
      rawTransaction = evm.updateGasOptions(rawTransaction, null,
          gasPrice?.getInWei, maxFeePerGas, maxPriorityFeePerGas, null);
      var estimatedGas = await evm.estimateGas(client, rawTransaction);
      rawTransaction = evm.updateGasOptions(
          rawTransaction, estimatedGas.toInt(), null, null, null, null);
      var approvalTransaction = await evm.sendTransaction(
          client, network, credentials, rawTransaction);
      //print("transaction: $approvalTransaction");
    }
    var rawTx = evm.createTransaction(
        quote.transactionRequest!.from!,
        quote.transactionRequest!.to!,
        quote.transactionRequest!.value,
        quote.transactionRequest!.data,
        quote.transactionRequest!.gasLimit,
        quote.transactionRequest!.gasPrice,
        quote.transactionRequest!.maxFeePerGas,
        quote.transactionRequest!.maxPriorityFeePerGas);
    var estimatedGas = await evm.estimateGas(client, rawTx);
    rawTx = evm.updateGasOptions(
        rawTx, estimatedGas.toInt(), null, null, null, null);

    if (!send) {
      if (context != null) showSnackBar(context, 'Transaction cancelled');
      return TransactionState.error;
    }
    // ignore: unused_local_variable
    var swapTransaction =
        await evm.sendTransaction(client, network, credentials, rawTx);

    transactionState = TransactionState.completed;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
    transactionState = TransactionState.error;
    if (context != null) showSnackBar(context, e.toString());
    return TransactionState.error;
  }
  logger.d('Transaction status => ${transactionState.name}');
  return transactionState;
}

Future<bool> verifyRouter(
    {required WidgetRef ref, BuildContext? context}) async {
  try {
    const apiUrl = "api.pathfinder.routerprotocol.com";
    final String fromChain = ref.read(token1Provider)!.$2.chainId.toString();
    final String toChain = ref.read(token2Provider)!.$2.chainId.toString();
    final String fromToken = ref.read(token1Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token1Provider)!.$1.contract_address; //Matic
    final String toToken = ref.read(token2Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token2Provider)!.$1.contract_address;
    final String fromAmount = BigInt.from(
      (ref.read(valueToSwapProvider) *
          pow(10, ref.read(token1Provider)!.$1.contract_decimals)),
    ).toString();
    logger.t({
      'fromChain': fromChain,
      'toChain': toChain,
      'fromToken': fromToken,
      'toToken': toToken,
      'fromAmount': fromAmount,
    });

    //!-------START------------//
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    var quote = await swap.getQuote(apiUrl, fromChain, fromToken, toChain,
        toToken, fromAmount, credentials.address.toString());
    var network = Network.polygonMainnet;
    for (var i in Network.values) {
      if (i.chainId.toString() == fromChain) {
        network = i;
        break;
      }
    }
    var client = await evm.getSafeConnection(network);
    final transactionSpeed = ee.GasOption.standard.multiplier;

    // Check and set Allowance
    var hasAllowance = await erc20.checkAllowance(
      client,
      credentials,
      fromToken,
      EthereumAddress.fromHex(credentials.address.toString()),
      BigInt.parse(fromAmount),
    );
    if (!hasAllowance) {
      var rawTransaction = await erc20.transactionObjectForSetAllowance(
        credentials.address,
        fromToken,
        EthereumAddress.fromHex(credentials.address.toString()),
        BigInt.parse(fromAmount),
      );
      BigInt? maxFeePerGas;
      BigInt? maxPriorityFeePerGas;
      EtherAmount? gasPrice;
      if (network.isEip1559) {
        var gasFee = await evm.getGasFee(client);
        maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
        maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
      } else {
        gasPrice = await evm.getGasPrice(client);
      }
      rawTransaction = evm.updateGasOptions(rawTransaction, null,
          gasPrice?.getInWei, maxFeePerGas, maxPriorityFeePerGas, null);
      var estimatedGas = await evm.estimateGas(client, rawTransaction);
      rawTransaction = evm.updateGasOptions(
          rawTransaction, estimatedGas.toInt(), null, null, null, null);
      var approvalTransaction = await evm.sendTransaction(
          client, network, credentials, rawTransaction);
      //print("transaction: $approvalTransaction");
    }
    var rawTx = evm.createTransaction(
        quote.transactionRequest!.from!,
        quote.transactionRequest!.to!,
        quote.transactionRequest!.value,
        quote.transactionRequest!.data,
        quote.transactionRequest!.gasLimit,
        quote.transactionRequest!.gasPrice,
        quote.transactionRequest!.maxFeePerGas,
        quote.transactionRequest!.maxPriorityFeePerGas);
    var estimatedGas = await evm.estimateGas(client, rawTx);
    rawTx = evm.updateGasOptions(
        rawTx, estimatedGas.toInt(), null, null, null, null);
    return true;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
    if (context != null) showSnackBar(context, e.toString());
    return false;
  }
}

Future<TransactionState> initiateTransaction(
    {bool send = false, required WidgetRef ref, BuildContext? context}) async {
  TransactionState transactionState = TransactionState.waiting;
  try {
    const apiUrl = "li.quest";
    final String fromChain = ref.read(token1Provider)!.$2.chainId.toString();
    final String toChain = ref.read(token2Provider)!.$2.chainId.toString();
    final String fromToken = ref.read(token1Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token1Provider)!.$1.contract_address; //Matic
    final String toToken = ref.read(token2Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token2Provider)!.$1.contract_address;
    final String fromAmount = BigInt.from(
      (ref.read(valueToSwapProvider) *
          pow(10, ref.read(token1Provider)!.$1.contract_decimals)),
    ).toString();
    logger.t({
      'fromChain': fromChain,
      'toChain': toChain,
      'fromToken': fromToken,
      'toToken': toToken,
      'fromAmount': fromAmount,
    });

    //!-------START------------//
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    var quote = await swap.getQuote(
      apiUrl,
      fromChain.toString(),
      fromToken,
      toChain.toString(),
      toToken,
      fromAmount,
      credentials.address.toString(),
    );
    var network = Network.polygonMainnet;
    for (var i in Network.values) {
      if (i.chainId.toString() == fromChain) {
        network = i;
        break;
      }
    }
    logger.d('Network => $network');
    var client = await evm.getSafeConnection(network);
    final transactionSpeed = ee.GasOption.standard.multiplier;

    // Check and set Allowance
    var hasAllowance = await erc20.checkAllowance(
        client,
        credentials,
        quote.action.fromToken.address,
        EthereumAddress.fromHex(quote.estimate!.approvalAddress),
        BigInt.parse(fromAmount));
    logger.d('Has Allowance => $hasAllowance');
    if (!hasAllowance) {
      var rawTransaction = await erc20.transactionObjectForSetAllowance(
          credentials.address,
          quote.action.fromToken.address,
          EthereumAddress.fromHex(quote.estimate!.approvalAddress),
          BigInt.parse(fromAmount));
      BigInt? maxFeePerGas;
      BigInt? maxPriorityFeePerGas;
      EtherAmount? gasPrice;
      if (network.isEip1559) {
        var gasFee = await evm.getGasFee(client);
        maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
        maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
      } else {
        gasPrice = await evm.getGasPrice(client);
      }
      rawTransaction = evm.updateGasOptions(rawTransaction, null,
          gasPrice?.getInWei, maxFeePerGas, maxPriorityFeePerGas, null);
      var estimatedGas = await evm.estimateGas(client, rawTransaction);
      rawTransaction = evm.updateGasOptions(
          rawTransaction, estimatedGas.toInt(), null, null, null, null);
      var approvalTransaction = await evm.sendTransaction(
          client, network, credentials, rawTransaction);
      logger.d("transaction: $approvalTransaction");
    }
    var rawTx = evm.createTransaction(
        quote.transactionRequest!.from!,
        quote.transactionRequest!.to!,
        quote.transactionRequest!.value!,
        quote.transactionRequest!.data!,
        quote.transactionRequest!.gasLimit!,
        quote.transactionRequest!.gasPrice!,
        quote.transactionRequest!.maxFeePerGas,
        quote.transactionRequest!.maxPriorityFeePerGas);
    logger.d('txn created');
    var estimatedGas = await evm.estimateGas(client, rawTx);
    // state = state.copyWith(estimatedGas: estimatedGas);
    rawTx = evm.updateGasOptions(
        rawTx, estimatedGas.toInt(), null, null, null, null);
    if (!send) {
      if (context != null) showSnackBar(context, 'Transaction cancelled');
      return TransactionState.error;
    }
    // ignore: unused_local_variable
    var swapTransaction =
        await evm.sendTransaction(client, network, credentials, rawTx);

    transactionState = TransactionState.completed;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
    transactionState = TransactionState.error;
    if (context != null) showSnackBar(context, e.toString());
    return TransactionState.error;
  }
  return transactionState;
}

Future<bool> verify({required WidgetRef ref, BuildContext? context}) async {
  try {
    const apiUrl = "li.quest";
    final String fromChain = ref.read(token1Provider)!.$2.chainId.toString();
    final String toChain = ref.read(token2Provider)!.$2.chainId.toString();
    final String fromToken = ref.read(token1Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token1Provider)!.$1.contract_address; //Matic
    final String toToken = ref.read(token2Provider)!.$1.native_token
        ? '0x0000000000000000000000000000000000000000'
        : ref.read(token2Provider)!.$1.contract_address;
    final String fromAmount = BigInt.from(
      (ref.read(valueToSwapProvider) *
          pow(10, ref.read(token1Provider)!.$1.contract_decimals)),
    ).toString();
    logger.t({
      'fromChain': fromChain,
      'toChain': toChain,
      'fromToken': fromToken,
      'toToken': toToken,
      'fromAmount': fromAmount,
    });

    //!-------START------------//
    final cred = ref.read(accountProvider.notifier).getCredential();
    // credentials = key.createEthereumAccountFromHex(cred);
    var credentials = EthPrivateKey.fromHex(cred);
    var quote = await swap.getQuote(
      apiUrl,
      fromChain.toString(),
      fromToken,
      toChain.toString(),
      toToken,
      fromAmount,
      credentials.address.toString(),
    );
    var network = Network.polygonMainnet;
    for (var i in Network.values) {
      if (i.chainId.toString() == fromChain) {
        network = i;
        break;
      }
    }
    logger.d('Network => $network');
    var client = await evm.getSafeConnection(network);
    final transactionSpeed = ee.GasOption.standard.multiplier;

    // Check and set Allowance
    var hasAllowance = await erc20.checkAllowance(
        client,
        credentials,
        quote.action.fromToken.address,
        EthereumAddress.fromHex(quote.estimate!.approvalAddress),
        BigInt.parse(fromAmount));
    logger.d('Has Allowance => $hasAllowance');
    if (!hasAllowance) {
      var rawTransaction = await erc20.transactionObjectForSetAllowance(
          credentials.address,
          quote.action.fromToken.address,
          EthereumAddress.fromHex(quote.estimate!.approvalAddress),
          BigInt.parse(fromAmount));
      BigInt? maxFeePerGas;
      BigInt? maxPriorityFeePerGas;
      EtherAmount? gasPrice;
      if (network.isEip1559) {
        var gasFee = await evm.getGasFee(client);
        maxFeePerGas = gasFee[transactionSpeed].maxFeePerGas;
        maxPriorityFeePerGas = gasFee[transactionSpeed].maxPriorityFeePerGas;
      } else {
        gasPrice = await evm.getGasPrice(client);
      }
      rawTransaction = evm.updateGasOptions(rawTransaction, null,
          gasPrice?.getInWei, maxFeePerGas, maxPriorityFeePerGas, null);
      var estimatedGas = await evm.estimateGas(client, rawTransaction);
      rawTransaction = evm.updateGasOptions(
          rawTransaction, estimatedGas.toInt(), null, null, null, null);
      var approvalTransaction = await evm.sendTransaction(
          client, network, credentials, rawTransaction);
      logger.d("transaction: $approvalTransaction");
    }
    var rawTx = evm.createTransaction(
        quote.transactionRequest!.from!,
        quote.transactionRequest!.to!,
        quote.transactionRequest!.value!,
        quote.transactionRequest!.data!,
        quote.transactionRequest!.gasLimit!,
        quote.transactionRequest!.gasPrice!,
        quote.transactionRequest!.maxFeePerGas,
        quote.transactionRequest!.maxPriorityFeePerGas);
    logger.d('txn created');
    var estimatedGas = await evm.estimateGas(client, rawTx);
    // state = state.copyWith(estimatedGas: estimatedGas);
    rawTx = evm.updateGasOptions(
        rawTx, estimatedGas.toInt(), null, null, null, null);
    return true;
  } catch (e, s) {
    logger.e(e);
    logger.f(s);
    if (context != null) showSnackBar(context, e.toString());
    return false;
  }
}
