// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:io';

import 'package:bip32_ed25519/bip32_ed25519.dart';
import 'package:eddsa_hmac/services/wallet/message.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:avex_mobile/services/api_services/api_response.dart';
import 'package:avex_mobile/services/api_services/api_services.dart';
import 'package:avex_mobile/services/drive_service/google_drive/drive_main_service.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';

part 'seed_saving_state_notifier.freezed.dart';

final seedSavingStateNotifierProvider = StateNotifierProvider.autoDispose<
        SeedSavingStateNotifier, SeedSavingStateNotifierState>(
    ((ref) => SeedSavingStateNotifier(
        apiServices: ref.read(apiServiceProvider), ref: ref)));

class SeedSavingStateNotifier
    extends StateNotifier<SeedSavingStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;

  SeedSavingStateNotifier({required this.apiServices, required this.ref})
      : super(const SeedSavingStateNotifierState());

  driveFunction(String driveKey, ExtendedSigningKey edwardsKey) async {
    state = state.copyWith(driveUploadLoading: true);
    final driveClient = GoogleDriveAppData();
    final user = await driveClient.signInGoogle();
    if (user.status == ApiStatus.error) {
      state = state.copyWith(
          errorMessage: user.errorMessage,
          status: SeedSavingStateNotifierStatus.error,
          driveUploadLoading: false);
      state = state.copyWith(status: SeedSavingStateNotifierStatus.initial);
      return;
    }
    //debugprint(user.data!.email);
    if (user != null) {
      final driveApi = await driveClient.getDriveApi(user.data!);
      if (driveApi != null) {
        // await driveClient.deleteAllPreviousVersions(driveApi, "temp.txt");

        final file = await _createLevelFile();
        await file.writeAsString(driveKey);
        final accessToken = await SecureStorage.accessToken.value;
        String? fileId;
        final fileIdResponse = await apiServices.getCloudFileId(accessToken);
        if (fileIdResponse.status == ApiStatus.error) {
          if (fileIdResponse.code == 404) {
            fileId = null;
          }
        }
        fileId = fileIdResponse.data;
        final response = await driveClient.uploadDriveFile(
            driveApi: driveApi, file: file, driveFileId: fileId);
        await apiServices.refreshAccessTokenToSharedPref();

        final signature =
            await getSignature(response?.id ?? "", edwardsKey, accessToken);
        if (signature.status == ApiStatus.error) {
          state = state.copyWith(
              status: SeedSavingStateNotifierStatus.error,
              errorMessage: signature.errorMessage!,
              driveUploadLoading: false);
          return;
        }
        ApiResponse repsonse = await apiServices.createCloudFileId(
            accessToken, "google", response?.id ?? "", signature.data!);
        if (repsonse.status == ApiStatus.error) {
          state = state.copyWith(
              status: SeedSavingStateNotifierStatus.error,
              errorMessage: repsonse.errorMessage!,
              driveUploadLoading: false);
        }
        await file.delete();

        state = state.copyWith(
          status: SeedSavingStateNotifierStatus.initial,
          driveUploadLoading: false,
          driveUploadSuccessful: true,
        );
      }
    }
  }

  Future<ApiResponse<String>> getSignature(
      String fileId, ExtendedSigningKey edwardsKey, String accessToken) async {
    try {
      final firstNonce = await apiServices.getNonce(accessToken);
      if (firstNonce.status == ApiStatus.error) {
        throw CustomHttpException(
            firstNonce.errorMessage ?? "Unknown Exception", firstNonce.code);
      }
      final response = generateCloudCreateMessage(
          fileId, "google", firstNonce.data!, edwardsKey);
      return ApiResponse.success(response, -1);
    } on CustomHttpException catch (e) {
      return ApiResponse.error(e.message, e.code);
    }
  }

  Future<File> _createLevelFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File('$appDocPath/AvexWalletBackupSecret');
    return await file.create();
  }

  void onQrSuccessfullyShared() {
    state = state.copyWith(qrCodeSuccessful: true);
  }
}

@freezed
class SeedSavingStateNotifierState with _$SeedSavingStateNotifierState {
  const factory SeedSavingStateNotifierState({
    @Default(SeedSavingStateNotifierStatus.initial)
    SeedSavingStateNotifierStatus status,
    String? errorMessage,
    @Default(0) int noOfSteps,
    @Default(false) bool driveUploadLoading,
    @Default(false) bool qrCodeLoading,
    @Default(false) bool driveUploadSuccessful,
    @Default(false) bool qrCodeSuccessful,
  }) = _SeedSavingStateNotifierState;
}

enum SeedSavingStateNotifierStatus { initial, loading, error, loaded }
