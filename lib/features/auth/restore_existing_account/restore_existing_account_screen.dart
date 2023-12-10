import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/features/auth/restore_existing_account/restore_existing_account_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/button.dart';

class RestoreExistingAccountScreen extends ConsumerWidget {
  const RestoreExistingAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        restoreExistingAccountStateNotifierProvider.select((_) => _.status),
        (previous, next) {
      if (next == RestoreExistingAccountStateNotifierStatus.error) {
        final errorMessage = ref.read(
                restoreExistingAccountStateNotifierProvider
                    .select((value) => value.errorMessage)) ??
            "Unknown Error";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          duration: const Duration(milliseconds: 300),
        ));
      } else if (next == RestoreExistingAccountStateNotifierStatus.loaded) {
        final state = ref.read(restoreExistingAccountStateNotifierProvider);
        final driveKey = state.driveKey;
        final qrKey = state.qrKey;
        SeedSavingScreenRoute(SeedExtra(
          driveKey: driveKey!,
          qrKey: qrKey!,
          edwardsKey: state.edwardsKey!,
        )).go(context);
      }
    });
    final state = ref.watch(restoreExistingAccountStateNotifierProvider
        .select((value) => value.status));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  Text(
                    "Restore existing wallet",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                    "To import an existing wallet,enter your seedphase below"),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    "Enter your seed phrase here",
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                onChanged: (text) {
                  ref
                      .read(
                          restoreExistingAccountStateNotifierProvider.notifier)
                      .inputSeedPhrase(text);
                },
                autofocus: false,
                style:
                    const TextStyle(fontSize: 17.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF25252D),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Expanded(child: Container()),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                isLoading:
                    state == RestoreExistingAccountStateNotifierStatus.loading,
                onClick: () => {
                  ref
                      .read(
                          restoreExistingAccountStateNotifierProvider.notifier)
                      .onSeedPhraseSubmitted()
                },
                title: "Import Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
