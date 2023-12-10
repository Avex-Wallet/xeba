import 'package:avex_mobile/features/history/controllers/token_detail.controller.dart';
import 'package:avex_mobile/features/history/models/native_transaction.model.dart';
import 'package:avex_mobile/features/history/views/widget/stat_tile.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_hits.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/main.dart';

void nativeTokenTxnBottomSheet(BuildContext context,
    {TokenHits? token,
    String? amount,
    required NativeTransaction txn,
    required double value}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Consumer(builder: (context, ref, child) {
        final address =
            ref.watch(accountProvider.select((value) => value.address));
        String to = txn.to_address;
        String from = txn.from_address;
        bool sent = from == address;
        String input = txn.input;
        String tokenTransferAmount = input.substring(input.length - 40);
        final BigInt amt = BigInt.parse('0x$tokenTransferAmount');
        //!ERROR
        final tokenAddress = sent ? to : from;
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: ClipOval(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final address = sent ? to : from;
                      final i = ref.watch(tokenDetailProvider(address));
                      return i.when(
                        data: (data) => CachedNetworkImage(
                          imageUrl: data.logoURI,
                          height: 38,
                          width: 38,
                          errorWidget: (context, url, error) =>
                              const NetworkAvatar(),
                        ),
                        error: (error, stackTrace) => const NetworkAvatar(
                          dimension: 38,
                        ),
                        loading: () => const SizedBox.square(
                          dimension: 38,
                          child: Stack(
                            children: [
                              NetworkAvatar(),
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: sent ? 'Sent to' : 'Received from',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 16),
                    children: [
                      TextSpan(
                        text: ' ',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  sent ? shortAddress(to) : shortAddress(from),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                trailing: PopupMenuButton(
                  child: const Icon(Icons.more_horiz_rounded),
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('Share')),
                    const PopupMenuItem(child: Text('View Details')),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final chain = ref.watch(currentNetworkChainProvider);
                      // final usdValue =
                      //     ref.watch(tokenHitsProvider)[chain]?[0].priceUSD ??
                      //         '0';
                      // final valInUsd = double.parse(usdValue) * value;
                      return Text(
                        '${value.toStringAsFixed(2)} ${chain.coinSymbol}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      );
                    }),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final i = ref.watch(tokenDetailProvider(address));
                              return i.when(
                                data: (data) => CachedNetworkImage(
                                    imageUrl: data.logoURI,
                                    height: 20,
                                    width: 20),
                                error: (e, s) =>
                                    const NetworkAvatar(dimension: 20),
                                loading: () => const SizedBox.square(
                                  dimension: 20,
                                  child: Stack(
                                    children: [
                                      NetworkAvatar(dimension: 20),
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Consumer(
                          builder: (context, ref, child) =>
                              ref.watch(tokenDetailProvider(tokenAddress)).when(
                                    data: (data) {
                                      // final decimal = data.decimals;
                                      // final a =
                                      //     amt / BigInt.from(pow(10, decimal));
                                      return Text('$amt ${data.symbol}');
                                    },
                                    error: (error, stackTrace) =>
                                        Text(amt.toString()),
                                    loading: () => Text(amt.toString()),
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(72, 167, 255, 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size.fromHeight(42),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Successful'),
              ),
              Builder(builder: (context) {
                return Column(
                  children: [
                    StatTileWidget(
                      title: sent ? 'To' : 'From',
                      value: shortAddress(sent ? to : from),
                      icon: Icons.wallet,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return StatTileWidget(
                        title: 'Network',
                        value: ref.watch(currentNetworkChainProvider).name,
                        icon: Icons.compare_arrows,
                      );
                    }),
                    StatTileWidget(
                      title: 'Network Fee',
                      value: txn.gas_price,
                      icon: Icons.feed,
                    ),
                  ],
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(72, 167, 255, 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(42),
                      ),
                      onPressed: () => context.pop(),
                      child: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(72, 167, 255, 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size.fromHeight(42),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => context.pop(),
                      child: const Text('Share'),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
    },
  );
}
