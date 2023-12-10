import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';

class ValidationIndicator extends StatelessWidget {
  const ValidationIndicator(
      {super.key, required this.label, required this.valid});
  final String label;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      child: Row(
        children: [
          Icon(
            Icons.task_alt_outlined,
            color: valid ? Colors.green.shade400 : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: inter.copyWith(
              color: valid ? Colors.green.shade400 : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
