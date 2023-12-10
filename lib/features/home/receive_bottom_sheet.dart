// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart';
import 'package:avex_mobile/services/local_services/shared_pref/shared_pref.dart';

receiverBottomSheet({required WidgetRef ref, required BuildContext context}) {
  final current = ref.read(sharedPref).currentAccountCount;
  final accountList = ref.read(accountListProvider);
  return showModalBottomSheet(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 34, 34, 34),
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context1) =>
        _ReceiveBottomSheet(account: accountList[current], index: current),
  );
}

class _ReceiveBottomSheet extends StatefulWidget {
  final int index;
  final Account account;
  const _ReceiveBottomSheet({
    required this.account,
    required this.index,
  });

  @override
  State<_ReceiveBottomSheet> createState() => _ReceiveBottomSheetState();
}

enum _Chain { Ethereum, Solana, Bitcoin }

class _ReceiveBottomSheetState extends State<_ReceiveBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController(
        text: widget.account.name ?? 'Account ${1 + widget.account.id}');
    super.initState();
  }

  _Chain chain = _Chain.Ethereum;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          controller.text.isNotEmpty
              ? controller.text
              : 'Account ${widget.account.id}',
          style: inter.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 36,
                child: DropdownButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 11,
                      child: Image.asset(
                        switch (chain) {
                          _Chain.Ethereum => 'assets/icons/ethereum.png',
                          _Chain.Solana => 'assets/icons/solana.png',
                          _Chain.Bitcoin => 'assets/icons/bitcoin.png',
                        },
                        height: 20,
                      ),
                    ),
                  ),
                  value: chain,
                  underline: const Card(),
                  items: [
                    ..._Chain.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                  ],
                  onChanged: (value) => setState(() {
                    if (value != null) chain = value;
                  }),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          height: 186,
          width: 186,
          padding: const EdgeInsets.all(5),
          color: Colors.white,
          child: PrettyQrView.data(
            errorCorrectLevel: QrErrorCorrectLevel.H,
            data: switch (chain) {
                  _Chain.Ethereum => widget.account.ethAddress,
                  _Chain.Solana => widget.account.solanaAddress,
                  _Chain.Bitcoin => widget.account.bitcoinAddress,
                } ??
                widget.account.ethAddress,
            decoration: PrettyQrDecoration(
              image: PrettyQrDecorationImage(
                image: AssetImage(
                  switch (chain) {
                    _Chain.Ethereum => 'assets/icons/ethereum.png',
                    _Chain.Solana => 'assets/icons/solana.png',
                    _Chain.Bitcoin => 'assets/icons/bitcoin.png',
                  },
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  final address = switch (chain) {
                        _Chain.Ethereum => widget.account.ethAddress,
                        _Chain.Solana => widget.account.solanaAddress,
                        _Chain.Bitcoin => widget.account.bitcoinAddress,
                      } ??
                      widget.account.ethAddress;
                  await Clipboard.setData(ClipboardData(text: address));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Address ${shortAddress(address)} copied'),
                      elevation: 40,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: [
                      Text(
                        shortAddress(
                            switch (chain) {
                                  _Chain.Ethereum => widget.account.ethAddress,
                                  _Chain.Solana => widget.account.solanaAddress,
                                  _Chain.Bitcoin =>
                                    widget.account.bitcoinAddress,
                                } ??
                                widget.account.ethAddress,
                            i: 8),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      const Icon(Icons.copy, size: 18)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                bottom: 12,
              ),
              child: InkWell(
                radius: 20,
                onTap: () async {
                  final i = await ScreenshotController().captureFromWidget(
                    Container(
                      height: 186,
                      width: 186,
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: QrImageView(data: widget.account.ethAddress),
                    ),
                  );
                  final dir = (await getApplicationDocumentsDirectory()).path;
                  File imgFile = File('$dir/screenshot.png');
                  imgFile.writeAsBytes(i);
                  await Share.shareXFiles(
                    [XFile(imgFile.path)],
                    text: widget.account.ethAddress,
                    subject: 'My Wallet Address',
                  );
                },
                child: const Icon(Icons.send, size: 21),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
