import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/send_transaction/controllers/function.dart'
    as func;
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';
import 'package:avex_mobile/features/swap/view/components/network_change.widget.dart';
import 'package:avex_mobile/features/swap/view/components/token1_selection_bottomsheet.dart';

class TokenBox1 extends ConsumerStatefulWidget {
  const TokenBox1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TokenBox1State();
}

class _TokenBox1State extends ConsumerState<TokenBox1> {
  TextEditingController valueController = TextEditingController();

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final token1 = ref.watch(swapProvider.select((value) => value.token1));
    final token1 = ref.watch(token1Provider.select((value) => value?.$1));
    final chain = ref.watch(swapNetworkProvider);
    return GestureDetector(
      onTap: () async {
        await token1SelectionBottomSheet(context);
      },
      child: Container(
        height: 100,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipOval(
                child: CircleAvatar(
                  radius: 36 / 2,
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: token1?.logo_url ?? '',
                    height: 35,
                    width: 35,
                    errorWidget: (context, url, error) =>
                        const NetworkAvatar(dimension: 35),
                  ),
                ),
              ),
              title: token1 != null
                  ? Text(token1.contract_name)
                  : Text(
                      'Select Token',
                      style: inter.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
              trailing: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(right: 0),
                  child: Consumer(builder: (context, ref, child) {
                    final valToSwap = ref.watch(valueToSwapProvider);
                    return Text(valToSwap.toStringAsFixed(4));
                  }),
                ),
                onTap: () async {
                  valueController.text = '';
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Palette.secondary,
                      icon: ClipOval(
                        child: CircleAvatar(
                          radius: 36 / 2,
                          backgroundColor: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: token1?.logo_url ?? '',
                            height: 35,
                            width: 35,
                            errorWidget: (context, url, error) =>
                                const NetworkAvatar(dimension: 35),
                          ),
                        ),
                      ),
                      title: Text(token1?.contract_name ?? chain.name),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: valueController,
                              onSubmitted: (value) {
                                ref.read(valueToSwapProvider.notifier).update(
                                      (state) => double.tryParse(value) ?? 0,
                                    );
                                context.pop();
                              },
                              onTapOutside: (v) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Enter amount',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final token1 = ref.watch(token1Provider)?.$1;
                if (token1 == null) return const Card();
                if (token1.native_token) {
                  return FutureBuilder<String>(
                    future: func.getBalance(token1.contract_address, 0, ref),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${token1.valueInEther.toStringAsFixed(4)} ${chain.coinSymbol}',
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
                }
                final val = BigInt.parse(token1.balance) /
                    BigInt.from(pow(10, (token1.contract_decimals)));
                return Text(
                  '${val.toStringAsFixed(4)} ${token1.contract_ticker_symbol}',
                  style: inter.copyWith(color: Colors.grey, fontSize: 10),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
