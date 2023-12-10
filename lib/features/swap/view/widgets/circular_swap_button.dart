// ignore_for_file: use_build_context_synchronously

import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircularSwapButton extends ConsumerWidget {
  const CircularSwapButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: false,
      child: CircleAvatar(
        backgroundColor: Palette.primary,
        radius: 18,
        child: InkWell(
          onTap: () async {
            // showSnackBar(context, 'Under Development');
          },
          child: const RotatedBox(
            quarterTurns: 1,
            // quarterTurns: 0,
            child: Icon(
              Icons.compare_arrows_rounded,
              // Icons.arrow_downward,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
