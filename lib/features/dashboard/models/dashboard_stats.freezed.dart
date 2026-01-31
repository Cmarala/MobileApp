// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) {
  return _DashboardStats.fromJson(json);
}

/// @nodoc
mixin _$DashboardStats {
  int get totalVoters => throw _privateConstructorUsedError;
  int get contactedToday => throw _privateConstructorUsedError;
  int get polledVoters => throw _privateConstructorUsedError;
  int get pendingContacts => throw _privateConstructorUsedError;
  double get contactedTodayPercentage => throw _privateConstructorUsedError;
  double get polledPercentage => throw _privateConstructorUsedError;

  /// Serializes this DashboardStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStatsCopyWith<DashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsCopyWith<$Res> {
  factory $DashboardStatsCopyWith(
    DashboardStats value,
    $Res Function(DashboardStats) then,
  ) = _$DashboardStatsCopyWithImpl<$Res, DashboardStats>;
  @useResult
  $Res call({
    int totalVoters,
    int contactedToday,
    int polledVoters,
    int pendingContacts,
    double contactedTodayPercentage,
    double polledPercentage,
  });
}

/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res, $Val extends DashboardStats>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVoters = null,
    Object? contactedToday = null,
    Object? polledVoters = null,
    Object? pendingContacts = null,
    Object? contactedTodayPercentage = null,
    Object? polledPercentage = null,
  }) {
    return _then(
      _value.copyWith(
            totalVoters: null == totalVoters
                ? _value.totalVoters
                : totalVoters // ignore: cast_nullable_to_non_nullable
                      as int,
            contactedToday: null == contactedToday
                ? _value.contactedToday
                : contactedToday // ignore: cast_nullable_to_non_nullable
                      as int,
            polledVoters: null == polledVoters
                ? _value.polledVoters
                : polledVoters // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingContacts: null == pendingContacts
                ? _value.pendingContacts
                : pendingContacts // ignore: cast_nullable_to_non_nullable
                      as int,
            contactedTodayPercentage: null == contactedTodayPercentage
                ? _value.contactedTodayPercentage
                : contactedTodayPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            polledPercentage: null == polledPercentage
                ? _value.polledPercentage
                : polledPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardStatsImplCopyWith<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  factory _$$DashboardStatsImplCopyWith(
    _$DashboardStatsImpl value,
    $Res Function(_$DashboardStatsImpl) then,
  ) = __$$DashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalVoters,
    int contactedToday,
    int polledVoters,
    int pendingContacts,
    double contactedTodayPercentage,
    double polledPercentage,
  });
}

