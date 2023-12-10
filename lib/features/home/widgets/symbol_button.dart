import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymbolButton extends StatelessWidget {
  const SymbolButton({required this.title, required this.icon, super.key});
  final String title;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            color: const Color(0xFF37CBFA),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: icon,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(title,
            style:
                GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w600))
      ],
    );
  }
}
