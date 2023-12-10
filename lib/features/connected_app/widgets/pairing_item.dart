// ignore_for_file: unused_import

import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class PairingItem extends StatelessWidget {
  const PairingItem({
    super.key,
    required this.pairing,
    required this.onTap,
  });

  final PairingInfo pairing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    PairingMetadata? metadata = pairing.peerMetadata;
    if (metadata == null) {
      return const ListTile(
        title: Text('Unknown'),
        subtitle: Text('No metadata available'),
      );
    }

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(pairing.expiry * 1000);
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    String expiryDate =
        '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      tileColor: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: CircleAvatar(
        backgroundImage: (metadata.icons.isNotEmpty
                ? NetworkImage(metadata.icons[0])
                : const AssetImage('assets/images/default_icon.png'))
            as ImageProvider<Object>,
      ),
      title: Text(metadata.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(metadata.url),
          Text('Expires on: $expiryDate'),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
      onTap: onTap,
    );
  }
}
