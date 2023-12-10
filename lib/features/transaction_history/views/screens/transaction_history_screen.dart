// ignore_for_file: unused_result

import 'package:avex_mobile/features/home/bottom_navbar/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/utils/token_loading_listview.dart';
import 'package:avex_mobile/features/transaction_history/controller/transaction_history_provider.dart';
import 'package:avex_mobile/features/transaction_history/views/widget/txn_display_tile.dart';

final txnPaginateProvider = StateProvider.autoDispose<bool>((ref) => false);

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({super.key});

  @override
  ConsumerState<TransactionHistory> createState() => TransactionHistoryState();
}

class TransactionHistoryState extends ConsumerState<TransactionHistory> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        setState(() {
          if (ref.read(txnPaginateProvider)) page = page + 1;
        });
      } else if (scrollController.position.pixels == 0) {
        setState(() {
          page = page == 0 ? page : page - 1;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int page = 0;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavBar(),
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Transactions ${page == 0 ? '' : ' ▪ $page'}',
            style: inter.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                showSnackBar(context, 'Coming soon...');
              },
              child: const Text('Pending'),
            ),
            const SizedBox(width: 8),
          ],
          elevation: 0,
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return RefreshIndicator(
            onRefresh: () async {
              if (page == 0) {
                ref.refresh(transactionHistoryProvider(page));
              } else {
                page--;
              }
              setState(() {});
            },
            child: SizedBox(
              width: mq.size.width,
              height: mq.size.height - 50 - mq.padding.top,
              child: ref.watch(transactionHistoryProvider(page)).when(
                    data: (d) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: d.length,
                        itemBuilder: (context, index) {
                          final txn = d.elementAt(index);
                          return TxnDisplayTitle(txn: txn);
                        },
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: LoadingTokenListView(),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
