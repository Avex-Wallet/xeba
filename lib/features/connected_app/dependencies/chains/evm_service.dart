// ignore_for_file: depend_on_referenced_packages, library_prefixes, unused_import, unused_field, prefer_final_fields, deprecated_member_use

import 'dart:convert';
import 'package:avex_mobile/core/utils/utils.dart';
import 'package:eddsa_hmac/constants/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:avex_mobile/features/connected_app/dependencies/chains/i_chain.dart';
import 'package:avex_mobile/features/connected_app/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/i_web3wallet_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/key_service/chain_key.dart';
import 'package:avex_mobile/features/connected_app/dependencies/key_service/i_key_service.dart';
import 'package:avex_mobile/features/connected_app/models/eth/ethereum_transaction.dart';
import 'package:avex_mobile/features/connected_app/utils/eth_utils.dart';
import 'package:avex_mobile/features/connected_app/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:avex_mobile/features/connected_app/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:avex_mobile/features/connected_app/widgets/wc_request_widget.dart/wc_request_widget.dart';
import 'package:web3dart/web3dart.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:eddsa_hmac/services/wallet/key.service.dart' as key;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:eddsa_hmac/services/evm/core/signature.service.dart'
    as signatureUtil;
import 'package:eddsa_hmac/services/evm/core/main.service.dart' as evm;

enum EVMChainId {
  ethereum,
  polygon,
  goerli,
  mumbai,
}

extension KadenaChainIdX on EVMChainId {
  String chain() {
    String name = '';

    switch (this) {
      case EVMChainId.ethereum:
        name = '1';
        break;
      case EVMChainId.polygon:
        name = '137';
        break;
      case EVMChainId.goerli:
        name = '5';
        break;
      case EVMChainId.mumbai:
        name = '80001';
        break;
    }

    return '${EVMService.namespace}:$name';
  }
}

class EVMService extends IChain {
  String _mnemonics = 'not set';
  static const namespace = 'eip155';
  static const pSign = 'personal_sign';
  static const eSign = 'eth_sign';
  static const eSignTransaction = 'eth_signTransaction';
  static const eSignTypedData = 'eth_signTypedData';
  static const eSendTransaction = 'eth_sendTransaction';

  final IBottomSheetService _bottomSheetService =
      GetIt.I<IBottomSheetService>();
  final IWeb3WalletService _web3WalletService = GetIt.I<IWeb3WalletService>();

  final EVMChainId reference;

  final Web3Client ethClient;

  WidgetRef? ref;

