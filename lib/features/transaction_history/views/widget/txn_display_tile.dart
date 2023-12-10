import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/transaction_history/views/screens/txn_detail_screen.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxnDisplayTitle extends ConsumerWidget {
  const TxnDisplayTitle({super.key, required this.txn});
  final TokenTransactionModel txn;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(accountProvider.select((value) => value.address));
    final chain =
        NetworkChain.values.firstWhere((i) => i.chainId == txn.chain_id);
    final bool sent = txn.from_address == address;
    final time = DateTime.parse(txn.block_signed_at!).toLocal();
    final timeFormat =
        time.toString().substring(0, time.toString().indexOf(" "));
    final secFormat = time.toString().substring(
        time.toString().indexOf(" "), time.toString().lastIndexOf('.'));
    return ListTile(
      dense: true,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TxnDetailScreen(txnData: txn),
        ),
      ),
      leading: SizedBox.square(
        dimension: 40,
        child: Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: sent ? Colors.red : Palette.primary),
              ),
              child: Icon(
                sent ? Icons.call_made_rounded : Icons.call_received_sharp,
                size: 20,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: NetworkAvatar(
                dimension: 18,
                chain: chain,
              ),
            )
          ],
        ),
      ),
      title: Row(
        children: [
          Text(sent ? 'Sent to ' : 'Received from '),
          Text(
            shortAddress(sent ? txn.to_address : txn.from_address),
            style: const TextStyle(color: Colors.white70),
          )
        ],
      ),
      subtitle: Text('${shortAddress(txn.tx_hash)}  › $secFormat'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(txn.pretty_value_quote ?? '\$ 0'),
          const SizedBox(height: 4),
          Text(timeFormat,
              style: const TextStyle(color: Colors.white60, fontSize: 12)),
        ],
      ),
    );
  }
}
