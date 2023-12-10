// ignore_for_file: depend_on_referenced_packages

import 'package:bip32_ed25519/bip32_ed25519.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:avex_mobile/services/api_services/api_response.dart';
import 'package:avex_mobile/services/api_services/api_services.dart';
import 'package:avex_mobile/services/eddsa_hmac.dart';

part 'restore_existing_account_state_notifier.freezed.dart';

final restoreExistingAccountStateNotifierProvider =
    StateNotifierProvider.autoDispose<RestoreExistingAccountStateNotifier,
            RestoreExistingAccountStateNotifierState>(
        ((ref) => RestoreExistingAccountStateNotifier(
            apiServices: ref.read(apiServiceProvider),
            eddsaHmac: ref.read(eddsaHmacProvider),
            ref: ref)));

class RestoreExistingAccountStateNotifier
    extends StateNotifier<RestoreExistingAccountStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;
  final EddsaHmac eddsaHmac;

  RestoreExistingAccountStateNotifier(
      {required this.apiServices, required this.ref, required this.eddsaHmac})
      : super(const RestoreExistingAccountStateNotifierState());

  void inputSeedPhrase(String seed) {
    state = state.copyWith(seedPhraseList: seed);
  }

  void onSeedPhraseSubmitted() async {
    state = state.copyWith(
        status: RestoreExistingAccountStateNotifierStatus.loading);
    final response =
        await eddsaHmac.importSeedPhrase(state.seedPhraseList, (key) {
      if (key == null || key.toString().isEmpty) {
        state = state.copyWith(
            status: RestoreExistingAccountStateNotifierStatus.error,
            errorMessage: "Drive key is null or empty.");
        state = state.copyWith(
          status: RestoreExistingAccountStateNotifierStatus.initial,
        );
        return;
      }
      state = state.copyWith(driveKey: key);
    }, (key) {
      if (key == null || key.toString().isEmpty) {
        state = state.copyWith(
            status: RestoreExistingAccountStateNotifierStatus.error,
            errorMessage: "QR-code key is null or empty.");
        state = state.copyWith(
          status: RestoreExistingAccountStateNotifierStatus.initial,
        );
        return;
      }
      state = state.copyWith(qrKey: key);
    });
    if (response.status == ApiStatus.success) {
      // AutoRouter.of()
      state = state.copyWith(
          status: RestoreExistingAccountStateNotifierStatus.loaded,
          edwardsKey: response.data!);
    } else {
      state = state.copyWith(
          status: RestoreExistingAccountStateNotifierStatus.error,
          errorMessage: response.errorMessage);
    }
  }
}

@freezed
class RestoreExistingAccountStateNotifierState
    with _$RestoreExistingAccountStateNotifierState {
  const factory RestoreExistingAccountStateNotifierState(
      {@Default(RestoreExistingAccountStateNotifierStatus.initial)
      RestoreExistingAccountStateNotifierStatus status,
      @Default("") String seedPhraseList,
      String? errorMessage,
      String? driveKey,
      ExtendedSigningKey? edwardsKey,
      String? qrKey}) = _RestoreExistingAccountStateNotifierState;
}

enum RestoreExistingAccountStateNotifierStatus {
  initial,
  loading,
  error,
  loaded
}
