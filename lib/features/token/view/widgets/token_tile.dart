// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:avex_mobile/model/token/token_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';

class TokenTile extends ConsumerWidget {
  const TokenTile({required this.index, super.key});
  final TokenModel index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final NetworkChain chain = index.networkChainFromId;
    final priceUSD = double.parse(index.pretty_quote.replaceAll('\$', ''));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        onTap: () {
          if (chain == NetworkChain.solanaMainnet) {
            showSnackBar(context, 'Currently not available for solana');
            return;
          }
          TokenDetailScreenRoute(
            address: index.native_token
                ? chain == NetworkChain.solanaMainnet
                    ? '11111111111111111111111111111111'
                    : '0x0000000000000000000000000000000000000000'
                : index.contract_address,
            $extra: index,
          ).push(context);
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8).copyWith(right: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        tileColor:
            const Color.fromRGBO(34, 37, 41, 0.43), // rgba(34, 37, 41, 0.43);,
        title: Text(
          index.native_token && chain != null
              ? chain.name
              : index.contract_name,
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
                      imageUrl: index.native_token && chain != null
                          ? chain.coinLogoURI
                          : index.logo_url,
                      errorWidget: (context, url, error) =>
                          NetworkAvatar(chain: chain),
                    ),
                  ),
                ),
                if (!index.native_token)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: NetworkAvatar(
                      chain: chain,
                      dimension: 16,
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
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: '\$ ${priceUSD.toStringAsFixed(2)}',
                  style: TextStyle(
                    wordSpacing: 0,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
