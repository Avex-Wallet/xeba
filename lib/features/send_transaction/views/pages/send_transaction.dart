// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:avex_mobile/features/advance_send/processing_screen.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/auth/username/service/user_service.dart';
import 'package:avex_mobile/features/send_transaction/controllers/function.dart';
import 'package:avex_mobile/features/send_transaction/controllers/send_fund_controller.dart';
import 'package:avex_mobile/features/send_transaction/models/txn.model.dart';
import 'package:avex_mobile/features/send_transaction/views/components/account_section.widget.dart';
import 'package:avex_mobile/features/send_transaction/views/components/app_bar.dart';
import 'package:avex_mobile/features/send_transaction/views/components/select_asset_bottomsheet.dart';
import 'package:avex_mobile/features/send_transaction/views/widgets/label.widget.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final assetIndexProvider = StateProvider.autoDispose<int>(
    (ref) => ref.read(currentNetworkChainProvider).index);

class SendTransactionScreen extends ConsumerStatefulWidget {
  const SendTransactionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendTransactionPageState();
}

class _SendTransactionPageState extends ConsumerState<SendTransactionScreen> {
  TextEditingController toAddress = TextEditingController();
  TextEditingController value = TextEditingController();

  TokenModel? token;

  @override
  void initState() {
    super.initState();
    ref.read(assetIndexProvider);
  }

  @override
  void dispose() {
    toAddress.dispose();
    value.dispose();
    super.dispose();
  }

  void sendTransaction() {
    if (token?.chainId == 50) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProcessTxn(),
        ),
      );
      return;
    }
    if (token == null) {
      showSnackBar(context, 'Please select token first.');
      return;
    } else if (!toAddress.text.contains('0x') || toAddress.text.length != 42) {
      showSnackBar(context, 'Invalid! To Address');
      return;
    } else if (value.text.isEmpty) {
      showSnackBar(context, 'Value field is empty');
      return;
    }

    final availableBalBigInt = BigInt.parse(token?.balance ?? '0');
    final valueToSend = BigInt.from(
        (double.parse(value.text.isEmpty ? '0' : value.text) *
            pow(10, token?.contract_decimals ?? 18)));

    if (availableBalBigInt.compareTo(valueToSend) < -1)
      showSnackBar(context, 'Available balance is less than sending amount');
    else {
      final txn = Txn(
        value: valueToSend.toString(),
        address: ref.read(accountProvider).address,
        toAddress: toAddress.text,
        token: token,
        speed: Speed.Average,
        gas: 'Loading...',
      );
      ref.read(txnProvider.notifier).setState(
            Txn(
              value: valueToSend.toString(),
              address: ref.read(accountProvider).address,
              toAddress: toAddress.text,
              token: token,
              speed: Speed.Average,
              gas: 'Loading...',
            ),
          );
      ReviewYourTransactionRoute(txn).push(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.background,
      bottomNavigationBar: Container(
        height: 50,
        width: size.width,
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  textStyle: inter.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Palette.primary, width: 1),
                  ),
                ),
                onPressed: () {
                  if (toAddress.text.isEmpty || value.text.isEmpty)
                    context.pop();
                  toAddress.text = '';
                  value.text = '';
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Cancel'),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: inter.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Palette.primary),
                  ),
                ),
                onPressed: sendTransaction,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: appBar(context),
      body: SafeArea(
        child: SizedBox(
          height: size.height - appBar(context).preferredSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Label(label: 'From'),
              const AccountSectionWidget(),
              const Label(label: 'To'),
              Container(
                height: 50,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2C2B32)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width - 100,
                      child: Center(
                        child: TextField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          magnifierConfiguration:
                              const TextMagnifierConfiguration(
                            shouldDisplayHandlesInMagnifier: false,
                          ),
                          controller: toAddress,
                          onChanged: (value) {
                            toAddress.text = value.replaceAll(' ', '');
                          },
                          onSubmitted: (v) async {
                            if (v.contains('.eth')) {
                              final addr = await getAddressFromEns(v);
                              toAddress.text = addr ?? toAddress.text;
                            } else if (!v.contains('.eth') &&
                                !v.startsWith('0x')) {
                              final accessToken =
                                  await SecureStorage.accessToken.value;
                              final res = await ref
                                  .read(userServiceProvider)
                                  .getAddressByUsername(
                                      username: v, accessToken: accessToken);
                              logger.t(res);
                              res.fold((l) => toAddress.text = l, (r) => null);
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            border: InputBorder.none,
                            hintText: 'Enter ENS or Address',
                            hintStyle: inter.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Card(
                      color: Colors.white12,
                      shape: const CircleBorder(),
                      child: SizedBox.square(
                        dimension: 45,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(45 / 2),
                          onTap: () async {
                            final address = await QrScreenRoute().push(context);
                            if (address == null || address.toString() == '') {
                              return;
                            }
                            toAddress.text = address.toString();
                          },
                          child: const Center(
                            child: Icon(Icons.qr_code_2_rounded),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Label(label: 'Value'),
              Container(
                height: 50,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2C2B32)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        TokenModel? v =
                            await showBottomScrollAssetsSheet(context);
                        if (v != null) token = v;
                        setState(() {});
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (token != null)
                              Consumer(builder: (context, ref, child) {
                                return ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: token?.logo_url ??
                                        ref
                                            .watch(currentNetworkChainProvider)
                                            .coinLogoURI,
                                    errorWidget: (context, url, error) =>
                                        const NetworkAvatar(),
                                  ),
                                );
                              }),
                            Consumer(builder: (context, ref, child) {
                              return Text(
                                '  ${token?.contract_ticker_symbol ?? 'Select'} ',
                                style: inter.copyWith(),
                              );
                            }),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          magnifierConfiguration:
                              const TextMagnifierConfiguration(
                            shouldDisplayHandlesInMagnifier: false,
                          ),
                          controller: value,
                          onTapOutside: (v) => FocusScope.of(context).unfocus(),
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: InputBorder.none,
                            hintText: '0',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final address = ref.watch(accountProvider).address;
                      final chain = ref.watch(currentNetworkChainProvider);
                      if (token == null || (token?.native_token ?? false)) {
                        return FutureBuilder<String>(
                          future: getBalance(address, 0, ref),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data ?? '0';
                              final value =
                                  BigInt.parse(data) / BigInt.from(pow(10, 18));
                              return Text(
                                '${value == 0 ? value.toStringAsFixed(2) : value.toStringAsFixed(4)} ${chain.coinSymbol}',
                                style: inter.copyWith(color: Colors.grey),
                              );
                            } else {
                              return Text(
                                '',
                                style: inter.copyWith(color: Colors.grey),
                              );
                            }
                          },
                        );
                      } else if (token != null) {
                        final v = BigInt.parse(token?.balance ?? '0') /
                            BigInt.from(pow(10, token?.contract_decimals ?? 0));
                        return Text(
                          '${v.toStringAsFixed(4)} ${token?.contract_ticker_symbol}',
                          style: inter.copyWith(color: Colors.grey),
                        );
                      }
                      return const Card();
                    }),
                    Text(
                      'MAX',
                      style: inter,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
