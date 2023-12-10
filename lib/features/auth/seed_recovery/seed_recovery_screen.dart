// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/auth/seed_recovery/cloud_key_option.dart';
import 'package:avex_mobile/features/auth/seed_recovery/seed_recovery_state_notifier.dart';

class SeedRecoveryScreen extends ConsumerStatefulWidget {
  const SeedRecoveryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SeedRecoveryScreenState();
}

class _SeedRecoveryScreenState extends ConsumerState<SeedRecoveryScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await Dropbox.unlink();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> restart() async {
      showSnackBar(context, 'Loading! Please Wait...');
      ref.read(accountProvider);
      await ref.read(accountProvider.notifier).init();
      MainRoute().go(context);
    }

    SeedRecoveryStateNotifierStatus status = ref.watch(
        seedRecoveryStateNotifierProvider.select((value) => value.status));
    ref.listen(seedRecoveryStateNotifierProvider.select((_) => _.status),
        (previous, next) {
      if (next == SeedRecoveryStateNotifierStatus.error) {
        final errorMessage = ref.read(seedRecoveryStateNotifierProvider
                .select((value) => value.errorMessage)) ??
            "Unknown Error";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          duration: const Duration(milliseconds: 300),
        ));
      } else if (next == SeedRecoveryStateNotifierStatus.loaded) {
        restart();
        // context.goNamed(RouterConstant.splashPage.name);
      }
    });

    final state = ref.watch(seedRecoveryStateNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Getting Your Data From Seedless Recovery",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                        "Please click on each individual options till we recover your data."),
                  ),
                  Expanded(child: Container()),
                  // for (int i = 0; i < 3; i++)
                  GestureDetector(
                    onTap: () {
                      showCloudKeyBackupRecovery(context: context);
                      // ref
                      //     .read(seedRecoveryStateNotifierProvider.notifier)
                      //     .driveRecovery();
                    },
                    child: Card(
                        color: (!state.driveKeySubmitted)
                            ? const Color(0xFF222529)
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: (!state.driveKeySubmitted)
                                    ? Colors.transparent
                                    : const Color(0xFF222529),
                                width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                          child: Row(children: [
                            SizedBox.square(
                              dimension: 28,
                              child: Stack(children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: (state.driveKeySubmitted)
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Color(0xFF2C83A0),
                                          )
                                        : const Icon(Icons.lock),
                                  ),
                                ),
                              ]),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text((state.driveKeySubmitted)
                                    ? "Restored Successfully"
                                    : "Cloud Key"),
                                subtitle: Text((state.driveKeySubmitted)
                                    ? "Your cloud key has been successfully restored on your Google Drive in a Folder named AVEX_DO_NOT_DELETE"
                                    : "Securely store the cloud key on your Google Drive"),
                              ),
                            )
                          ]),
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result =
                          await QrScreenRoute(title: 'Social Key Recovery')
                              .push(context);
                      ref
                          .read(seedRecoveryStateNotifierProvider.notifier)
                          .onSubmitQrCode(result.toString());
                    },
                    child: Card(
                        color: (!state.qrKeySubmitted)
                            ? const Color(0xFF222529)
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: (!state.qrKeySubmitted)
                                    ? Colors.transparent
                                    : const Color(0xFF222529),
                                width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                          child: Row(children: [
                            SizedBox.square(
                              dimension: 28,
                              child: Stack(children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: (state.qrKeySubmitted)
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Color(0xFF2C83A0),
                                          )
                                        : const Icon(Icons.launch),
                                  ),
                                ),
                              ]),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text((state.qrKeySubmitted)
                                    ? "Restored Successfully"
                                    : "Social Key"),
                                subtitle: Text((state.qrKeySubmitted)
                                    ? "Your cloud key has been successfully restored from your QR."
                                    : "Use QR Code to share social key with your trusted contacts"),
                              ),
                            )
                          ]),
                        )),
                  ),
                  Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      color: const Color(0xFF222529),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Row(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: const Icon(Icons.face),
                          ),
                          const Expanded(
                            child: ListTile(
                              title: Text("Signin with FaceID"),
                            ),
                          )
                        ]),
                      )),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Center(
              child: (status == SeedRecoveryStateNotifierStatus.loading)
                  ? const CircularProgressIndicator(
                      color: Color(0xFF2C83A0),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
