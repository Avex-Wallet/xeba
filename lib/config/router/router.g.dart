// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashScreenRoute,
      $signupScreenRoute,
      $dynamicLinkProccessingScreenRoute,
      $swapScreenRoute,
      $qrScreenRoute,
      $onboardingScreenRoute,
      $viewMoreAccountsRoute,
      $createUsernameScreenRoute,
      $connectedAppScreenRoute,
      $transactionHistoryRoute,
      $setupOrImportNewAccountScreenRoute,
      $seedRecoveryScreenRoute,
      $restoreExistingAccountScreenRoute,
      $nFTScreenRoute,
      $swapTxnProcessScreenRoute,
      $dynamicLinkProcessingScreenRoute,
      $tokenDetailScreenRoute,
      $seedSavingScreenRoute,
      $sendNFTScreenRoute,
      $inAppWebviewRoute,
      $sendTransactionScreenRoute,
      $homeBuilder,
    ];

RouteBase get $splashScreenRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashScreenRouteExtension._fromState,
    );

extension $SplashScreenRouteExtension on SplashScreenRoute {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      SplashScreenRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupScreenRoute => GoRouteData.$route(
      path: '/signup',
      name: 'signup',
      factory: $SignupScreenRouteExtension._fromState,
    );

extension $SignupScreenRouteExtension on SignupScreenRoute {
  static SignupScreenRoute _fromState(GoRouterState state) =>
      SignupScreenRoute();

