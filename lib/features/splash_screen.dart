// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:async';

import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/provider/connectivity_provider.dart';
import 'package:avex_mobile/services/local_services/shared_pref/shared_pref.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/config/config.dart';
import 'package:avex_mobile/core/assets/assets.gen.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/provider/isar_provider.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:avex_mobile/services/user/user_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late StreamSubscription dynamicLinkStreamSubscription;
  @override
  void initState() {
    super.initState();
    String code = '';
    dynamicLinkStreamSubscription =
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParameter = uri.queryParameters;
      if (queryParameter.isNotEmpty &&
          dynamicLinkData.link.path == "/signup/") {
        String authCode = queryParameter["userAuthenticationCode"].toString();
        onAuthDynamicLink(authCode);
      }
    });
    checkForAuth();
  }

  @override
  void dispose() {
    dynamicLinkStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.logoPng.image(
          height: 100,
          width: 100,
        ),
      ),
    );
  }

  void checkForAuth() async {
    await checkForAuthStatus() ? onAuthSuccess() : onAuthFailure();
  }

  void onAuthFailure() {
    if (mounted) {
      SignupScreenRoute().go(context);
    }
  }

  void onAuthSuccess() {
    if (mounted) MainRoute().go(context);
  }

  void onAuthDynamicLink(String authId) {
    if (mounted) {
      DynamicLinkProccessingScreenRoute($extra: authId).go(context);
    }
  }

  Future<bool> checkForAuthStatus() async {
    ref.read(connectivityProvider);
    await ref.read(sharedPref).init();
    try {
      await ref.read(isarProvider.future);
    } catch (e) {
      logger.e('Isar Error: $e');
    }
    final seedPhase = await SecureStorage.seedPhase.value;
    logger.f(seedPhase);
    if (seedPhase.isNotEmpty) {
      UserServiceHelper().refreshTokenRequest(ref, context);
      // final flag = await UserServiceHelper().refreshTokenRequest(ref, context);
      // if (!flag && false) {
      //   final isar = await ref.read(isarProvider.future);
      //   await ref.read(sharedPref).wipeData();
      //   await flutterSecureStorage.deleteAll();
      //   await isar.writeTxn(() async {
      //     await isar.clear();
      //   });
      //   return false;
      // }
      ref.read(accountProvider);
    }
    return seedPhase.isNotEmpty;
  }
}
