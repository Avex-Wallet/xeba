// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:avex_mobile/features/home/bottom_navbar/home.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/history/views/pages/transaction_detail_screen.dart';
import 'package:avex_mobile/features/history/views/components/native_nft_txn_button.widget.dart';
import 'package:avex_mobile/features/history/views/components/native_token_txn_bottom_sheet.dart';
import 'package:avex_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../controllers/native_transaction.controller.dart';

enum TransactionType {
  Native,
  ERC20,
  ERC721,
}

extension TransactionTypeExtension on TransactionType {
  Color get getColor {
    switch (this) {
      case TransactionType.ERC20:
        return Colors.red;
      case TransactionType.ERC721:
        return Colors.blue;
      default:
        return Colors.transparent;
    }
  }
}

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchTransaction();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginate();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> paginate() async {
    await ref.read(nativeTransactionProvider.notifier).paginate();
  }

  Future<void> fetchTransaction() async {
    await ref.read(nativeTransactionProvider.notifier).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Transactions',
          style: GoogleFonts.inter(
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
      bottomNavigationBar: const HomeBottomNavBar(),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final chain = ref.watch(currentNetworkChainProvider);
            final nativeTransactionList = ref.watch(nativeTransactionProvider);
            logger.f(nativeTransactionList);
            final address =
                ref.watch(accountProvider.select((value) => value.address));
            if (nativeTransactionList[chain] == null ||
                (nativeTransactionList[chain] ?? []).isEmpty) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No Transaction\nDetected!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              controller: scrollController,
              itemCount: nativeTransactionList[chain]?.length ?? 0,
              itemBuilder: (context, index) {
                final data = nativeTransactionList[chain]?.elementAt(index);
                final from = data?.from_address ?? '0x';
                final to = data?.to_address ?? '0x';
                bool received = false;
                if (to == address) {
                  received = true;
                } else if (from == address) {
                  received = false;
                }
                final value =
                    BigInt.parse(data?.value ?? '0') / BigInt.from(pow(10, 18));

                TransactionType type = TransactionType.Native;
                if (data?.input.startsWith('0xa9059cbb') ?? false) {
                  type = TransactionType.ERC20;
                } else if (data?.input.startsWith('0xb88d4fde') ?? false) {
                  type = TransactionType.ERC721;
                }
                return ListTile(
                  onTap: () {
                    if (data != null) {
                      if (type == TransactionType.ERC20) {
                        nativeTokenTxnBottomSheet(context,
                            txn: data, value: value);
                      } else if (type == TransactionType.ERC721) {
                        nativeNftTxnBottomSheet(context,
                            txn: data, value: value);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionDetailScreen(txnData: data),
                          ),
                        );
                      }
                    }
                  },
                  leading: SizedBox.square(
                    dimension: 40,
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: type.getColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.purple),
                          ),
                          child: Icon(
                            received
                                ? Icons.call_received_rounded
                                : Icons.call_made_rounded,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Hero(
                            tag: data?.hash ?? '',
                            child: const NetworkAvatar(dimension: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        final address = data?.block_hash ?? '';
                        final shortAddress =
                            '${address.substring(0, 6)}....${address.substring(address.length - 6)}';
                        return Text(shortAddress);
                      }),
                      Consumer(builder: (context, ref, child) {
                        final valInUsd = 0 * value;
                        return Text('\$ ${valInUsd.toStringAsFixed(2)}');
                      }),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          final date = data?.block_timestamp;
                          return Text(
                              '${received ? 'Received' : 'Sent'}${' ▪ ${date == null ? '' : DateFormat.MMMEd().format(DateTime.parse(date))}'}');
                        },
                      ),
                      Text('${value.toStringAsFixed(2)} ${chain.coinSymbol}'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
