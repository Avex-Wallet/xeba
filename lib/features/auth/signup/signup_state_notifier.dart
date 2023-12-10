import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/api_services/api_services.dart';
part 'signup_state_notifier.freezed.dart';

final signupStateNortifierProvider = StateNotifierProvider.autoDispose<
        SignupStateNotifier, SignupStateNotifierState>(
    ((ref) => SignupStateNotifier(
        apiServices: ref.read(apiServiceProvider), ref: ref)));

class SignupStateNotifier extends StateNotifier<SignupStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;
  SignupStateNotifier({required this.apiServices, required this.ref})
      : super(const SignupStateNotifierState());

  void setEmail(String value) {
    if (value.isEmpty) {
      state = state.copyWith(email: value, signupButtonOpacity: 0);
    } else {
      state = state.copyWith(email: value, signupButtonOpacity: 1);
    }
  }

  void signup() async {
    state = state.copyWith(status: SignupStateNotifierStatus.loading);
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(state.email);
    if (emailValid) {
      final response = await apiServices.signupWithDynamicLink(state.email);
      // ignore: unrelated_type_equality_checks
      if (response.code < 300 && response.code >= 200) {
        // //print("SUCCESS");
        state = state.copyWith(
          status: SignupStateNotifierStatus.loaded,
        );
      } else {
        state = state.copyWith(
            status: SignupStateNotifierStatus.error,
            errorMessage: response.errorMessage);
      }
    } else {
      state = state.copyWith(
          status: SignupStateNotifierStatus.error,
          errorMessage: "Please input a valid email.");
    }
  }
}

@freezed
class SignupStateNotifierState with _$SignupStateNotifierState {
  const factory SignupStateNotifierState({
    @Default(SignupStateNotifierStatus.initial)
    SignupStateNotifierStatus status,
    @Default(0) double signupButtonOpacity,
    @Default("") String email,
    String? errorMessage,
  }) = _SignupStateNotifierState;
}

enum SignupStateNotifierStatus { initial, loading, error, loaded }
