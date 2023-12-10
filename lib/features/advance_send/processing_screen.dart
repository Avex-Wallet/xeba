// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:avex_mobile/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/assets/assets.gen.dart';
import 'package:avex_mobile/core/themes/themes.dart';
import 'package:avex_mobile/features/send_transaction/controllers/send_fund_controller.dart';

class ProcessTxn extends ConsumerStatefulWidget {
  const ProcessTxn({Key? key}) : super(key: key);

  @override
  ConsumerState<ProcessTxn> createState() => _ProcessTxnState();
}

class _ProcessTxnState extends ConsumerState<ProcessTxn> {
  bool loaded = false;
  bool loadedExtra = false;
  int loadingDuration = 16;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => setState(() {
        loadedExtra = true;
      }),
    );
    Timer(
      Duration(seconds: loadingDuration),
      () => setState(() {
        loaded = true;
      }),
    );
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
            SizedBox(
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.square(
                    dimension: 300,
                    child: Stack(
                      children: [
                        if (!loaded)
                          Assets.lotties.loading.lottie(
                            width: 400,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        Align(
                          alignment: Alignment.center,
                          child: !loaded
                              ? Assets.images.transfer.image()
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
                    loaded
                        ? 'Transaction'
                        : loadedExtra
                            ? 'Transaction Initiated'
                            : 'Initiating Transaction',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    loaded
                        ? 'Successful !!'
                        : (loadedExtra
                            ? 'Waiting for Confirmation'
                            : 'Just a moment...'),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: loaded ? 16 : 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Opacity(
                  opacity: loaded ? 1 : 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.wallet),
                        style: OutlinedButton.styleFrom(
                          elevation: 0,
                          textStyle: inter.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          foregroundColor: Palette.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Palette.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () {
                          MainRoute().go(context);
                        },
                        label: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('View Details'),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        textStyle: GoogleFonts.inter().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor:
                            loaded ? Palette.primary : Palette.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => MainRoute().go(context),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Back to Home'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
