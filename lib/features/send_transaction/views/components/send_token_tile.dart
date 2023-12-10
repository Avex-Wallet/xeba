import 'dart:math';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendTokenTile extends ConsumerWidget {
  const SendTokenTile({required this.index, super.key});
  final TokenModel index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceUSD = double.parse(index.pretty_quote.replaceAll('\$', ''));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
      child: ListTile(
        onTap: () => context.pop(index),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8).copyWith(right: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        tileColor:
            const Color.fromRGBO(34, 37, 41, 0.43), // rgba(34, 37, 41, 0.43);,
        title: Text(
          index.contract_name,
          overflow: TextOverflow.ellipsis,
        ),
        // isThreeLine: true,
        subtitle: Builder(builder: (context) {
          final value = BigInt.parse(index.balance) /
              BigInt.from(pow(10, index.contract_decimals));
          final valueInString = value.toStringAsFixed(4);
          return Text("$valueInString ${index.contract_ticker_symbol}");
        }),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox.square(
            dimension: 40,
            child: Stack(
              children: [
                ClipOval(
                  child: Hero(
                    tag: index.contract_address,
                    child: CachedNetworkImage(
                      imageUrl: index.logo_url,
                      errorWidget: (context, url, error) =>
                          const NetworkAvatar(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox.square(
                    dimension: 16,
                    child: ClipOval(
                      child: Consumer(
                        builder: (context, ref, child) => CachedNetworkImage(
                          imageUrl: ref
                              .watch(currentNetworkChainProvider)
                              .coinLogoURI,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        trailing: Builder(builder: (context) {
          return RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              text: '\$ ${index.quote_rate}\n',
              style: urbunist.copyWith(
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: '\$ ${priceUSD.toStringAsFixed(2)}',
                  style: const TextStyle(wordSpacing: 0),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
