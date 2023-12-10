import 'package:avex_mobile/core/themes/themes.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(top: 20),
      child: Text(
        label,
        style: inter.copyWith(
          color: const Color.fromARGB(255, 47, 154, 190),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
