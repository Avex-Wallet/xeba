import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    required this.inter,
  });

  final String title;
  final TextStyle inter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Text(
          title,
          style: inter.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xff605E5E),
          ),
        ),
      ),
    );
  }
}
