import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/features/auth/signup/signup_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final status =
        ref.watch(signupStateNortifierProvider.select((value) => value.status));
    final opacitySignupButton = ref.watch(signupStateNortifierProvider
        .select((value) => value.signupButtonOpacity));
    ref.listen(signupStateNortifierProvider.select((value) => value.status),
        (prev, next) {
      if (next == SignupStateNotifierStatus.loaded) {
        final email = ref
            .read(signupStateNortifierProvider.select((value) => value.email));
        OnboardingScreenRoute(email).push(context);
        // AutoRouter.of(context).pushAndPopUntil(
        //     OnboardingRoute(email: email.toString()),
        //     predicate: (route) => false);
      } else if (next == SignupStateNotifierStatus.error) {
        final errorMessage = ref.read(
            signupStateNortifierProvider.select((value) => value.errorMessage));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text("Let's get Started!",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 24)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "An amazing web3 journey awaits",
                          style:
                              GoogleFonts.inter(color: const Color(0xFF626164)),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.15),
                    SvgPicture.asset("assets/logo.svg",
                        semanticsLabel: 'Acme Logo'),
                    SizedBox(height: screenHeight * 0.15),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      onChanged: (value) {
                        ref
                            .read(signupStateNortifierProvider.notifier)
                            .setEmail(value);
                      },
                      style: const TextStyle(
                          fontSize: 17.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF25252D),
                        hintText: 'Email',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        AnimatedOpacity(
                          opacity: 1 - opacitySignupButton,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.15 * 0.25),
                              const Text("Or continue with"),
                              SizedBox(height: screenHeight * 0.15 * 0.25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF25252D)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: SvgPicture.asset(
                                            "assets/google_logo.svg"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // AndroidGoogleDrivePlatformChannel
                                      // .uploadNewKeysInGDrive("file.txt",
                                      //     "this is content from file.txt");
                                      // AndroidGoogleDrivePlatformChannel.readFromGDrive("keys.txt");
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF25252D)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                            "assets/twitter_logo.svg"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF25252D)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                          "assets/fb_logo.svg"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: AnimatedOpacity(
                                  opacity: opacitySignupButton,
                                  duration: const Duration(milliseconds: 500),
                                  child: CustomButton(
                                      title: "Signup",
                                      onClick: () {
                                        ref
                                            .read(signupStateNortifierProvider
                                                .notifier)
                                            .signup();
                                      },
                                      isLoading: status ==
                                          SignupStateNotifierStatus.loading),
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