  String get location => GoRouteData.$location(
        '/signup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dynamicLinkProccessingScreenRoute => GoRouteData.$route(
      path: '/dynamic-link-processing',
      factory: $DynamicLinkProccessingScreenRouteExtension._fromState,
    );

extension $DynamicLinkProccessingScreenRouteExtension
    on DynamicLinkProccessingScreenRoute {
  static DynamicLinkProccessingScreenRoute _fromState(GoRouterState state) =>
      DynamicLinkProccessingScreenRoute(
        $extra: state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/dynamic-link-processing',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $swapScreenRoute => GoRouteData.$route(
      path: '/swap',
      name: 'swap',
      factory: $SwapScreenRouteExtension._fromState,
    );

extension $SwapScreenRouteExtension on SwapScreenRoute {
  static SwapScreenRoute _fromState(GoRouterState state) => SwapScreenRoute();

  String get location => GoRouteData.$location(
        '/swap',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qrScreenRoute => GoRouteData.$route(
      path: '/qr',
      factory: $QrScreenRouteExtension._fromState,
    );

extension $QrScreenRouteExtension on QrScreenRoute {
  static QrScreenRoute _fromState(GoRouterState state) => QrScreenRoute(
        title: state.uri.queryParameters['title'],
      );

  String get location => GoRouteData.$location(
        '/qr',
        queryParams: {
          if (title != null) 'title': title,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingScreenRoute => GoRouteData.$route(
      path: '/confirm-email',
      name: 'Confirm-Email',
      factory: $OnboardingScreenRouteExtension._fromState,
    );

extension $OnboardingScreenRouteExtension on OnboardingScreenRoute {
  static OnboardingScreenRoute _fromState(GoRouterState state) =>
      OnboardingScreenRoute(
        state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/confirm-email',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $viewMoreAccountsRoute => GoRouteData.$route(
      path: '/accounts',
      factory: $ViewMoreAccountsRouteExtension._fromState,
    );

extension $ViewMoreAccountsRouteExtension on ViewMoreAccountsRoute {
  static ViewMoreAccountsRoute _fromState(GoRouterState state) =>
      ViewMoreAccountsRoute();

  String get location => GoRouteData.$location(
        '/accounts',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createUsernameScreenRoute => GoRouteData.$route(
      path: '/create-username',
      factory: $CreateUsernameScreenRouteExtension._fromState,
    );

extension $CreateUsernameScreenRouteExtension on CreateUsernameScreenRoute {
  static CreateUsernameScreenRoute _fromState(GoRouterState state) =>
      CreateUsernameScreenRoute();

  String get location => GoRouteData.$location(
        '/create-username',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $connectedAppScreenRoute => GoRouteData.$route(
      path: '/wallet-connect',
      factory: $ConnectedAppScreenRouteExtension._fromState,
    );

extension $ConnectedAppScreenRouteExtension on ConnectedAppScreenRoute {
  static ConnectedAppScreenRoute _fromState(GoRouterState state) =>
      ConnectedAppScreenRoute();

  String get location => GoRouteData.$location(
        '/wallet-connect',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transactionHistoryRoute => GoRouteData.$route(
      path: '/notification',
      name: 'notification',
      factory: $TransactionHistoryRouteExtension._fromState,
    );

extension $TransactionHistoryRouteExtension on TransactionHistoryRoute {
  static TransactionHistoryRoute _fromState(GoRouterState state) =>
      TransactionHistoryRoute();

  String get location => GoRouteData.$location(
        '/notification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $setupOrImportNewAccountScreenRoute => GoRouteData.$route(
      path: '/setupOrImportNewAccountScreen',
      factory: $SetupOrImportNewAccountScreenRouteExtension._fromState,
    );

extension $SetupOrImportNewAccountScreenRouteExtension
    on SetupOrImportNewAccountScreenRoute {
  static SetupOrImportNewAccountScreenRoute _fromState(GoRouterState state) =>
      SetupOrImportNewAccountScreenRoute();

  String get location => GoRouteData.$location(
        '/setupOrImportNewAccountScreen',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $seedRecoveryScreenRoute => GoRouteData.$route(
      path: '/seed-recovery',
      factory: $SeedRecoveryScreenRouteExtension._fromState,
    );

extension $SeedRecoveryScreenRouteExtension on SeedRecoveryScreenRoute {
  static SeedRecoveryScreenRoute _fromState(GoRouterState state) =>
      SeedRecoveryScreenRoute();

  String get location => GoRouteData.$location(
        '/seed-recovery',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $restoreExistingAccountScreenRoute => GoRouteData.$route(
      path: '/restoreExistingAccount',
      factory: $RestoreExistingAccountScreenRouteExtension._fromState,
    );

extension $RestoreExistingAccountScreenRouteExtension
    on RestoreExistingAccountScreenRoute {
  static RestoreExistingAccountScreenRoute _fromState(GoRouterState state) =>
      RestoreExistingAccountScreenRoute();

  String get location => GoRouteData.$location(
        '/restoreExistingAccount',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $nFTScreenRoute => GoRouteData.$route(
      path: '/nft/:contract/:tokenId',
      factory: $NFTScreenRouteExtension._fromState,
    );

extension $NFTScreenRouteExtension on NFTScreenRoute {
  static NFTScreenRoute _fromState(GoRouterState state) => NFTScreenRoute(
        contract: state.pathParameters['contract']!,
        tokenId: state.pathParameters['tokenId']!,
        $extra: state.extra as NFTModel,
      );

  String get location => GoRouteData.$location(
        '/nft/${Uri.encodeComponent(contract)}/${Uri.encodeComponent(tokenId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $swapTxnProcessScreenRoute => GoRouteData.$route(
      path: '/swap/transaction',
      factory: $SwapTxnProcessScreenRouteExtension._fromState,
    );

extension $SwapTxnProcessScreenRouteExtension on SwapTxnProcessScreenRoute {
  static SwapTxnProcessScreenRoute _fromState(GoRouterState state) =>
      SwapTxnProcessScreenRoute();

  String get location => GoRouteData.$location(
        '/swap/transaction',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dynamicLinkProcessingScreenRoute => GoRouteData.$route(
      path: '/dynamic-link-processing',
      factory: $DynamicLinkProcessingScreenRouteExtension._fromState,
    );

extension $DynamicLinkProcessingScreenRouteExtension
    on DynamicLinkProcessingScreenRoute {
  static DynamicLinkProcessingScreenRoute _fromState(GoRouterState state) =>
      DynamicLinkProcessingScreenRoute(
        $extra: state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/dynamic-link-processing',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $tokenDetailScreenRoute => GoRouteData.$route(
      path: '/token/:address',
      factory: $TokenDetailScreenRouteExtension._fromState,
    );

extension $TokenDetailScreenRouteExtension on TokenDetailScreenRoute {
  static TokenDetailScreenRoute _fromState(GoRouterState state) =>
      TokenDetailScreenRoute(
        address: state.pathParameters['address']!,
        $extra: state.extra as TokenModel,
      );

  String get location => GoRouteData.$location(
        '/token/${Uri.encodeComponent(address)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $seedSavingScreenRoute => GoRouteData.$route(
      path: '/seed-saving',
      factory: $SeedSavingScreenRouteExtension._fromState,
    );

extension $SeedSavingScreenRouteExtension on SeedSavingScreenRoute {
  static SeedSavingScreenRoute _fromState(GoRouterState state) =>
      SeedSavingScreenRoute(
        state.extra as SeedExtra,
      );

  String get location => GoRouteData.$location(
        '/seed-saving',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $sendNFTScreenRoute => GoRouteData.$route(
      path: '/send/nft',
      name: 'send-nft',
      factory: $SendNFTScreenRouteExtension._fromState,
    );

extension $SendNFTScreenRouteExtension on SendNFTScreenRoute {
  static SendNFTScreenRoute _fromState(GoRouterState state) =>
      SendNFTScreenRoute(
        state.extra as NFTModel,
      );

  String get location => GoRouteData.$location(
        '/send/nft',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $inAppWebviewRoute => GoRouteData.$route(
      path: '/webview/:title',
      factory: $InAppWebviewRouteExtension._fromState,
    );

extension $InAppWebviewRouteExtension on InAppWebviewRoute {
  static InAppWebviewRoute _fromState(GoRouterState state) => InAppWebviewRoute(
        title: state.pathParameters['title']!,
        $extra: state.extra as String,
      );

  String get location => GoRouteData.$location(
        '/webview/${Uri.encodeComponent(title)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $sendTransactionScreenRoute => GoRouteData.$route(
      path: '/send',
      factory: $SendTransactionScreenRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'txn',
          factory: $ReviewYourTransactionRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'sending',
              factory: $ProcessingTransactionRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $SendTransactionScreenRouteExtension on SendTransactionScreenRoute {
  static SendTransactionScreenRoute _fromState(GoRouterState state) =>
      SendTransactionScreenRoute();

  String get location => GoRouteData.$location(
        '/send',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ReviewYourTransactionRouteExtension on ReviewYourTransactionRoute {
  static ReviewYourTransactionRoute _fromState(GoRouterState state) =>
      ReviewYourTransactionRoute(
        state.extra as Txn,
      );

  String get location => GoRouteData.$location(
        '/send/txn',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ProcessingTransactionRouteExtension on ProcessingTransactionRoute {
  static ProcessingTransactionRoute _fromState(GoRouterState state) =>
      ProcessingTransactionRoute();

  String get location => GoRouteData.$location(
        '/send/txn/sending',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeBuilder => ShellRouteData.$route(
      navigatorKey: HomeBuilder.$navigatorKey,
      factory: $HomeBuilderExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/browser',
          factory: $DappBrowserRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/message',
          factory: $DashboardShellRoute1Extension._fromState,
        ),
        GoRouteData.$route(
          path: '/main',
          name: 'main',
          factory: $MainRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/history',
          factory: $AncientHistoryShellRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/setting',
          factory: $DashboardShellRoute2Extension._fromState,
        ),
      ],
    );

extension $HomeBuilderExtension on HomeBuilder {
  static HomeBuilder _fromState(GoRouterState state) => HomeBuilder();
}

extension $DappBrowserRouteExtension on DappBrowserRoute {
  static DappBrowserRoute _fromState(GoRouterState state) => DappBrowserRoute();

  String get location => GoRouteData.$location(
        '/browser',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardShellRoute1Extension on DashboardShellRoute1 {
  static DashboardShellRoute1 _fromState(GoRouterState state) =>
      DashboardShellRoute1();

  String get location => GoRouteData.$location(
        '/message',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => MainRoute();

  String get location => GoRouteData.$location(
        '/main',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AncientHistoryShellRouteExtension on AncientHistoryShellRoute {
  static AncientHistoryShellRoute _fromState(GoRouterState state) =>
      AncientHistoryShellRoute();

  String get location => GoRouteData.$location(
        '/history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardShellRoute2Extension on DashboardShellRoute2 {
  static DashboardShellRoute2 _fromState(GoRouterState state) =>
      DashboardShellRoute2();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
