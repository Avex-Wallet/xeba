import 'dart:math';

import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';

class EmptyTokenList extends ConsumerWidget {
  const EmptyTokenList({
    super.key,
    required this.chain,
  });

  final NetworkChain chain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
      child: ListTile(
        onTap: () => TransactionHistoryRoute().push(context),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8).copyWith(right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        tileColor:
            const Color.fromRGBO(34, 37, 41, 0.43), // rgba(34, 37, 41, 0.43);,
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: NetworkAvatar(),
        ),
        title: Text(
          chain.name,
          overflow: TextOverflow.ellipsis,
        ),
        // isThreeLine: true,
        subtitle: FutureBuilder(
          future: fetchNativePrice(ref),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final val =
                  BigInt.parse(snapshot.data ?? '0') / BigInt.from(pow(10, 18));
              return Text('${val.toStringAsFixed(4)} ${chain.coinSymbol}');
            }
            return Text(chain.coinSymbol);
          },
        ),
      ),
    );
  }
}
