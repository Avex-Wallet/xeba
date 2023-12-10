// ignore_for_file: dead_code

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/send_transaction/controllers/send_fund_controller.dart';
import 'package:avex_mobile/features/send_transaction/models/txn.model.dart';
import 'package:avex_mobile/features/send_transaction/views/widgets/section_heading.widget.dart';
import 'package:avex_mobile/main.dart';

class ReviewYourTransaction extends ConsumerStatefulWidget {
  const ReviewYourTransaction({super.key, required this.txn});
  final Txn txn;

  @override
  ConsumerState<ReviewYourTransaction> createState() =>
      _ReviewYourTransactionState();
}

class _ReviewYourTransactionState extends ConsumerState<ReviewYourTransaction> {
  Timer? timer;
  @override
  void initState() {
    // ref.read(txnProvider.notifier).state = widget.txn;
    super.initState();
    logger.t(ref.read(txnProvider));
    ref.read(txnProvider.notifier).initiateTransaction();
    timer = Timer(const Duration(seconds: 10), () {
      ref.read(txnProvider.notifier).initiateTransaction();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inter = GoogleFonts.inter(color: Colors.white.withOpacity(0.9));
    final size = MediaQuery.of(context).size;
    final appBar = AppBar(
      title:
          Text('Review Your Transaction', style: inter.copyWith(fontSize: 22)),
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () => context.pop(),
      ),
    );
    final txn = ref.watch(txnProvider);
    return Scaffold(
      backgroundColor: Palette.background,
      bottomNavigationBar: Container(
        height: 50,
        width: size.width,
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  textStyle: inter.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  foregroundColor: Palette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Palette.primary, width: 2),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Cancel'),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: inter.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor:
                      txn.gas == 'Loading...' ? Colors.grey : Palette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  if (txn.gas == 'Loading...') return;
                  ProcessingTransactionRoute().push(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => ref.read(txnProvider.notifier).initiateTransaction(),
        child: SizedBox(
          height: size.height - appBar.preferredSize.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SectionHeading(title: 'WITHDRAWING', inter: inter),
              Container(
                width: size.width,
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                    .copyWith(bottom: 25),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xff2a282d),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final account = ref.watch(accountProvider);
                    return Column(
                      children: [
                        Container(
                          height: 34,
                          width: size.width,
                          color: Palette.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Account ${account.current + 1}',
                                style: inter.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                shortAddress(account.address),
                                style: inter.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: size.width,
                            child: true
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          imageUrl: txn.token?.logo_url ??
                                              ref
                                                  .read(
                                                      currentNetworkChainProvider)
                                                  .coinLogoURI,
                                          errorWidget: (context, url, error) =>
                                              const NetworkAvatar(),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        txn.token?.contract_ticker_symbol ??
                                            ref
                                                .read(
                                                    currentNetworkChainProvider)
                                                .coinSymbol,
                                        style: inter.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(txn.value),
                                    ],
                                  )
                                : Center(
                                    child: ListTile(
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: txn.token?.logo_url ??
                                              ref
                                                  .read(
                                                      currentNetworkChainProvider)
                                                  .coinLogoURI,
                                          errorWidget: (context, url, error) =>
                                              const NetworkAvatar(),
                                        ),
                                      ),
                                      title: Text(
                                        txn.token?.contract_ticker_symbol ??
                                            ref
                                                .read(
                                                    currentNetworkChainProvider)
                                                .coinSymbol,
                                      ),
                                      trailing: Text(txn.value),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              //* DEPOSITE TO
              SectionHeading(title: 'DEPOSITING', inter: inter),
              Container(
                width: size.width,
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                    .copyWith(bottom: 25),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xff2a282d),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      width: size.width,
                      color: Palette.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Receiver',
                            style: inter.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            // ignore: unnecessary_null_comparison
                            txn != null ? shortAddress(txn.toAddress) : '0x',
                            style: inter.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: true
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      height: 50,
                                      width: 50,
                                      imageUrl: txn.token?.logo_url ??
                                          ref
                                              .read(currentNetworkChainProvider)
                                              .coinLogoURI,
                                      errorWidget: (context, url, error) =>
                                          const NetworkAvatar(),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    txn.token?.contract_ticker_symbol ??
                                        ref
                                            .read(currentNetworkChainProvider)
                                            .coinSymbol,
                                    style: inter.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    txn.value,
                                  ),
                                ],
                              )
                            : Center(
                                child: ListTile(
                                  leading: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: txn.token?.logo_url ??
                                          ref
                                              .read(currentNetworkChainProvider)
                                              .coinLogoURI,
                                      errorWidget: (context, url, error) =>
                                          const NetworkAvatar(),
                                    ),
                                  ),
                                  title: Text(
                                    txn.token?.contract_ticker_symbol ??
                                        ref
                                            .read(currentNetworkChainProvider)
                                            .coinSymbol,
                                  ),
                                  trailing: Text(
                                    txn.value,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              //* Speed Up Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Consumer(builder: (context, ref, child) {
                  final speed = txn.speed;
                  final speedNotifier = ref.watch(txnProvider.notifier);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => speedNotifier.changeSpeed(),
                        child: Text(
                          'Speed Up',
                          style: inter.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff2a282d),
                        ),
                        child: GestureDetector(
                          onTap: () => () => speedNotifier.changeSpeed(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => speedNotifier.setSpeed(Speed.Slow),
                                child: Container(
                                  height: 12,
                                  width: speed == Speed.Slow ? 20 : 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    speedNotifier.setSpeed(Speed.Average),
                                child: Container(
                                  height: 12,
                                  width: speed == Speed.Average ? 20 : 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => speedNotifier.setSpeed(Speed.Fast),
                                child: Container(
                                  height: 12,
                                  width: speed == Speed.Fast ? 20 : 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              //* Gas Estimate
              Container(
                height: 160,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2a282d),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Card(),
                    // ! ---------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Estimated Gas Fee  ',
                              style: inter.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const Icon(Icons.error, size: 12)
                          ],
                        ),
                        Text(
                          txn.gas ?? '0',
                          style: inter.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    //! -----------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Estimated Time  ',
                              style: inter.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const Icon(Icons.error, size: 12)
                          ],
                        ),
                        Text(
                          txn.speed == Speed.Average
                              ? 'Likely in < 30 seconds'
                              : (txn.speed == Speed.Slow
                                  ? 'Maybe in 30 seconds'
                                  : 'Very likely in < 15 seconds'),
                          style: inter.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Cost',
                          style: inter.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Builder(builder: (context) {
                          if (txn.gas == 'Loading...') {
                            return Text(
                              'Loading...',
                              style: inter.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            );
                          }
                          final gassy = BigInt.tryParse(txn.gas ?? '0') ??
                              BigInt.parse('0');
                          final total = gassy + BigInt.parse(txn.value);
                          return Text(
                            total.toString(),
                            style: inter.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          );
                        }),
                      ],
                    ),
                    const Card(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
