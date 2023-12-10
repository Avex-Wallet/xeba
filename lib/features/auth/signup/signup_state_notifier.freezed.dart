// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignupStateNotifierState {
  SignupStateNotifierStatus get status => throw _privateConstructorUsedError;
  double get signupButtonOpacity => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupStateNotifierStateCopyWith<SignupStateNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStateNotifierStateCopyWith<$Res> {
  factory $SignupStateNotifierStateCopyWith(SignupStateNotifierState value,
          $Res Function(SignupStateNotifierState) then) =
      _$SignupStateNotifierStateCopyWithImpl<$Res, SignupStateNotifierState>;
  @useResult
  $Res call(
      {SignupStateNotifierStatus status,
      double signupButtonOpacity,
      String email,
      String? errorMessage});
}

/// @nodoc
class _$SignupStateNotifierStateCopyWithImpl<$Res,
        $Val extends SignupStateNotifierState>
    implements $SignupStateNotifierStateCopyWith<$Res> {
  _$SignupStateNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? signupButtonOpacity = null,
    Object? email = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignupStateNotifierStatus,
      signupButtonOpacity: null == signupButtonOpacity
          ? _value.signupButtonOpacity
          : signupButtonOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignupStateNotifierStateCopyWith<$Res>
    implements $SignupStateNotifierStateCopyWith<$Res> {
  factory _$$_SignupStateNotifierStateCopyWith(
          _$_SignupStateNotifierState value,
          $Res Function(_$_SignupStateNotifierState) then) =
      __$$_SignupStateNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignupStateNotifierStatus status,
      double signupButtonOpacity,
      String email,
      String? errorMessage});
}

/// @nodoc
class __$$_SignupStateNotifierStateCopyWithImpl<$Res>
    extends _$SignupStateNotifierStateCopyWithImpl<$Res,
        _$_SignupStateNotifierState>
    implements _$$_SignupStateNotifierStateCopyWith<$Res> {
  __$$_SignupStateNotifierStateCopyWithImpl(_$_SignupStateNotifierState _value,
      $Res Function(_$_SignupStateNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? signupButtonOpacity = null,
    Object? email = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_SignupStateNotifierState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignupStateNotifierStatus,
      signupButtonOpacity: null == signupButtonOpacity
          ? _value.signupButtonOpacity
          : signupButtonOpacity // ignore: cast_nullable_to_non_nullable
              as double,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SignupStateNotifierState implements _SignupStateNotifierState {
  const _$_SignupStateNotifierState(
      {this.status = SignupStateNotifierStatus.initial,
      this.signupButtonOpacity = 0,
      this.email = "",
      this.errorMessage});

  @override
  @JsonKey()
  final SignupStateNotifierStatus status;
  @override
  @JsonKey()
  final double signupButtonOpacity;
  @override
  @JsonKey()
  final String email;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SignupStateNotifierState(status: $status, signupButtonOpacity: $signupButtonOpacity, email: $email, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignupStateNotifierState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.signupButtonOpacity, signupButtonOpacity) ||
                other.signupButtonOpacity == signupButtonOpacity) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, signupButtonOpacity, email, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignupStateNotifierStateCopyWith<_$_SignupStateNotifierState>
      get copyWith => __$$_SignupStateNotifierStateCopyWithImpl<
          _$_SignupStateNotifierState>(this, _$identity);
}

abstract class _SignupStateNotifierState implements SignupStateNotifierState {
  const factory _SignupStateNotifierState(
      {final SignupStateNotifierStatus status,
      final double signupButtonOpacity,
      final String email,
      final String? errorMessage}) = _$_SignupStateNotifierState;

  @override
  SignupStateNotifierStatus get status;
  @override
  double get signupButtonOpacity;
  @override
  String get email;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_SignupStateNotifierStateCopyWith<_$_SignupStateNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}
