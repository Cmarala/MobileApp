// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return _SettingsState.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  String get langCode =>
      throw _privateConstructorUsedError; // 'en' or locale-specific code (default English)
  bool get headerEnabled =>
      throw _privateConstructorUsedError; // Show/hide header message
  bool get footerEnabled => throw _privateConstructorUsedError;

  /// Serializes this SettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
    SettingsState value,
    $Res Function(SettingsState) then,
  ) = _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({String langCode, bool headerEnabled, bool footerEnabled});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? langCode = null,
    Object? headerEnabled = null,
    Object? footerEnabled = null,
  }) {
    return _then(
      _value.copyWith(
            langCode: null == langCode
                ? _value.langCode
                : langCode // ignore: cast_nullable_to_non_nullable
                      as String,
            headerEnabled: null == headerEnabled
                ? _value.headerEnabled
                : headerEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            footerEnabled: null == footerEnabled
                ? _value.footerEnabled
                : footerEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
    _$SettingsStateImpl value,
    $Res Function(_$SettingsStateImpl) then,
  ) = __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String langCode, bool headerEnabled, bool footerEnabled});
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
    _$SettingsStateImpl _value,
    $Res Function(_$SettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? langCode = null,
    Object? headerEnabled = null,
    Object? footerEnabled = null,
  }) {
    return _then(
      _$SettingsStateImpl(
        langCode: null == langCode
            ? _value.langCode
            : langCode // ignore: cast_nullable_to_non_nullable
                  as String,
        headerEnabled: null == headerEnabled
            ? _value.headerEnabled
            : headerEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        footerEnabled: null == footerEnabled
            ? _value.footerEnabled
            : footerEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl({
    this.langCode = 'en',
    this.headerEnabled = false,
    this.footerEnabled = false,
  });

  factory _$SettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsStateImplFromJson(json);

  @override
  @JsonKey()
  final String langCode;
  // 'en' or locale-specific code (default English)
  @override
  @JsonKey()
  final bool headerEnabled;
  // Show/hide header message
  @override
  @JsonKey()
  final bool footerEnabled;

  @override
  String toString() {
    return 'SettingsState(langCode: $langCode, headerEnabled: $headerEnabled, footerEnabled: $footerEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.langCode, langCode) ||
                other.langCode == langCode) &&
            (identical(other.headerEnabled, headerEnabled) ||
                other.headerEnabled == headerEnabled) &&
            (identical(other.footerEnabled, footerEnabled) ||
                other.footerEnabled == footerEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, langCode, headerEnabled, footerEnabled);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsStateImplToJson(this);
  }
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState({
    final String langCode,
    final bool headerEnabled,
    final bool footerEnabled,
  }) = _$SettingsStateImpl;

  factory _SettingsState.fromJson(Map<String, dynamic> json) =
      _$SettingsStateImpl.fromJson;

  @override
  String get langCode; // 'en' or locale-specific code (default English)
  @override
  bool get headerEnabled; // Show/hide header message
  @override
  bool get footerEnabled;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
