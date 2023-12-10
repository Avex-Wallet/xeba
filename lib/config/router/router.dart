// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, duplicate_ignore
// ignore: depend_on_referenced_packages
import 'package:avex_mobile/config/config.dart';
import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/dapp_browser/views/dapp_browser.dart';
import 'package:avex_mobile/features/home/dashboard.dart';
import 'package:bip32_ed25519/bip32_ed25519.dart' show ExtendedSigningKey;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/accounts/view/view_more_account_page.dart';
import 'package:avex_mobile/features/auth/dynamic_link_proceessing/dynamic_link_processing_screen.dart';
import 'package:avex_mobile/features/auth/onboarding_screen.dart';
import 'package:avex_mobile/features/auth/restore_existing_account/restore_existing_account_screen.dart';
import 'package:avex_mobile/features/auth/seed_recovery/seed_recovery_screen.dart';
import 'package:avex_mobile/features/auth/seed_saving/seed_saving_screen.dart';
import 'package:avex_mobile/features/auth/setup_or_import_account/setup_or_import_new_account.dart';
import 'package:avex_mobile/features/auth/signup/signup_screen.dart';
import 'package:avex_mobile/features/auth/username/views/screens/create_username_screen.dart';
import 'package:avex_mobile/features/connected_app/main.dart';
import 'package:avex_mobile/features/home/bottom_navbar/home.dart';
import 'package:avex_mobile/features/inapp_webview/inapp_webview.dart';
import 'package:avex_mobile/features/nft/views/screens/nft_screen.dart';
import 'package:avex_mobile/features/send_nft/view/send_nft_screen.dart';
import 'package:avex_mobile/features/send_transaction/models/txn.model.dart';
import 'package:avex_mobile/features/send_transaction/views/pages/loading_transaction.dart';
import 'package:avex_mobile/features/send_transaction/views/pages/review_your_transaction.dart';
import 'package:avex_mobile/features/send_transaction/views/pages/send_transaction.dart';
import 'package:avex_mobile/features/splash_screen.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';
import 'package:avex_mobile/features/swap/view/pages/swaptxn_process_screen.dart';
import 'package:avex_mobile/features/token/view/pages/token_detail_screen.dart';
import 'package:avex_mobile/features/transaction_history/views/screens/transaction_history_screen.dart';
import 'package:avex_mobile/features/widget/qr_screen.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart';
import 'package:avex_mobile/services/local_services/shared_pref/shared_pref.dart';

export 'package:go_router/go_router.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    navigatorKey: rootNavigatorKey,
    routes: [
      ...$appRoutes,
    ],
    redirect: (context, state) async {
      if (!kProductionMode) {
        logger.d('Route => ${state.uri.path}');
      }
      if (state.uri.path.startsWith("/splash")) {
        ref.read(sharedPref);
      } else if (!ref.read(accountProvider.notifier).isInitialized) {
        ref.read(accountListProvider);
        await ref.read(accountProvider.notifier).init();
      }
      return;
    },
  ),
);

@TypedGoRoute<SplashScreenRoute>(path: '/splash')
class SplashScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SplashScreen();
}

@TypedGoRoute<SignupScreenRoute>(path: '/signup', name: 'signup')
class SignupScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignupScreen();
}

/// Extra: String AuthToken
@TypedGoRoute<DynamicLinkProccessingScreenRoute>(
    path: '/dynamic-link-processing')
class DynamicLinkProccessingScreenRoute extends GoRouteData {
  final String $extra;
  DynamicLinkProccessingScreenRoute({required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DynamicLinkProcessingScreen(authToken: $extra);
}

@TypedGoRoute<SwapScreenRoute>(path: '/swap', name: 'swap')
class SwapScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SwapScreen();
}

@TypedGoRoute<QrScreenRoute>(path: '/qr')
class QrScreenRoute extends GoRouteData {
  final String? title;
  QrScreenRoute({this.title});

  @override
  Widget build(context, state) => QrScreen(title: title);
}

// @TypedGoRoute<MainRoute>(path: '/main', name: 'main')
class MainRoute extends GoRouteData {
  @override
  Widget build(context, state) => const DashboardScreen();
}

@TypedGoRoute<OnboardingScreenRoute>(
    path: '/confirm-email', name: 'Confirm-Email')
class OnboardingScreenRoute extends GoRouteData {
  final String $extra;
  OnboardingScreenRoute(this.$extra);
  @override
  Widget build(context, state) => OnboardingScreen(email: $extra);
}

@TypedGoRoute<ViewMoreAccountsRoute>(path: '/accounts')
class ViewMoreAccountsRoute extends GoRouteData {
  @override
  Widget build(context, state) => const ViewMoreAccountScreen();
}

@TypedGoRoute<CreateUsernameScreenRoute>(path: '/create-username')
class CreateUsernameScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const CreateUsernameScreen();
}

@TypedGoRoute<ConnectedAppScreenRoute>(path: '/wallet-connect')
class ConnectedAppScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => ConnectedAppScreen();
}

@TypedGoRoute<TransactionHistoryRoute>(
    path: '/notification', name: 'notification')
