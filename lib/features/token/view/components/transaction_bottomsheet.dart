import 'package:avex_mobile/features/token/view/pages/token_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/token/view/widgets/stats_tile_widget.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';

showTokenTransactionBottomSheet({
  required BuildContext context,
  required TokenTransactionModel transaction,
  required TokenModel token,
}) {
  showModalBottomSheet(
    elevation: 0,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: Palette.background,
    context: context,
    useSafeArea: true,
    builder: (context) =>
        TransactionBottomSheet(txn: transaction, token: token),
  );
}

class TransactionBottomSheet extends StatefulWidget {
  final TokenTransactionModel txn;
  final TokenModel token;
  const TransactionBottomSheet(
      {super.key, required this.txn, required this.token});

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white38),
          borderRadius: BorderRadius.circular(20),
          color: Palette.background,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () => showTokenTransactionBottomSheet(
                context: context,
                transaction: widget.txn,
                token: widget.token,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.token.logo_url,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text('From ${shortAddress(widget.txn.from_address)}'),
              subtitle: Text((widget.txn.value_quote ?? 0).toStringAsFixed(6)),
              trailing: InkWell(
                onTap: () {},
                child: const Icon(Icons.more_horiz_outlined),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$ ',
                        style: inter.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        (widget.txn.value_quote ?? 0).toStringAsFixed(4),
                        style: inter.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Consumer(builder: (context, ref, c) {
                    final chain = ref.watch(currentSelectedTokenChain);
                    return Text(
                      chain.coinSymbol,
                      style: inter.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    );
                  })
                ],
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Palette.primary),
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xff16324c),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.task_alt_rounded),
                  Text(
                    'Completed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.info),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Consumer(builder: (context, ref, child) {
                    final account = ref.watch(
                        accountProvider.select((value) => value.address));
                    bool sent = widget.txn.from_address == account;
                    return StatTileWidget(
                      title: sent ? 'To' : 'From',
                      value: sent
                          ? shortAddress(widget.txn.to_address)
                          : shortAddress(widget.txn.from_address),
                      icon: Icons.wallet,
                    );
                  }),
                  Consumer(builder: (context, ref, child) {
                    return StatTileWidget(
                      title: 'Network',
                      value: ref.watch(currentNetworkChainProvider).name,
                      icon: Icons.compare_arrows,
                    );
                  }),
                  StatTileWidget(
                    title: 'Network Fee',
                    value: widget.txn.gas_price.toString(),
                    icon: Icons.feed,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xff16324c),
              ),
              child: InkWell(
                onTap: () async {
                  final directory = await getApplicationDocumentsDirectory();
                  final path = await controller.captureAndSave(directory.path,
                      fileName: 'avex.png');
                  Share.shareXFiles([XFile(path!)]);
                },
                child: const Center(
                  child: Text(
                    'Share Receipt',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
