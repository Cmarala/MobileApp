// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  @JsonKey(name: 'user_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_phone')
  String? get userPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_role')
  String? get userRole => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'geo_unit_id')
  String get geoUnitId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError; // PowerSync Token
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String id,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_phone') String? userPhone,
    @JsonKey(name: 'user_role') String? userRole,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'geo_unit_id') String geoUnitId,
    String token,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = freezed,
    Object? userPhone = freezed,
    Object? userRole = freezed,
    Object? campaignId = null,
    Object? geoUnitId = null,
    Object? token = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userPhone: freezed == userPhone
                ? _value.userPhone
                : userPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            userRole: freezed == userRole
                ? _value.userRole
                : userRole // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            geoUnitId: null == geoUnitId
                ? _value.geoUnitId
                : geoUnitId // ignore: cast_nullable_to_non_nullable
                      as String,
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
    _$AppUserImpl value,
    $Res Function(_$AppUserImpl) then,
  ) = __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String id,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_phone') String? userPhone,
    @JsonKey(name: 'user_role') String? userRole,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'geo_unit_id') String geoUnitId,
    String token,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
    _$AppUserImpl _value,
    $Res Function(_$AppUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = freezed,
    Object? userPhone = freezed,
    Object? userRole = freezed,
    Object? campaignId = null,
    Object? geoUnitId = null,
    Object? token = null,
    Object? isActive = null,
  }) {
    return _then(
      _$AppUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userPhone: freezed == userPhone
            ? _value.userPhone
            : userPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        userRole: freezed == userRole
            ? _value.userRole
            : userRole // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        geoUnitId: null == geoUnitId
            ? _value.geoUnitId
            : geoUnitId // ignore: cast_nullable_to_non_nullable
                  as String,
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl({
    @JsonKey(name: 'user_id') required this.id,
    @JsonKey(name: 'user_name') this.userName,
    @JsonKey(name: 'user_phone') this.userPhone,
    @JsonKey(name: 'user_role') this.userRole,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    @JsonKey(name: 'geo_unit_id') required this.geoUnitId,
    required this.token,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String id;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  @override
  @JsonKey(name: 'user_role')
  final String? userRole;
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  @JsonKey(name: 'geo_unit_id')
  final String geoUnitId;
  @override
  final String token;
  // PowerSync Token
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'AppUser(id: $id, userName: $userName, userPhone: $userPhone, userRole: $userRole, campaignId: $campaignId, geoUnitId: $geoUnitId, token: $token, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.geoUnitId, geoUnitId) ||
                other.geoUnitId == geoUnitId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userName,
    userPhone,
    userRole,
    campaignId,
    geoUnitId,
    token,
    isActive,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser({
    @JsonKey(name: 'user_id') required final String id,
    @JsonKey(name: 'user_name') final String? userName,
    @JsonKey(name: 'user_phone') final String? userPhone,
    @JsonKey(name: 'user_role') final String? userRole,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    @JsonKey(name: 'geo_unit_id') required final String geoUnitId,
    required final String token,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get id;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(name: 'user_phone')
  String? get userPhone;
  @override
  @JsonKey(name: 'user_role')
  String? get userRole;
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  @JsonKey(name: 'geo_unit_id')
  String get geoUnitId;
  @override
  String get token; // PowerSync Token
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
