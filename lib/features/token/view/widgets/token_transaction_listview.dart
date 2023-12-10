// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/token/view/pages/token_detail_screen.dart';
import 'package:avex_mobile/features/token/view/components/transaction_bottomsheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransactionListView extends ConsumerWidget {
  const TokenTransactionListView(
      {super.key, required this.data, required this.token});
  final List<TokenTransactionModel> data;
  final TokenModel token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ascOrder = ref.watch(ascProvider);
    if (data.isEmpty) {
      return const Center(
        child: Chip(
          backgroundColor: Palette.background,
          label: Text(
            'No Transaction Found',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white30,
              fontSize: 17,
            ),
          ),
        ),
      );
    }

    late List<TokenTransactionModel> list =
        ascOrder ? data : data.reversed.toList();
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = list.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TokenTransactionDateHeading(item: item, data: list, index: index),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListTile(
                dense: true,
                tileColor: const Color.fromRGBO(34, 37, 41, 0.43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () => showTokenTransactionBottomSheet(
                  context: context,
                  transaction: item,
                  token: token,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: token.logo_url,
                    height: 40,
                    width: 40,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final account = ref.watch(
                          accountProvider.select((value) => value.address));
                      bool sent = item.from_address == account;
                      return Row(
                        children: [
                          Text(
                            sent ? 'Send To' : 'Received From',
                            style: inter.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' ${sent ? shortAddress(item.to_address) : shortAddress(item.from_address)}',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      );
                    }),
                    Text((item.value_quote ?? 0).toStringAsFixed(6)),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('To ${shortAddress(item.to_address)}'),
                    Text((item.value_quote ?? 0).toStringAsFixed(6)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TokenTransactionDateHeading extends StatelessWidget {
  const TokenTransactionDateHeading({
    super.key,
    required this.item,
    required this.data,
    required this.index,
  });

  final TokenTransactionModel item;
  final List<TokenTransactionModel> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 8,
      ),
      child: Builder(builder: (context) {
        if (index == 0 || item.block_signed_at != null) {
          final time1 = DateTime.parse(item.block_signed_at!).toLocal();
          return Text(
            time1.toString().substring(0, time1.toString().indexOf(" ")),
            style: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          );
        } else if (data.elementAt(index - 1).block_signed_at == null)
          return Container();
        else if (item.block_signed_at == null) return Container();

        final time1 = DateTime.parse(item.block_signed_at!).toLocal();
        // final time2 =
        //     DateTime.parse(data.elementAt(index).block_signed_at!).toLocal();
        final now = DateTime.now();
        if (time1.day == now.day && time1.difference(now).inDays < 1) {
          return const Text('Today');
        }
        return Text(
          time1.toString().substring(0, time1.toString().indexOf(" ")),
          style: const TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        );
        // }
      }),
    );
  }
}

class Cart {}
