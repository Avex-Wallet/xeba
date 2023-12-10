// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:async';

import 'package:avex_mobile/config/router/router.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_mail_app/open_mail_app.dart';
import '../../services/api_services/api_services.dart';
import '../widget/button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({required this.email, super.key});
  final String email;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late StreamSubscription dynamicLinkStreamSubscription;
  bool makeResendButtonVisible = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 1, seconds: 1);
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          setState(() {
            makeResendButtonVisible = true;
          });
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    String code = '';
    dynamicLinkStreamSubscription =
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParameter = uri.queryParameters;
      //debugprint(uri.toString());
      //debugprint(queryParameter.toString());
      if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == "/signup/") {
        String authCode = queryParameter["userAuthenticationCode"].toString();
        onAuthDynamicLink(authCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
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
                    Icons.mail,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Confirm you’re email",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Text(
                "Check your email on this device to verify your account",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Expanded(child: Container()),
              Stack(children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "You can resend in $seconds seconds",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        "Sent to ${widget.email}",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: const Color(0xFFDEDEDE)),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(microseconds: 200),
                  opacity: (makeResendButtonVisible) ? 1 : 0,
                  child: CustomButton(
                      onClick: () async {
                        final result = await ref
                            .read(apiServiceProvider)
                            .signupWithDynamicLink(widget.email);
                        if (result.errorMessage != null &&
                            result.errorMessage!.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(result.errorMessage.toString())));
                        }
                      },
                      title: "Resend the email.",
                      isLoading: false),
                ),
              ]),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                  onClick: () async {
                    // AutoRouter.of(context).push(SeedRecoveryRoute())
                    var result = await OpenMailApp.openMailApp(
                      nativePickerTitle: 'Select email app to open',
                    );

                    // If no mail apps found, show error
                    if (!result.didOpen && !result.canOpen) {
                      showNoMailAppsDialog(context);

                      // iOS: if multiple mail apps found, show dialog to select.
                      // There is no native intent/default app system in iOS so
                      // you have to do it yourself.
                    } else if (!result.didOpen && result.canOpen) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(
                            mailApps: result.options,
                          );
                        },
                      );
                    }
                  },
                  title: "Open My Email",
                  isLoading: false),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    dynamicLinkStreamSubscription.cancel();
    super.dispose();
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void onAuthDynamicLink(String authId) {
    if (mounted) {
      DynamicLinkProcessingScreenRoute($extra: authId).go(context);
    }
    // AutoRouter.of(context)
    //     .replace(DynamicLinkProcessingRoute(authToken: authId));
  }
}
