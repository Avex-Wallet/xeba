// ignore_for_file: depend_on_referenced_packages, unused_element, use_build_context_synchronously

import 'package:bip32_ed25519/bip32_ed25519.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/auth/seed_saving/cloud_key_save.dart';
import 'package:avex_mobile/features/auth/seed_saving/seed_saving_state_notifier.dart';
import 'package:avex_mobile/features/widget/button.dart';

class SeedSavingScreen extends ConsumerStatefulWidget {
  const SeedSavingScreen(
      {super.key,
      required this.driveKey,
      required this.qrKey,
      required this.edwardsKey});
  final String driveKey;
  final String qrKey;
  final ExtendedSigningKey edwardsKey;

  @override
  ConsumerState<SeedSavingScreen> createState() => _SeedSavingScreenState();
}

class _SeedSavingScreenState extends ConsumerState<SeedSavingScreen> {
  late final String driveKey;
  late final String qrKey;
  late final ExtendedSigningKey edwardsKey;

  @override
  void initState() {
    driveKey = widget.driveKey;
    qrKey = widget.qrKey;
    edwardsKey = widget.edwardsKey;
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

    final state = ref.watch(seedSavingStateNotifierProvider);
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
                    "Setup Seedless Recovery",
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
                child:
                    Text("To backup your wallet complete all the steps below"),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: const Color(0xFF33BB7A),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Text(
                          "${((state.driveUploadSuccessful && state.qrCodeSuccessful) ? 2 : ((state.driveUploadSuccessful || state.qrCodeSuccessful) ? 1 : 0))} of 2 completed",
                          style: GoogleFonts.inter(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              // for (int i = 0; i < 3; i++)
              GestureDetector(
                onTap: () {
                  showCloudKeyBackup(
                    context: context,
                    driveKey: driveKey,
                    edwardsKey: edwardsKey,
                  );
                },
                child: Card(
                    color: (!state.driveUploadSuccessful)
                        ? const Color(0xFF222529)
                        : Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (!state.driveUploadSuccessful)
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
                                child: (state.driveUploadSuccessful)
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF2C83A0),
                                      )
                                    : const Icon(Icons.lock),
                              ),
                            ),
                            if (state.driveUploadLoading)
                              const SizedBox.square(
                                  dimension: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF2C83A0),
                                  ))
                          ]),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text((state.driveUploadSuccessful)
                                ? "Stored Successfully"
                                : "Cloud Key"),
                            subtitle: Text((state.driveUploadSuccessful)
                                ? "Your cloud key has been successfully stored on your Cloud Drive in a Folder named AVEX_DO_NOT_DELETE"
                                : "Securely store the cloud key on your Google Drive"),
                          ),
                        )
                      ]),
                    )),
              ),
              GestureDetector(
                onTap: () => makeQRDialog(context, qrKey, () {
                  ref
                      .read(seedSavingStateNotifierProvider.notifier)
                      .onQrSuccessfullyShared();
                }),
                child: Card(
                    color: (!state.qrCodeSuccessful)
                        ? const Color(0xFF222529)
                        : Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (!state.qrCodeSuccessful)
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
                                child: (state.qrCodeSuccessful)
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF2C83A0),
                                      )
                                    : const Icon(Icons.launch),
                              ),
                            ),
                            if (state.qrCodeLoading)
                              const SizedBox.square(
                                  dimension: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF2C83A0),
                                  ))
                          ]),
                        ),
                        const Expanded(
                          child: ListTile(
                            title: Text("Social Key"),
                            subtitle: Text(
                                "Use QR Code to share social key with your trusted contacts"),
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
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                onClick: () async {
                  // restart();
                  CreateUsernameScreenRoute().push(context);
                },
                // onClick: () => {
                //   context.goNamed('mainrouter');
                //   // AutoRouter.of(context).pushAndPopUntil(MainRouter(),
                //   //     predicate: (route) => false)
                //   // ref.read(seedSavingStateNotifierProvider.notifier).moveToNextScreen()
                // },
                title: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void makeQRDialog(BuildContext context, String link, Function onSuccess) {
    onSuccess();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //the rounded corner is created here
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 4,
                    width: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Share this social key image with trusted contacts",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                      width: 200,
                      color: Colors.white,
                      child: QrImageView(data: link)
                      // QrImage(data: link),
                      ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    title: "Share",
                    onClick: () async {
                      final screenShotController = ScreenshotController();
                      final bytes =
                          await screenShotController.captureFromWidget(Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            DateTime.now().toString(),
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                              width: 200,
                              color: Colors.white,
                              child: QrImageView(data: link)),
                        ],
                      ));
                      await Share.shareXFiles(
                        [
                          XFile.fromData(
                            bytes,
                            name: 'share.png',
                            mimeType: 'image/png',
                          ),
                        ],
                      );
                    },
                    isLoading: false,
                  )
                ],
              ),
            ),
          );
        });
  }
}
