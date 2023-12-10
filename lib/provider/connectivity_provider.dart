import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisonnected }

final connectivityProvider =
    StateNotifierProvider<ConnnectivityNotifier, ConnectivityStatus>(
  (ref) => ConnnectivityNotifier(),
);

class ConnnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  late StreamSubscription<ConnectivityResult> subscription;
  ConnnectivityNotifier() : super(ConnectivityStatus.notDetermined) {
    init();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final newState = switch (result) {
        ConnectivityResult.mobile => ConnectivityStatus.isConnected,
        ConnectivityResult.wifi => ConnectivityStatus.isConnected,
        _ => ConnectivityStatus.isDisonnected,
      };
      if (state != newState) state = newState;
    });
  }

  Future init() async {
    final result = await Connectivity().checkConnectivity();
    final newState = switch (result) {
      ConnectivityResult.mobile => ConnectivityStatus.isConnected,
      ConnectivityResult.wifi => ConnectivityStatus.isConnected,
      _ => ConnectivityStatus.isDisonnected,
    };
    if (state != newState) state = newState;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
