// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:avex_mobile/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:avex_mobile/core/themes/themes.dart';
import 'package:avex_mobile/features/send_transaction/controllers/send_fund_controller.dart';
import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';

class LoadingTransaction extends ConsumerStatefulWidget {
  const LoadingTransaction({super.key});

  @override
  ConsumerState<LoadingTransaction> createState() => _LoadingTransactionState();
}

class _LoadingTransactionState extends ConsumerState<LoadingTransaction> {
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    iniTxn(send: true);
  }

  Future<void> back() async {
    await Future.delayed(const Duration(seconds: 15));
    MainRoute().go(context);
  }

  iniTxn({bool send = false}) async {
    final val =
        await ref.read(txnProvider.notifier).initiateTransaction(send: send) ??
            '';
    if (val.isNotEmpty) {
      setState(() {
        loaded = true;
      });
    }
    // ref.refresh(tokenListFutureProvider);
    ref.refresh(allTokenListFutureProvider(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 300,
                  child: Stack(
                    children: [
                      if (!loaded)
                        LottieBuilder.asset(
                          'assets/loading.json',
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: !loaded
                            ? Image.asset('assets/images/transfer.png')
                            : const Icon(
                                Icons.done_all_sharp,
                                size: 150,
                                color: Colors.green,
                              ),
                      ),
                    ],
                  ),
                ),
                Text(
                  loaded ? 'Transaction Initiated' : 'Initiating Transaction',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  loaded ? 'Successfully!' : 'Just a moment...',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    textStyle: GoogleFonts.inter().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Palette.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // ref.refresh(tokenListFutureProvider);
                    ref.refresh(allTokenListFutureProvider(null));
                    MainRoute().go(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Back to Home'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
