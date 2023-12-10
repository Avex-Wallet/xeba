// =================================================================
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/connected_app/dependencies/bottom_sheet/bottom_sheet_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/chains/evm_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/chains/i_chain.dart';
import 'package:avex_mobile/features/connected_app/dependencies/chains/kadena_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/i_web3wallet_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/key_service/chain_key.dart';
import 'package:avex_mobile/features/connected_app/dependencies/key_service/i_key_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/key_service/key_service.dart';
import 'package:avex_mobile/features/connected_app/dependencies/web3wallet_service.dart';
import 'package:avex_mobile/features/connected_app/utils/dart_defines.dart';
// =================================================================

Future<void> initWalletConnect(WidgetRef ref) async {
  try {
    GetIt.I.unregister<IBottomSheetService>();
    GetIt.I.unregister<IKeyService>();
    GetIt.I.unregister<IWeb3WalletService>();
    GetIt.I.unregister<IChain>();
    if (!GetIt.I.isRegistered<BottomSheetService>()) {
      await init(ref);
    } else {
      logger.i("Get_It already registered");
      GetIt.I<IChain>().setRef(ref);
    }
    // ignore: empty_catches
  } catch (e) {}
}

Future<void> init(WidgetRef ref) async {
  logger.f("Get Registered");
  GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());
  // ===
  final List<ChainKey> keys = [
    ChainKey(
      chains: [
        'kadena:mainnet01',
        'kadena:testnet04',
        'kadena:development',
      ],
      privateKey: DartDefines.kadenaPrivateKey,
      publicKey: DartDefines.kadenaPublicKey,
    ),
    ChainKey(
      chains: [
        'eip155:1',
        'eip155:5',
        'eip155:137',
        'eip155:80001',
      ],
      privateKey: ref.read(accountProvider.notifier).getCredential(),
      publicKey: ref
          .read(accountProvider)
          .address, // Eth Address, not actual public key
    )
  ];
  // ===
  GetIt.I.registerSingleton<IKeyService>(KeyService(keys));
  final IWeb3WalletService web3WalletService = Web3WalletService();
  web3WalletService.create(ref);
  GetIt.I.registerSingleton<IWeb3WalletService>(web3WalletService);

  for (final cId in KadenaChainId.values) {
    GetIt.I.registerSingleton<IChain>(
      KadenaService(reference: cId)..setRef(ref),
      instanceName: cId.chain,
    );
  }
  for (final cId in EVMChainId.values) {
    GetIt.I.registerSingleton<IChain>(
      EVMService(reference: cId)..setRef(ref),
      instanceName: cId.chain(),
    );
  }

  await web3WalletService.init();
}
