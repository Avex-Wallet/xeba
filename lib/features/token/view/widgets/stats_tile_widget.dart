import 'package:flutter/material.dart';

import 'package:avex_mobile/core/themes/app_theme.dart';

class StatTileWidget extends StatelessWidget {
  const StatTileWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      visualDensity: const VisualDensity(vertical: -4),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: inter.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: Text(
        value,
        style: inter.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