class TransactionHistoryRoute extends GoRouteData {
  @override
  Widget build(context, state) => const TransactionHistory();
}

@TypedGoRoute<SetupOrImportNewAccountScreenRoute>(
    path: '/setupOrImportNewAccountScreen')
class SetupOrImportNewAccountScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SetupOrImportNewAccountScreen();
}

@TypedGoRoute<SeedRecoveryScreenRoute>(path: '/seed-recovery')
class SeedRecoveryScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SeedRecoveryScreen();
}

@TypedGoRoute<RestoreExistingAccountScreenRoute>(
    path: '/restoreExistingAccount')
class RestoreExistingAccountScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const RestoreExistingAccountScreen();
}

@TypedGoRoute<NFTScreenRoute>(path: '/nft/:contract/:tokenId')
class NFTScreenRoute extends GoRouteData {
  final String contract;
  final String tokenId;
  final NFTModel $extra;
  NFTScreenRoute({
    required this.$extra,
    required this.contract,
    required this.tokenId,
  });
  @override
  Widget build(context, state) => NFTScreen(data: $extra);
}

@TypedGoRoute<SwapTxnProcessScreenRoute>(path: '/swap/transaction')
class SwapTxnProcessScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SwapTxnProcessScreen();
}

@TypedGoRoute<DynamicLinkProcessingScreenRoute>(
    path: '/dynamic-link-processing')
class DynamicLinkProcessingScreenRoute extends GoRouteData {
  final String $extra;
  DynamicLinkProcessingScreenRoute({required this.$extra});
  @override
  Widget build(context, state) =>
      DynamicLinkProcessingScreen(authToken: $extra);
}

@TypedGoRoute<TokenDetailScreenRoute>(path: '/token/:address')
class TokenDetailScreenRoute extends GoRouteData {
  final String address;
  final TokenModel $extra;
  TokenDetailScreenRoute({
    required this.$extra,
    required this.address,
  });
  @override
  Widget build(context, state) => TokenDetailScreen(token: $extra);
}

@TypedGoRoute<SeedSavingScreenRoute>(path: '/seed-saving')
class SeedSavingScreenRoute extends GoRouteData {
  SeedExtra $extra;
  SeedSavingScreenRoute(this.$extra);
  @override
  Widget build(context, state) => SeedSavingScreen(
        driveKey: $extra.driveKey,
        qrKey: $extra.qrKey,
        edwardsKey: $extra.edwardsKey,
      );
}

class SeedExtra {
  String driveKey;
  String qrKey;
  ExtendedSigningKey edwardsKey;
  SeedExtra({
    required this.driveKey,
    required this.qrKey,
    required this.edwardsKey,
  });
}

@TypedGoRoute<SendNFTScreenRoute>(path: '/send/nft', name: 'send-nft')
class SendNFTScreenRoute extends GoRouteData {
  final NFTModel $extra;
  SendNFTScreenRoute(this.$extra);
  @override
  Widget build(context, state) => SendNFTScreen(nftData: $extra);
}

@TypedGoRoute<InAppWebviewRoute>(path: '/webview/:title')
class InAppWebviewRoute extends GoRouteData {
  final String $extra;
  final String title;
  InAppWebviewRoute({required this.$extra, required this.title});
  @override
  Widget build(context, state) => InAppWebview(
        url: $extra,
        title: title,
      );
}

@TypedGoRoute<SendTransactionScreenRoute>(
  path: '/send',
  routes: [
    TypedGoRoute<ReviewYourTransactionRoute>(
      path: 'txn',
      routes: [
        TypedGoRoute<ProcessingTransactionRoute>(path: 'sending'),
      ],
    ),
  ],
)
class SendTransactionScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SendTransactionScreen();
}

class ReviewYourTransactionRoute extends GoRouteData {
  final Txn $extra;
  ReviewYourTransactionRoute(this.$extra);
  @override
  Widget build(context, state) => ReviewYourTransaction(txn: $extra);
}

class ProcessingTransactionRoute extends GoRouteData {
  @override
  Widget build(context, state) => const LoadingTransaction();
}

@TypedShellRoute<HomeBuilder>(
  routes: [
    TypedGoRoute<DappBrowserRoute>(path: '/browser'),
    TypedGoRoute<DashboardShellRoute1>(path: '/message'),
    TypedGoRoute<MainRoute>(path: '/main', name: 'main'),
    TypedGoRoute<AncientHistoryShellRoute>(path: '/history'),
    TypedGoRoute<DashboardShellRoute2>(path: '/setting'),
  ],
)
class HomeBuilder extends ShellRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;
  @override
  Widget builder(context, state, navigator) {
    return HomePage(navigator);
  }
}

class DappBrowserRoute extends GoRouteData {
  @override
  Widget build(context, state) => const DappBrowser();
}

class DashboardShellRoute1 extends GoRouteData {
  @override
  Widget build(context, state) => const DashboardScreen();
}

class DashboardShellRoute2 extends GoRouteData {
  @override
  Widget build(context, state) => const DashboardScreen();
}

class AncientHistoryShellRoute extends GoRouteData {
  @override
  Widget build(context, state) => const TransactionHistory();
}
