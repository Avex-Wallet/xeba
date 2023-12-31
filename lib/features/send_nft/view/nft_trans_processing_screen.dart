// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'package:xeba_mobile/core/core.dart';
import 'package:xeba_mobile/core/enums/enums.dart';
import 'package:xeba_mobile/features/send_nft/functions/nft_transfer_function.dart';
import 'package:xeba_mobile/features/send_nft/view/send_nft_screen.dart';
import 'package:xeba_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:xeba_mobile/model/nft/nft_model.dart';

class NFTTxnProcessScreen extends ConsumerStatefulWidget {
  const NFTTxnProcessScreen({
    required this.nft,
    required this.chain,
    required this.toAddress,
    super.key,
  });
  final NFTModel nft;
  final NetworkChain chain;
  final String toAddress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NFTTxnProcessScreenState();
}

class _NFTTxnProcessScreenState extends ConsumerState<NFTTxnProcessScreen> {
  TransactionState transactionState = TransactionState.waiting;
  @override
  void initState() {
    super.initState();
    iniTxn();
  }

  Future iniTxn() async {
    transactionState = await transferNFT(
      chainId: widget.chain.chainId,
      nftContractAddress: widget.nft.contract_address!,
      ref: ref,
      tokenId: int.parse(widget.nft.token_id!),
      transactionSpeed: ref.watch(speedProvider).index,
      to: widget.toAddress,
    );
    // ref.refresh(tokenListFutureProvider);
    ref.refresh(allTokenListFutureProvider(null));
    setState(() {});
  }

  int len = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.background,
      body: SizedBox(
        height: h,
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: const SizedBox(),
              centerTitle: true,
              title: switch (transactionState) {
                TransactionState.waiting => Chip(
                    backgroundColor: Colors.transparent.withOpacity(0.5),
                    label: Text(
                      'Just a  moment ..',
                      style: inter.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 14,
                      ),
                    ),
                  ),
                TransactionState.completed => Chip(
                    backgroundColor: Colors.transparent.withOpacity(0.5),
                    label: Text(
                      'Successfully Initiated!',
                      style: inter.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 14,
                      ),
                    ),
                  ),
                _ => Chip(
                    backgroundColor: Colors.transparent.withOpacity(0.5),
                    label: Text(
                      'Transaction Failed',
                      style: inter.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 14,
                      ),
                    ),
                  ),
              },
            ),
            switch (transactionState) {
              TransactionState.waiting => SizedBox(
                  width: w,
                  height: w,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: w,
                        height: w,
                        child: LottieBuilder.asset(
                          'assets/loading.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/transfer.png',
                        ),
                      ),
                    ],
                  ),
                ),
              TransactionState.completed => LottieBuilder.asset(
                  repeat: false,
                  'assets/images/transaction_done.json',
                  width: w - 100,
                  height: w - 100,
                  fit: BoxFit.cover,
                ),
              _ => LottieBuilder.asset(
                  repeat: false,
                  'assets/images/txn_failed.json',
                  width: w,
                  height: w,
                  fit: BoxFit.cover,
                ),
            },
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: inter.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: transactionState == TransactionState.waiting
                      ? Palette.secondary
                      : Palette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // ref.refresh(tokenListFutureProvider);
                  MainRoute().go(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Back to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
