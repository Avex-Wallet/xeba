import 'package:avex_mobile/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/button.dart';

class RecoverAccountScreen extends ConsumerStatefulWidget {
  const RecoverAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecoverAccountScreenState();
}

class _RecoverAccountScreenState extends ConsumerState<RecoverAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2C83A0),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    size: 62,
                    Icons.wallet,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Recover your account",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Text(
                "The email k16.deepak@proton.me is associated with an existing account that was backed up.",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Expanded(child: Container()),
              CustomButton(
                  onClick: () => SeedRecoveryScreenRoute().go(context),
                  // {AutoRouter.of(context).push(SeedRecoveryRoute())},
                  title: "Get Started",
                  isLoading: false),
            ],
          ),
        ),
      ),
    );
  }
}
