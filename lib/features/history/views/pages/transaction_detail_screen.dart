import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/history/models/native_transaction.model.dart';
import 'package:avex_mobile/main.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({
    required this.txnData,
    super.key,
  });

  final NativeTransaction txnData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(accountProvider.select((value) => value.address));
    final from = txnData.from_address;
    final to = txnData.to_address;
    bool received = false;
    if (to == address) {
      received = true;
    } else if (from == address) {
      received = false;
    }
    final value = BigInt.parse(txnData.value) / BigInt.from(pow(10, 18));
    final date = txnData.block_timestamp;
    final formattedDate = DateFormat().format(DateTime.parse(date));
    Size size = MediaQuery.of(context).size;
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Hero(
            tag: txnData.hash,
            child: const NetworkAvatar(dimension: 40),
          ),
          title: Text(
            received ? 'Received ' : 'Sent ',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            received ? 'from ' : 'to ${shortAddress(received ? from : to)}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xff999999),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(fontSize: 26),
                      ),
                      const SizedBox(width: 3),
                      Consumer(builder: (context, ref, child) {
                        const usdValue = '0';
                        final valInUsd = double.parse(usdValue) * value;
                        return Text(
                          valInUsd.toStringAsFixed(2),
                          style: GoogleFonts.inter(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                  Chip(
                    avatar: const NetworkAvatar(dimension: 20),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    label: Text(
                      '${value.toStringAsFixed(2)} ETH',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            StatefulBuilder(builder: (context, newState) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 60)
                    .copyWith(bottom: 20),
                height: 50,
                padding: const EdgeInsets.all(2).copyWith(left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              index == 0 ? Colors.grey : Colors.transparent,
                        ),
                        onPressed: () {
                          newState(() => index = 0);
                        },
                        child: const Text('Original'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              index == 1 ? Colors.grey : Colors.transparent,
                        ),
                        onPressed: () {
                          newState(() => index = 1);
                        },
                        child: const Text('Speed Up'),
                      ),
                    )
                  ],
                ),
              );
            }),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Text(
                  'Transaction Status',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Stepper(
                    elevation: 0,
                    controlsBuilder: (context, details) => const Card(),
                    margin: const EdgeInsets.all(0),
                    physics: const ClampingScrollPhysics(),
                    onStepTapped: (v) {},
                    currentStep: 2,
                    steps: [
                      Step(
                        state: StepState.complete,
                        title: const Text('Submitted'),
                        content: const Visibility(
                          visible: false,
                          child: Card(),
                        ),
                        isActive: true,
                        subtitle: Text(formattedDate),
                      ),
                      const Step(
                        state: StepState.complete,
                        title: Text('Pending'),
                        content: Visibility(
                          visible: false,
                          child: Card(),
                        ),
                        isActive: true,
                        subtitle: Text('Status: Confirmed'),
                      ),
                      const Step(
                          title: Text('Completed'),
                          state: StepState.complete,
                          content: Visibility(
                            visible: false,
                            child: Card(),
                          ),
                          isActive: true,
                          subtitle: Text('Status: Successful'))
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Text(
                  'Transaction Details',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Builder(
                builder: (context) {
                  final titleStyle = GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                  );
                  final valueStyle = titleStyle.copyWith(color: Colors.white);
                  const iconColor = Colors.grey;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: const Icon(Icons.wallet, color: iconColor),
                        title: Text('Amount', style: titleStyle),
                        trailing: Text('${value.toStringAsFixed(4)} ETH',
                            style: valueStyle),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading:
                            const Icon(Icons.compare_arrows, color: iconColor),
                        title: Text('Network', style: titleStyle),
                        trailing: Consumer(builder: (context, ref, child) {
                          return Text(
                            ref.watch(currentNetworkChainProvider).name,
                            style: valueStyle,
                          );
                        }),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: const Icon(Icons.feed, color: iconColor),
                        title: Text('Gas', style: titleStyle),
                        trailing: Text(txnData.gas, style: valueStyle),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: const Icon(Icons.gas_meter, color: iconColor),
                        title: Text('Gas Price', style: titleStyle),
                        trailing: Text(txnData.gas_price, style: valueStyle),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: const Icon(Icons.gas_meter, color: iconColor),
                        title: Text('Contract', style: titleStyle),
                        trailing: Text('NA', style: valueStyle),
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: const Icon(Icons.wallet, color: iconColor),
                        title: Text('Nonce', style: titleStyle),
                        trailing: Text(txnData.nonce, style: valueStyle),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