/// @nodoc
class __$$DashboardStatsImplCopyWithImpl<$Res>
    extends _$DashboardStatsCopyWithImpl<$Res, _$DashboardStatsImpl>
    implements _$$DashboardStatsImplCopyWith<$Res> {
  __$$DashboardStatsImplCopyWithImpl(
    _$DashboardStatsImpl _value,
    $Res Function(_$DashboardStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVoters = null,
    Object? contactedToday = null,
    Object? polledVoters = null,
    Object? pendingContacts = null,
    Object? contactedTodayPercentage = null,
    Object? polledPercentage = null,
  }) {
    return _then(
      _$DashboardStatsImpl(
        totalVoters: null == totalVoters
            ? _value.totalVoters
            : totalVoters // ignore: cast_nullable_to_non_nullable
                  as int,
        contactedToday: null == contactedToday
            ? _value.contactedToday
            : contactedToday // ignore: cast_nullable_to_non_nullable
                  as int,
        polledVoters: null == polledVoters
            ? _value.polledVoters
            : polledVoters // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingContacts: null == pendingContacts
            ? _value.pendingContacts
            : pendingContacts // ignore: cast_nullable_to_non_nullable
                  as int,
        contactedTodayPercentage: null == contactedTodayPercentage
            ? _value.contactedTodayPercentage
            : contactedTodayPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        polledPercentage: null == polledPercentage
            ? _value.polledPercentage
            : polledPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardStatsImpl implements _DashboardStats {
  const _$DashboardStatsImpl({
    this.totalVoters = 0,
    this.contactedToday = 0,
    this.polledVoters = 0,
    this.pendingContacts = 0,
    this.contactedTodayPercentage = 0.0,
    this.polledPercentage = 0.0,
  });

  factory _$DashboardStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardStatsImplFromJson(json);

  @override
  @JsonKey()
  final int totalVoters;
  @override
  @JsonKey()
  final int contactedToday;
  @override
  @JsonKey()
  final int polledVoters;
  @override
  @JsonKey()
  final int pendingContacts;
  @override
  @JsonKey()
  final double contactedTodayPercentage;
  @override
  @JsonKey()
  final double polledPercentage;

  @override
  String toString() {
    return 'DashboardStats(totalVoters: $totalVoters, contactedToday: $contactedToday, polledVoters: $polledVoters, pendingContacts: $pendingContacts, contactedTodayPercentage: $contactedTodayPercentage, polledPercentage: $polledPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsImpl &&
            (identical(other.totalVoters, totalVoters) ||
                other.totalVoters == totalVoters) &&
            (identical(other.contactedToday, contactedToday) ||
                other.contactedToday == contactedToday) &&
            (identical(other.polledVoters, polledVoters) ||
                other.polledVoters == polledVoters) &&
            (identical(other.pendingContacts, pendingContacts) ||
                other.pendingContacts == pendingContacts) &&
            (identical(
                  other.contactedTodayPercentage,
                  contactedTodayPercentage,
                ) ||
                other.contactedTodayPercentage == contactedTodayPercentage) &&
            (identical(other.polledPercentage, polledPercentage) ||
                other.polledPercentage == polledPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalVoters,
    contactedToday,
    polledVoters,
    pendingContacts,
    contactedTodayPercentage,
    polledPercentage,
  );

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      __$$DashboardStatsImplCopyWithImpl<_$DashboardStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardStatsImplToJson(this);
  }
}

abstract class _DashboardStats implements DashboardStats {
  const factory _DashboardStats({
    final int totalVoters,
    final int contactedToday,
    final int polledVoters,
    final int pendingContacts,
    final double contactedTodayPercentage,
    final double polledPercentage,
  }) = _$DashboardStatsImpl;

  factory _DashboardStats.fromJson(Map<String, dynamic> json) =
      _$DashboardStatsImpl.fromJson;

  @override
  int get totalVoters;
  @override
  int get contactedToday;
  @override
  int get polledVoters;
  @override
  int get pendingContacts;
  @override
  double get contactedTodayPercentage;
  @override
  double get polledPercentage;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FavorabilityDistribution _$FavorabilityDistributionFromJson(
  Map<String, dynamic> json,
) {
  return _FavorabilityDistribution.fromJson(json);
}

/// @nodoc
mixin _$FavorabilityDistribution {
  String get favorability => throw _privateConstructorUsedError;
  String get favorabilityLocal => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this FavorabilityDistribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavorabilityDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavorabilityDistributionCopyWith<FavorabilityDistribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavorabilityDistributionCopyWith<$Res> {
  factory $FavorabilityDistributionCopyWith(
    FavorabilityDistribution value,
    $Res Function(FavorabilityDistribution) then,
  ) = _$FavorabilityDistributionCopyWithImpl<$Res, FavorabilityDistribution>;
  @useResult
  $Res call({
    String favorability,
    String favorabilityLocal,
    String code,
    int count,
    double percentage,
  });
}

/// @nodoc
class _$FavorabilityDistributionCopyWithImpl<
  $Res,
  $Val extends FavorabilityDistribution
>
    implements $FavorabilityDistributionCopyWith<$Res> {
  _$FavorabilityDistributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavorabilityDistribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorability = null,
    Object? favorabilityLocal = null,
    Object? code = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            favorability: null == favorability
                ? _value.favorability
                : favorability // ignore: cast_nullable_to_non_nullable
                      as String,
            favorabilityLocal: null == favorabilityLocal
                ? _value.favorabilityLocal
                : favorabilityLocal // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavorabilityDistributionImplCopyWith<$Res>
    implements $FavorabilityDistributionCopyWith<$Res> {
  factory _$$FavorabilityDistributionImplCopyWith(
    _$FavorabilityDistributionImpl value,
    $Res Function(_$FavorabilityDistributionImpl) then,
  ) = __$$FavorabilityDistributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String favorability,
    String favorabilityLocal,
    String code,
    int count,
    double percentage,
  });
}

/// @nodoc
class __$$FavorabilityDistributionImplCopyWithImpl<$Res>
    extends
        _$FavorabilityDistributionCopyWithImpl<
          $Res,
          _$FavorabilityDistributionImpl
        >
    implements _$$FavorabilityDistributionImplCopyWith<$Res> {
  __$$FavorabilityDistributionImplCopyWithImpl(
    _$FavorabilityDistributionImpl _value,
    $Res Function(_$FavorabilityDistributionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavorabilityDistribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorability = null,
    Object? favorabilityLocal = null,
    Object? code = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _$FavorabilityDistributionImpl(
        favorability: null == favorability
            ? _value.favorability
            : favorability // ignore: cast_nullable_to_non_nullable
                  as String,
        favorabilityLocal: null == favorabilityLocal
            ? _value.favorabilityLocal
            : favorabilityLocal // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FavorabilityDistributionImpl implements _FavorabilityDistribution {
  const _$FavorabilityDistributionImpl({
    this.favorability = '',
    this.favorabilityLocal = '',
    this.code = '',
    this.count = 0,
    this.percentage = 0.0,
  });

  factory _$FavorabilityDistributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavorabilityDistributionImplFromJson(json);

  @override
  @JsonKey()
  final String favorability;
  @override
  @JsonKey()
  final String favorabilityLocal;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final double percentage;

  @override
  String toString() {
    return 'FavorabilityDistribution(favorability: $favorability, favorabilityLocal: $favorabilityLocal, code: $code, count: $count, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavorabilityDistributionImpl &&
            (identical(other.favorability, favorability) ||
                other.favorability == favorability) &&
            (identical(other.favorabilityLocal, favorabilityLocal) ||
                other.favorabilityLocal == favorabilityLocal) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    favorability,
    favorabilityLocal,
    code,
    count,
    percentage,
  );

  /// Create a copy of FavorabilityDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavorabilityDistributionImplCopyWith<_$FavorabilityDistributionImpl>
  get copyWith =>
      __$$FavorabilityDistributionImplCopyWithImpl<
        _$FavorabilityDistributionImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavorabilityDistributionImplToJson(this);
  }
}

abstract class _FavorabilityDistribution implements FavorabilityDistribution {
  const factory _FavorabilityDistribution({
    final String favorability,
    final String favorabilityLocal,
    final String code,
    final int count,
    final double percentage,
  }) = _$FavorabilityDistributionImpl;

  factory _FavorabilityDistribution.fromJson(Map<String, dynamic> json) =
      _$FavorabilityDistributionImpl.fromJson;

  @override
  String get favorability;
  @override
  String get favorabilityLocal;
  @override
  String get code;
  @override
  int get count;
  @override
  double get percentage;

  /// Create a copy of FavorabilityDistribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavorabilityDistributionImplCopyWith<_$FavorabilityDistributionImpl>
  get copyWith => throw _privateConstructorUsedError;
}