  EVMService({
    required this.reference,
    Web3Client? ethClient,
  }) : ethClient = ethClient ??
            Web3Client(
                'https://mainnet.infura.io/v3/51716d2096df4e73bec298680a51f0c5',
                http.Client()) {
    final Web3Wallet wallet = _web3WalletService.getWeb3Wallet();
    for (final String event in getEvents()) {
      wallet.registerEventEmitter(chainId: getChainId(), event: event);
    }
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: pSign,
      handler: personalSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSign,
      handler: ethSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTransaction,
      handler: ethSignTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSendTransaction,
      handler: ethSignTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTypedData,
      handler: ethSignTypedData,
    );
  }

  @override
  setRef(WidgetRef widgetRef) {
    ref = widgetRef;
  }

  @override
  String getNamespace() {
    return namespace;
  }

  @override
  String getChainId() {
    return reference.chain();
  }

  @override
  List<String> getEvents() {
    return ['chainChanged', 'accountsChanged'];
  }

  Future<String?> requestAuthorization(String text) async {
    final bool? approved = await _bottomSheetService.queueBottomSheet(
      widget: WCRequestWidget(
        child: WCConnectionWidget(
          title: 'Sign Transaction',
          info: [
            WCConnectionModel(
              text: text,
            ),
          ],
        ),
      ),
    );

    if (approved != null && approved == false) {
      return 'User rejected signature';
    }

    return null;
  }

  ExtendedKey? getEcKey() {
    if (ref == null) {
      return null;
    }
    final seed = ref!.read(accountProvider.notifier).getSeed();
    if (seed == null) {
      return null;
    }
    final index = ref!.read(accountProvider).current;
    var ecKey = key.createEcdsaKey(seed, index);
    return ecKey;
  }

  Future personalSign(String topic, dynamic parameters) async {
    var ecKey = getEcKey();
    if (ecKey == null) return 'Failed';
    //print('received personal sign request: $parameters');

    final String message = EthUtils.getUtf8Message(parameters[0]);

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      //! Old
      // Load the private key
      // final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      //   getChainId(),
      // );
      // final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);

      // final String signature = hex.encode(
      //   credentials.signPersonalMessageToUint8List(
      //     Uint8List.fromList(
      //       utf8.encode(message),
      //     ),
      //   ),
      // );
      //! Old end

      //! NEW
      final String signature =
          signatureUtil.signPersonalMessage(message, ecKey);
      //! NEW END

      return '0x$signature';
    } catch (e) {
      //print(e);
      return 'Failed';
    }
  }

  Future ethSign(String topic, dynamic parameters) async {
    var ecKey = getEcKey();
    if (ecKey == null) return 'Failed';
    //print('received eth sign request: $parameters');

    final String message = EthUtils.getUtf8Message(parameters[1]);

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      //!old
      // Load the private key
      // final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      //   getChainId(),
      // );
      // //print('private key');
      // //print(keys[0].privateKey);

      // final String signature = EthSigUtil.signMessage(
      //   message: Uint8List.fromList(
      //     utf8.encode(message),
      //   ),
      //   privateKey: keys[0].privateKey,
      // );
      // final EthPrivateKey credentials = EthPrivateKey.fromHex(
      //   keys[0].privateKey,
      // );
      // final String signature = hex.encode(
      //   credentials.signPersonalMessageToUint8List(
      //     Uint8List.fromList(
      //       utf8.encode(message),
      //     ),
      //   ),
      // );
      //end
      //! New
      final String signature =
          signatureUtil.signPersonalMessage(message, ecKey);
      //! NeW end

      //end
      //print(signature);

      return '0x$signature';
    } catch (e) {
      //print('error:');
      //print(e);
      return 'Failed';
    }
  }

  Future ethSignTransaction(String topic, dynamic parameters) async {
    // logger.t(ref.read(accountProvider));
    //print('received eth sign transaction request: $parameters');
    final String? authAcquired = await requestAuthorization(
      jsonEncode(
        parameters[0],
      ),
    );
    if (authAcquired != null) {
      return authAcquired;
    }

    // Load the private key
    //! old
    // final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
    //   getChainId(),
    // );
    // final Credentials credentials = EthPrivateKey.fromHex(
    //   '0x${keys[0].privateKey}',
    // );
    //! old new

    //!new
    final pkey = ref!.read(accountProvider.notifier).getCredential();
    final Credentials credentials = EthPrivateKey.fromHex(pkey);
    //!new end

    EthereumTransaction ethTransaction = EthereumTransaction.fromJson(
      parameters[0],
    );

    // Construct a transaction from the EthereumTransaction object
    final transaction = Transaction(
      from: EthereumAddress.fromHex(ethTransaction.from),
      to: EthereumAddress.fromHex(ethTransaction.to),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.tryParse(ethTransaction.value) ?? BigInt.zero,
      ),
      gasPrice: ethTransaction.gasPrice != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.gasPrice!) ?? BigInt.zero,
            )
          : null,
      maxFeePerGas: ethTransaction.maxFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxFeePerGas!) ?? BigInt.zero,
            )
          : null,
      maxPriorityFeePerGas: ethTransaction.maxPriorityFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxPriorityFeePerGas!) ??
                  BigInt.zero,
            )
          : null,
      maxGas: int.tryParse(ethTransaction.gasLimit ?? ''),
      nonce: int.tryParse(ethTransaction.nonce ?? ''),
      data: (ethTransaction.data != null && ethTransaction.data != '0x')
          ? Uint8List.fromList(hex.decode(ethTransaction.data!))
          : null,
    );

    try {
      //! old
      // final Uint8List sig = await ethClient.signTransaction(
      //   credentials,
      //   transaction,
      // );
      //! old end

      //! new
      var client = await evm.getSafeConnection(Network.polygonMainnet);
      final Uint8List sig = await signatureUtil.signTransaction(
        client,
        credentials,
        transaction,
      );
      //! new end

      // Sign the transaction
      final String signedTx = hex.encode(sig);

      // Return the signed transaction as a hexadecimal string
      return '0x$signedTx';
    } catch (e) {
      //print(e);
      return 'Failed';
    }
  }

  Future ethSignTypedData(String topic, dynamic parameters) async {
    //print('received eth sign typed data request: $parameters');
    final String data = parameters[1];
    final String? authAcquired = await requestAuthorization(data);
    if (authAcquired != null) {
      return authAcquired;
    }

    // ! old
    // final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
    //   getChainId(),
    // );

    // EthPrivateKey credentials = EthPrivateKey.fromHex(keys[0].privateKey);
    // credentials.

    // return EthSigUtil.signTypedData(
    //   privateKey: keys[0].privateKey,
    //   jsonData: data,
    //   version: TypedDataVersion.V4,
    // );

    //! old end
    final String message = EthUtils.getUtf8Message(parameters[1]);
    final ecKey = getEcKey();
    if (ecKey == null) return 'Failed';
    return signatureUtil.signTypedData(message, ecKey);
    //! new end
  }
}
