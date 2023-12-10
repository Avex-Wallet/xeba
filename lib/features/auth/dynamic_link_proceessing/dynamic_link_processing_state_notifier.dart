import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/api_services/api_response.dart';
import '../../../services/api_services/api_services.dart';

part 'dynamic_link_processing_state_notifier.freezed.dart';

final dynamicLinkProcessingStateNotifierProvider =
    StateNotifierProvider.autoDispose<DynamicLinkProcessingStateNotifier,
            DynamicLinkProcessingStateNotifierState>(
        ((ref) => DynamicLinkProcessingStateNotifier(
            apiServices: ref.read(apiServiceProvider), ref: ref)));

class DynamicLinkProcessingStateNotifier
    extends StateNotifier<DynamicLinkProcessingStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;

  DynamicLinkProcessingStateNotifier(
      {required this.apiServices, required this.ref})
      : super(const DynamicLinkProcessingStateNotifierState());

  void verifyDynamicLink(String authToken) async {
    final response = await apiServices.verifyAuthToken(authToken);
    // ignore: unrelated_type_equality_checks
    if (response.status == ApiStatus.success) {
      try {
        await SecureStorage.accessToken.set(response.data!.access.access);
        await SecureStorage.refreshToken.set(response.data!.refresh.refresh);
        logger.i({
          'access_token': response.data!.access.access,
          'refresh_token': response.data!.refresh.refresh,
        });
        state = state.copyWith(
            status:
                DynamicLinkProcessingStateNotifierStatus.dynamicLinkVerified,
            accessToken: response.data!.access.access,
            refreshToken: response.data!.refresh.refresh);
      } catch (e) {
        //
      }
    } else {
      //debugprint(response.errorMessage);
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.error,
            errorMessage: response.errorMessage);
      } catch (e) {
        //
      }
    }
  }

  void checkWhetherUserExists() async {
    final response =
        await apiServices.getUserExistence(state.accessToken ?? "");
    if (response.status == ApiStatus.success) {
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.loaded,
            userExistsInBackend: response.data!.exists);
      } catch (e) {
        //
      }
    } else {
      //debugprint(response.errorMessage);
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.error,
            errorMessage: response.errorMessage);
      } catch (e) {
        // ignore
      }
    }
  }
}

@freezed
class DynamicLinkProcessingStateNotifierState
    with _$DynamicLinkProcessingStateNotifierState {
  const factory DynamicLinkProcessingStateNotifierState(
      {@Default(DynamicLinkProcessingStateNotifierStatus.initial)
      DynamicLinkProcessingStateNotifierStatus status,
      String? errorMessage,
      String? accessToken,
      @Default(false) bool userExistsInBackend,
      String? refreshToken}) = _DynamicLinkProcessingStateNotifierState;
}

enum DynamicLinkProcessingStateNotifierStatus {
  initial,
  loading,
  error,
  dynamicLinkVerified,
  loaded
}
