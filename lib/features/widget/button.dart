import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends ConsumerWidget {
  const CustomButton({
    required this.title,
    required this.onClick,
    this.isLoading = false,
    super.key,
  });
  final Function onClick;
  final String title;
  final bool isLoading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: const Color(0xFF2C83A0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () => {onClick()},
      child: (isLoading)
          ? const SizedBox.square(
              dimension: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : Text(
              title,
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }
}
