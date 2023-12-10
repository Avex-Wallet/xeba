// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_link_processing_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DynamicLinkProcessingStateNotifierState {
  DynamicLinkProcessingStateNotifierStatus get status =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  bool get userExistsInBackend => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DynamicLinkProcessingStateNotifierStateCopyWith<
          DynamicLinkProcessingStateNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicLinkProcessingStateNotifierStateCopyWith<$Res> {
  factory $DynamicLinkProcessingStateNotifierStateCopyWith(
          DynamicLinkProcessingStateNotifierState value,
          $Res Function(DynamicLinkProcessingStateNotifierState) then) =
      _$DynamicLinkProcessingStateNotifierStateCopyWithImpl<$Res,
          DynamicLinkProcessingStateNotifierState>;
  @useResult
  $Res call(
      {DynamicLinkProcessingStateNotifierStatus status,
      String? errorMessage,
      String? accessToken,
      bool userExistsInBackend,
      String? refreshToken});
}

/// @nodoc
class _$DynamicLinkProcessingStateNotifierStateCopyWithImpl<$Res,
        $Val extends DynamicLinkProcessingStateNotifierState>
    implements $DynamicLinkProcessingStateNotifierStateCopyWith<$Res> {
  _$DynamicLinkProcessingStateNotifierStateCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? accessToken = freezed,
    Object? userExistsInBackend = null,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DynamicLinkProcessingStateNotifierStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      userExistsInBackend: null == userExistsInBackend
          ? _value.userExistsInBackend
          : userExistsInBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DynamicLinkProcessingStateNotifierStateCopyWith<$Res>
    implements $DynamicLinkProcessingStateNotifierStateCopyWith<$Res> {
  factory _$$_DynamicLinkProcessingStateNotifierStateCopyWith(
          _$_DynamicLinkProcessingStateNotifierState value,
          $Res Function(_$_DynamicLinkProcessingStateNotifierState) then) =
      __$$_DynamicLinkProcessingStateNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DynamicLinkProcessingStateNotifierStatus status,
      String? errorMessage,
      String? accessToken,
      bool userExistsInBackend,
      String? refreshToken});
}

/// @nodoc
class __$$_DynamicLinkProcessingStateNotifierStateCopyWithImpl<$Res>
    extends _$DynamicLinkProcessingStateNotifierStateCopyWithImpl<$Res,
        _$_DynamicLinkProcessingStateNotifierState>
    implements _$$_DynamicLinkProcessingStateNotifierStateCopyWith<$Res> {
  __$$_DynamicLinkProcessingStateNotifierStateCopyWithImpl(
      _$_DynamicLinkProcessingStateNotifierState _value,
      $Res Function(_$_DynamicLinkProcessingStateNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? accessToken = freezed,
    Object? userExistsInBackend = null,
    Object? refreshToken = freezed,
  }) {
    return _then(_$_DynamicLinkProcessingStateNotifierState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DynamicLinkProcessingStateNotifierStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      userExistsInBackend: null == userExistsInBackend
          ? _value.userExistsInBackend
          : userExistsInBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DynamicLinkProcessingStateNotifierState
    implements _DynamicLinkProcessingStateNotifierState {
  const _$_DynamicLinkProcessingStateNotifierState(
      {this.status = DynamicLinkProcessingStateNotifierStatus.initial,
      this.errorMessage,
      this.accessToken,
      this.userExistsInBackend = false,
      this.refreshToken});

  @override
  @JsonKey()
  final DynamicLinkProcessingStateNotifierStatus status;
  @override
  final String? errorMessage;
  @override
  final String? accessToken;
  @override
  @JsonKey()
  final bool userExistsInBackend;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'DynamicLinkProcessingStateNotifierState(status: $status, errorMessage: $errorMessage, accessToken: $accessToken, userExistsInBackend: $userExistsInBackend, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DynamicLinkProcessingStateNotifierState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.userExistsInBackend, userExistsInBackend) ||
                other.userExistsInBackend == userExistsInBackend) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage,
      accessToken, userExistsInBackend, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DynamicLinkProcessingStateNotifierStateCopyWith<
          _$_DynamicLinkProcessingStateNotifierState>
      get copyWith => __$$_DynamicLinkProcessingStateNotifierStateCopyWithImpl<
          _$_DynamicLinkProcessingStateNotifierState>(this, _$identity);
}

abstract class _DynamicLinkProcessingStateNotifierState
    implements DynamicLinkProcessingStateNotifierState {
  const factory _DynamicLinkProcessingStateNotifierState(
      {final DynamicLinkProcessingStateNotifierStatus status,
      final String? errorMessage,
      final String? accessToken,
      final bool userExistsInBackend,
      final String? refreshToken}) = _$_DynamicLinkProcessingStateNotifierState;

  @override
  DynamicLinkProcessingStateNotifierStatus get status;
  @override
  String? get errorMessage;
  @override
  String? get accessToken;
  @override
  bool get userExistsInBackend;
  @override
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$_DynamicLinkProcessingStateNotifierStateCopyWith<
          _$_DynamicLinkProcessingStateNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}
