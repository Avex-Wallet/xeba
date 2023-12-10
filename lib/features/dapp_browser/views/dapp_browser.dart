// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/home/bottom_navbar/home.dart';
import 'package:avex_mobile/main.dart';

class DappBrowser extends ConsumerStatefulWidget {
  const DappBrowser({Key? key}) : super(key: key);

  @override
  ConsumerState<DappBrowser> createState() => _BrowserState();
}

class _BrowserState extends ConsumerState<DappBrowser> {
  InAppWebViewController? _webViewController;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      2.seconds,
      () => showSnackBar(
        context,
        'Under Construction!!!',
      ),
    );
  }

  String rpc = "https://rpc.ankr.com/polygon";

  @override
  Widget build(BuildContext context) {
    final chainId =
        ref.watch(currentNetworkChainProvider.select((value) => value.chainId));

    return Scaffold(
      bottomNavigationBar: const HomeBottomNavBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          leading: const Icon(Icons.home_sharp),
          title: Text('Browser', style: inter.copyWith()),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.grid_view_sharp),
            )
          ],
        ),
      ),
      body: InjectedWebview(
        addEthereumChain: changeNetwork,
        requestAccounts: getAccount,
        signTransaction: signTransaction,
        signPersonalMessage: signPersonelMessage,
        isDebug: true,
        initialUrlRequest: URLRequest(url: Uri.parse('https://opensea.io/')),
        chainId: chainId,
        rpc: rpc,
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
      ),
    );
  }

  Future<String> changeNetwork(InAppWebViewController controller,
      JsAddEthereumChain data, int chainId) async {
    try {
      rpc = "https://rpc.ankr.com/eth";
      chainId = int.parse(data.chainId!);
    } catch (e) {
      debugPrint("$e");
    }
    return rpc;
  }

  Future<IncomingAccountsModel> getAccount(
      InAppWebViewController _, String ___, int __) async {
    Credentials fromHex = EthPrivateKey.fromHex("Private key here");
    final address = await fromHex.extractAddress();
    final chainId =
        ref.read(currentNetworkChainProvider.select((value) => value.chainId));
    return IncomingAccountsModel(
        address: address.toString(), chainId: chainId, rpcUrl: rpc);
  }

  Future<String> signTransaction(
      InAppWebViewController _, JsTransactionObject data, int chainId) async {
    return "0x45fb0060681bf5d8ea675ab0b3f76aa15c84b172f2fb3191b7a8ceb1e6a7f372";
  }

  Future<String> signPersonelMessage(
      InAppWebViewController _, String data, int chainId) async {
    try {
      Credentials fromHex = EthPrivateKey.fromHex("Private key here");
      final sig = await fromHex.signPersonalMessage(hexToBytes(data));

      debugPrint("SignedTx ${sig}");
      return bytesToHex(sig, include0x: true);
    } catch (e) {
      debugPrint("$e");
    }
    return "";
  }
}
