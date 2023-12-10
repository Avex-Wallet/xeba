import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/connected_app/dependencies/i_web3wallet_service.dart';
import 'package:avex_mobile/features/connected_app/pages/app_detail_page.dart';
import 'package:avex_mobile/features/connected_app/utils/string_constants.dart';
import 'package:avex_mobile/features/connected_app/widgets/pairing_item.dart';
import 'package:avex_mobile/features/connected_app/widgets/qr_scan_sheet.dart';
import 'package:avex_mobile/features/connected_app/widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget with GetItStatefulWidgetMixin {
  AppsPage({
    Key? key,
  }) : super(key: key);

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with GetItStateMixin {
  List<PairingInfo> _pairings = [];

  final Web3Wallet web3Wallet = GetIt.I<IWeb3WalletService>().getWeb3Wallet();

  @override
  void initState() {
    _pairings = web3Wallet.pairings.getAll();
    // web3wallet.onSessionDelete.subscribe(_onSessionDelete);
    web3Wallet.core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    web3Wallet.core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    super.initState();
  }

  @override
  void dispose() {
    // web3wallet.onSessionDelete.unsubscribe(_onSessionDelete);
    web3Wallet.core.pairing.onPairingDelete.unsubscribe(_onPairingDelete);
    web3Wallet.core.pairing.onPairingExpire.unsubscribe(_onPairingDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pairings = watch(
      target: GetIt.I<IWeb3WalletService>().pairings,
    );

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        title: const Text('Connections'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _onCopyQrCode,
            icon: const Icon(Icons.copy_all),
          ),
          IconButton(
            onPressed: _onScanQrCode,
            icon: const Icon(Icons.qr_code_2),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _pairings.isEmpty ? _buildNoPairingMessage() : _buildPairingList(),
    );
  }

  Widget _buildNoPairingMessage() {
    return Center(
      child: Text(
        StringConstants.noApps,
        textAlign: TextAlign.center,
        style: inter.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildPairingList() {
    final List<PairingItem> pairingItems = _pairings
        .map(
          (PairingInfo pairing) => PairingItem(
            key: ValueKey(pairing.topic),
            pairing: pairing,
            onTap: () => _onListItemTap(pairing),
          ),
        )
        .toList();

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: pairingItems.length,
      itemBuilder: (BuildContext context, int index) {
        return pairingItems[index];
      },
    );
  }

  Future _onCopyQrCode() async {
    final String? uri = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return UriInputPopup();
      },
    );
    _onFoundUri(uri);
  }

  Future _onScanQrCode() async {
    final String? s = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        final width = MediaQuery.of(context).size.width;
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Palette.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white30, width: 2)),
          padding:
              EdgeInsets.symmetric(horizontal: width * .1).copyWith(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    height: 20,
                    imageUrl:
                        'https://1000logos.net/wp-content/uploads/2022/05/WalletConnect-Logo.png',
                  ),
                  Text(
                    ' Scan To Connect',
                    style: inter.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const QRScanSheet(
                title: StringConstants.scanPairing,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.keyboard_double_arrow_down_sharp,
                    size: 30),
              )
            ],
          ),
        );
      },
    );

    _onFoundUri(s);
  }

  Future _onFoundUri(String? uri) async {
    if (uri != null) {
      try {
        final Uri uriData = Uri.parse(uri);
        await web3Wallet.pair(
          uri: uriData,
        );
      } catch (e) {
        _invalidUriToast();
      }
    } else {
      _invalidUriToast();
    }
  }

  void _invalidUriToast() {
    showSnackBar(context, StringConstants.invalidUri);
  }

  void _onPairingDelete(PairingEvent? event) {
    setState(() {
      _pairings = web3Wallet.pairings.getAll();
    });
  }

  void _onListItemTap(PairingInfo pairing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppDetailPage(
          pairing: pairing,
        ),
      ),
    );
  }
}
