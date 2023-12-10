// ignore_for_file: unnecessary_null_comparison
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:avex_mobile/services/api_services/api_response.dart';
import 'package:avex_mobile/services/api_services/api_services.dart';
import 'package:avex_mobile/services/drive_service/google_drive/drive_main_service.dart';
import 'package:avex_mobile/services/eddsa_hmac.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';

part 'seed_recovery_state_notifier.freezed.dart';

final seedRecoveryStateNotifierProvider = StateNotifierProvider.autoDispose<
        SeedRecoveryStateNotifier, SeedRecoveryStateNotifierState>(
    ((ref) => SeedRecoveryStateNotifier(
        apiServices: ref.read(apiServiceProvider),
        eddsaHmac: ref.read(eddsaHmacProvider),
        ref: ref)));

class SeedRecoveryStateNotifier
    extends StateNotifier<SeedRecoveryStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;
  final EddsaHmac eddsaHmac;

  SeedRecoveryStateNotifier(
      {required this.apiServices, required this.eddsaHmac, required this.ref})
      : super(const SeedRecoveryStateNotifierState()) {
    getBackgroundWork();
  }

  Future<void> driveRecovery() async {
    state = state.copyWith(driveKeyVerifing: true);
    final driveClient = GoogleDriveAppData();

    final user = await driveClient.signInGoogle();
    //debugprint(user.data!.email);
    if (user != null) {
      final driveApi = await driveClient.getDriveApi(user.data!);
      if (driveApi != null) {
        final file =
            await driveClient.getDriveFile(driveApi, "AvexWalletBackupSecret");
        if (file != null) {
          final restoredFile = await driveClient.restoreDriveFile(
              driveApi: driveApi, driveFile: file, targetLocalPath: ".");
          if (restoredFile != null) {
            //debugprint("SHASHANK--driveKey-recovery: $restoredFile");
            state = state.copyWith(
                status: SeedRecoveryStateNotifierStatus.driveKeyRestored,
                driveKeySubmitted: true,
                driveKeyVerifing: false,
                driveKey: restoredFile);
            checkForValidity();
          } else {
            state = state.copyWith(
                status: SeedRecoveryStateNotifierStatus.error,
                driveKeyVerifing: false,
                errorMessage: "No Keys found");
          }
        } else {
          state = state.copyWith(
              status: SeedRecoveryStateNotifierStatus.error,
              driveKeyVerifing: false,
              errorMessage: "No Keys found");
        }
      }
    }
  }

  void onSubmitQrCode(String qrCode, [List<String>? args]) async {
    //debugprint("SHASHANK--qrCode-recovery:" + qrCode);
    state = state.copyWith(
        qrKey: qrCode,
        status: SeedRecoveryStateNotifierStatus.qrCodeRestored,
        qrKeySubmitted: true);
    checkForValidity();
  }

  void getBackgroundWork() async {
    try {
      state = state.copyWith(status: SeedRecoveryStateNotifierStatus.loading);
      await apiServices.refreshAccessTokenToSharedPref();

      final accessToken = await SecureStorage.accessToken.value;

      final secretShare = await apiServices.getSecretShare(accessToken);
      if (secretShare.status != ApiStatus.success) {
        throw CustomHttpException(
            secretShare.errorMessage ?? "Unknown Error", secretShare.code);
      }
      //debugprint("SHASHANK--backend-recovery: ${secretShare.data!.secret}");
      state = state.copyWith(
          backendKey: secretShare.data!.secret,
          status: SeedRecoveryStateNotifierStatus.initial);
    } on CustomHttpException catch (e) {
      state = state.copyWith(
          status: SeedRecoveryStateNotifierStatus.error,
          errorMessage: e.message);
      state = state.copyWith(status: SeedRecoveryStateNotifierStatus.initial);
    } catch (e) {
      state = state.copyWith(
          status: SeedRecoveryStateNotifierStatus.error,
          errorMessage: e.toString());
      state = state.copyWith(status: SeedRecoveryStateNotifierStatus.initial);
    }
  }

  void checkForValidity() async {
    state = state.copyWith(status: SeedRecoveryStateNotifierStatus.loading);
    final List<String> arr = [];
    if (state.backendKey.isNotEmpty) {
      arr.add(state.backendKey);
    }
    if (state.driveKey.isNotEmpty) {
      arr.add(state.driveKey);
    }
    if (state.qrKey.isNotEmpty) {
      arr.add(state.qrKey);
    }
    final response = await eddsaHmac.recoverSeedPhraseFromUserZ(arr);
    if (response.status == ApiStatus.error) {
      state = state.copyWith(
          status: SeedRecoveryStateNotifierStatus.error,
          errorMessage: response.errorMessage);
    } else {
      state = state.copyWith(status: SeedRecoveryStateNotifierStatus.loaded);
    }
  }
}

@freezed
class SeedRecoveryStateNotifierState with _$SeedRecoveryStateNotifierState {
  const factory SeedRecoveryStateNotifierState({
    @Default(SeedRecoveryStateNotifierStatus.initial)
    SeedRecoveryStateNotifierStatus status,
    String? errorMessage,
    @Default("") String driveKey,
    @Default("") String qrKey,
    @Default("") String backendKey,
    @Default(false) bool driveKeySubmitted,
    @Default(false) bool driveKeyVerifing,
    @Default(false) bool qrKeySubmitted,
    @Default(false) bool qrKeyVerifing,
  }) = _SeedRecoveryStateNotifierState;
}

enum SeedRecoveryStateNotifierStatus {
  initial,
  loading,
  error,
  loaded,
  driveKeyRestored,
  qrCodeRestored
}

// ---------------
