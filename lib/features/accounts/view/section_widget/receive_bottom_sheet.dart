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
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart';

receiverBottomSheet(BuildContext context, Account account, int index) {
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
    builder: (context1) => ReceiveBottomSheet(account: account, index: index),
  );
}

class ReceiveBottomSheet extends StatefulWidget {
  final int index;
  final Account account;
  const ReceiveBottomSheet({
    super.key,
    required this.account,
    required this.index,
  });

  @override
  State<ReceiveBottomSheet> createState() => _ReceiveBottomSheetState();
}

enum _Chain { Ethereum, Solana, Bitcoin }

class _ReceiveBottomSheetState extends State<ReceiveBottomSheet> {
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
        const SizedBox(height: 10),
        Consumer(builder: (context, ref, child) {
          return TextField(
            controller: controller,
            onSubmitted: (v) {
              if (v.trim().isEmpty) return;
              v = v.trim();
              final newName = v.length > 12 ? v.substring(0, 12) : v;
              if (ref
                      .read(accountListProvider)
                      .firstWhere(
                        (element) => element.name == newName,
                        orElse: () => Account()..id = -1,
                      )
                      .id !=
                  -1) {
                v = widget.account.name!;
                return;
              }
              ref.read(accountListProvider.notifier).putAccount(widget.account
                ..name = (v.length > 12 ? v.substring(0, 12) : v));
              controller.text = v.substring(0, 12);
            },
            onTapOutside: (v) => FocusScope.of(context).unfocus(),
            textAlign: TextAlign.center,
            style: inter.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: controller.text.isNotEmpty
                  ? controller.text
                  : 'Account ${widget.account.id}',
              hintStyle: GoogleFonts.inter(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        }),
        const SizedBox(height: 15),
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46, vertical: 20),
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
                              _Chain.Bitcoin => widget.account.bitcoinAddress,
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
          padding:
              const EdgeInsets.symmetric(horizontal: 36).copyWith(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  textStyle: GoogleFonts.inter(fontSize: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Palette.primary,
                ),
                onPressed: () async {
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
                icon: const Icon(Icons.send, size: 16),
                label: Text(
                  ' Share ',
                  style: inter.copyWith(fontSize: 15),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                final current = ref.watch(accountProvider).current;
                final hide = widget.account.ishide;
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.inter(fontSize: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor:
                        current == widget.index || widget.account.ishide
                            ? Palette.secondary
                            : Palette.primary,
                    side: const BorderSide(color: Colors.white38),
                  ),
                  onPressed: () async {
                    if (current == widget.index) return;
                    await ref
                        .read(accountListProvider.notifier)
                        .putAccount(widget.account..ishide = !hide);
                    setState(() {});
                  },
                  icon: const Icon(Icons.account_balance_wallet_rounded,
                      size: 16),
                  label: Text(
                    widget.account.ishide ? 'Unhide' : ' Hide ',
                    style: inter.copyWith(fontSize: 15),
                  ),
                );
              }),
              if (!widget.account.ishide)
                Consumer(builder: (context, ref, child) {
                  final current = ref.watch(accountProvider).current;
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.inter(fontSize: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor:
                          current == widget.index || widget.account.ishide
                              ? Palette.secondary
                              : Palette.primary,
                      side: const BorderSide(color: Colors.white38),
                    ),
                    onPressed: () {
                      if (current == widget.index) return;
                      ref
                          .read(accountProvider.notifier)
                          .changeAddress(widget.index);
                    },
                    icon: const Icon(Icons.account_balance_wallet_rounded,
                        size: 16),
                    label: Text(
                      'Primary',
                      style: inter.copyWith(fontSize: 15),
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
