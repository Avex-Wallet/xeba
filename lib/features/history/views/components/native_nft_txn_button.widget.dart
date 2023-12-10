import 'dart:convert';

import 'package:avex_mobile/features/history/controllers/nft_detail.controller.dart';
import 'package:avex_mobile/features/history/models/native_transaction.model.dart';
import 'package:avex_mobile/features/history/views/widget/stat_tile.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_hits.dart';
import 'package:avex_mobile/main.dart';

void nativeNftTxnBottomSheet(BuildContext context,
    {TokenHits? token,
    String? amount,
    required NativeTransaction txn,
    required double value}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      String to = txn.to_address;
      String from = txn.from_address;
      bool sent = from == '0xbdfa4f4492dd7b7cf211209c4791af8d52bf5c50';
      String input = txn.input;
      final BigInt tokenId =
          BigInt.parse('0x${input.substring(10 + 64 + 64, 10 + 64 + 64 + 64)}');
      final contractAddress = sent ? to : from;

      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
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
              leading: const NetworkAvatar(),
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
                height: MediaQuery.of(context).size.width - 80,
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Consumer(builder: (context, ref, child) {
                  return FutureBuilder<List<String>?>(
                    future: fetchNFTDetail(
                      NftDetailBody(
                        contractAddress: contractAddress,
                        chain: ref.watch(currentNetworkChainProvider).chainName,
                        tokenId: tokenId.toString(),
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        if (data == null) return const Text('NULL');
                        final imageUrl = getImageUrl(
                            data.first.toString().contains("image")
                                ? jsonDecode(data.first.toString())["image"]
                                : getImageUrl(data.last.toString()));
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            errorWidget: (context, url, error) =>
                                const NetworkAvatar(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('404'));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                })),
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
              onPressed: () => context.pop(),
              child: const Text('Completed'),
            ),
            Builder(builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
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
            Flexible(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(72, 167, 255, 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(42),
                ),
                onPressed: () => context.pop(),
                child: const Text('Show Receipt'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
