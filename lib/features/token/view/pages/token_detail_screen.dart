import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/utils/token_loading_listview.dart';
import 'package:avex_mobile/features/token/controller/native_token_transaction.dart';
import 'package:avex_mobile/features/token/controller/token_transaction_history.dart';
import 'package:avex_mobile/features/token/view/widgets/app_bar.dart';
import 'package:avex_mobile/features/token/view/widgets/token_price_chart.dart';
import 'package:avex_mobile/features/token/view/widgets/token_transaction_listview.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final ascProvider = StateProvider.autoDispose<bool>((ref) => true);
final currentSelectedTokenChain = StateProvider.autoDispose<NetworkChain>(
    (ref) => NetworkChain.ethereumGoerli);

class TokenDetailScreen extends ConsumerStatefulWidget {
  const TokenDetailScreen({super.key, required this.token});
  final TokenModel token;

  @override
  ConsumerState<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends ConsumerState<TokenDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool asc = true;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(token: widget.token),
      ),
      body: SizedBox(
        height: mq.size.height - mq.padding.top - 50,
        child: Column(
          children: [
            Container(
              color: Palette.background,
              height: mq.size.height * .3,
              child: ChartSectionWidget(widget.token),
            ),
            TokenPriceChart(token: widget.token),
            Container(
              color: Palette.background,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Divider(thickness: 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: mq.size.width * 0.45,
                        child: Column(
                          children: [
                            Text(
                              'Balance',
                              style: inter.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final v = BigInt.parse(widget.token.balance) /
                                    BigInt.from(pow(
                                        10, widget.token.contract_decimals));
                                return Text(
                                  '${v.toStringAsFixed(4)} ${widget.token.contract_ticker_symbol}',
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.5,
                        height: 50,
                        color: Colors.white24,
                      ),
                      SizedBox(
                        width: mq.size.width * 0.45,
                        child: Column(
                          children: [
                            Text(
                              'Value',
                              style: inter.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text('\$ ${widget.token.quote}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 0.8),
                ],
              ),
            ),
            // === Activities ===
            Container(
              color: Palette.background,
              child: ListTile(
                dense: true,
                title: Text('Activity',
                    style: inter.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return IconButton(
                        splashRadius: 20,
                        onPressed: () => setState(() => ref
                            .read(ascProvider.notifier)
                            .update((state) => !state)),
                        icon: ref.watch(ascProvider)
                            ? const Icon(Icons.sort)
                            : const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.sort),
                              ),
                      );
                    }),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white30)),
                      color: Palette.background,
                      splashRadius: 20,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text('All'),
                        ),
                        const PopupMenuItem(
                          child: Text('Sent'),
                        ),
                        const PopupMenuItem(
                          child: Text('Received'),
                        ),
                      ],
                      child: const Icon(Icons.filter_alt_outlined),
                    )
                  ],
                ),
              ),
            ),
            // === Activity ===
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  if (widget.token.native_token) {
                    final tokenTransactionHistory = ref.watch(
                        nativeTokenTransaction(
                            (widget.token.networkChainFromId, 0)));
                    return RefreshIndicator(
                      onRefresh: () async => ref.refresh(nativeTokenTransaction(
                          (widget.token.networkChainFromId, 0))),
                      child: tokenTransactionHistory.when(
                        error: (error, stackTrace) {
                          return Text(error.toString());
                        },
                        loading: () => const LoadingTokenListView(),
                        data: (data) => TokenTransactionListView(
                          data: data,
                          token: widget.token,
                        ),
                      ),
                    );
                  } else {
                    final tokenTransactionHistory = ref
                        .watch(tokenTransactionHistoryProvider(widget.token));
                    return RefreshIndicator(
                      onRefresh: () async => ref
                          .watch(tokenTransactionHistoryProvider(widget.token)),
                      child: tokenTransactionHistory.when(
                        error: (error, stackTrace) {
                          return const Card();
                        },
                        loading: () => const LoadingTokenListView(),
                        data: (res) => res.fold(
                          (l) => TokenTransactionListView(
                              data: l, token: widget.token),
                          (r) => Center(
                            child: Chip(
                              label: Text('Status ${r.code}: ${r.message}'),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
