// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardFilters _$DashboardFiltersFromJson(Map<String, dynamic> json) {
  return _DashboardFilters.fromJson(json);
}

/// @nodoc
mixin _$DashboardFilters {
  // Geographic filters
  List<String> get selectedGeoUnitIds =>
      throw _privateConstructorUsedError; // Demographics filters
  int? get ageMin => throw _privateConstructorUsedError;
  int? get ageMax => throw _privateConstructorUsedError;
  List<String> get selectedGenders => throw _privateConstructorUsedError;
  List<int> get selectedReligionIds => throw _privateConstructorUsedError;
  List<int> get selectedCasteIds => throw _privateConstructorUsedError;
  List<int> get selectedEducationIds =>
      throw _privateConstructorUsedError; // Status filters
  bool? get isPolled => throw _privateConstructorUsedError;
  bool? get isDead => throw _privateConstructorUsedError;
  bool? get isShifted => throw _privateConstructorUsedError; // Activity filters
  DateTime? get lastVisitedFrom => throw _privateConstructorUsedError;
  DateTime? get lastVisitedTo => throw _privateConstructorUsedError;
  bool get neverVisited =>
      throw _privateConstructorUsedError; // Contact filters
  bool? get hasPhone => throw _privateConstructorUsedError;
  bool get hasMobile =>
      throw _privateConstructorUsedError; // Favorability filters
  List<String> get selectedFavorabilities => throw _privateConstructorUsedError;

  /// Serializes this DashboardFilters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardFiltersCopyWith<DashboardFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardFiltersCopyWith<$Res> {
  factory $DashboardFiltersCopyWith(
    DashboardFilters value,
    $Res Function(DashboardFilters) then,
  ) = _$DashboardFiltersCopyWithImpl<$Res, DashboardFilters>;
  @useResult
  $Res call({
    List<String> selectedGeoUnitIds,
    int? ageMin,
    int? ageMax,
    List<String> selectedGenders,
    List<int> selectedReligionIds,
    List<int> selectedCasteIds,
    List<int> selectedEducationIds,
    bool? isPolled,
    bool? isDead,
    bool? isShifted,
    DateTime? lastVisitedFrom,
    DateTime? lastVisitedTo,
    bool neverVisited,
    bool? hasPhone,
    bool hasMobile,
    List<String> selectedFavorabilities,
  });
}

/// @nodoc
class _$DashboardFiltersCopyWithImpl<$Res, $Val extends DashboardFilters>
    implements $DashboardFiltersCopyWith<$Res> {
  _$DashboardFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGeoUnitIds = null,
    Object? ageMin = freezed,
    Object? ageMax = freezed,
    Object? selectedGenders = null,
    Object? selectedReligionIds = null,
    Object? selectedCasteIds = null,
    Object? selectedEducationIds = null,
    Object? isPolled = freezed,
    Object? isDead = freezed,
    Object? isShifted = freezed,
    Object? lastVisitedFrom = freezed,
    Object? lastVisitedTo = freezed,
    Object? neverVisited = null,
    Object? hasPhone = freezed,
    Object? hasMobile = null,
    Object? selectedFavorabilities = null,
  }) {
    return _then(
      _value.copyWith(
            selectedGeoUnitIds: null == selectedGeoUnitIds
                ? _value.selectedGeoUnitIds
                : selectedGeoUnitIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            ageMin: freezed == ageMin
                ? _value.ageMin
                : ageMin // ignore: cast_nullable_to_non_nullable
                      as int?,
            ageMax: freezed == ageMax
                ? _value.ageMax
                : ageMax // ignore: cast_nullable_to_non_nullable
                      as int?,
            selectedGenders: null == selectedGenders
                ? _value.selectedGenders
                : selectedGenders // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            selectedReligionIds: null == selectedReligionIds
                ? _value.selectedReligionIds
                : selectedReligionIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            selectedCasteIds: null == selectedCasteIds
                ? _value.selectedCasteIds
                : selectedCasteIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            selectedEducationIds: null == selectedEducationIds
                ? _value.selectedEducationIds
                : selectedEducationIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            isPolled: freezed == isPolled
                ? _value.isPolled
                : isPolled // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isDead: freezed == isDead
                ? _value.isDead
                : isDead // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isShifted: freezed == isShifted
                ? _value.isShifted
                : isShifted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            lastVisitedFrom: freezed == lastVisitedFrom
                ? _value.lastVisitedFrom
                : lastVisitedFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastVisitedTo: freezed == lastVisitedTo
                ? _value.lastVisitedTo
                : lastVisitedTo // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            neverVisited: null == neverVisited
                ? _value.neverVisited
                : neverVisited // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPhone: freezed == hasPhone
                ? _value.hasPhone
                : hasPhone // ignore: cast_nullable_to_non_nullable
                      as bool?,
            hasMobile: null == hasMobile
                ? _value.hasMobile
                : hasMobile // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedFavorabilities: null == selectedFavorabilities
                ? _value.selectedFavorabilities
                : selectedFavorabilities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardFiltersImplCopyWith<$Res>
    implements $DashboardFiltersCopyWith<$Res> {
  factory _$$DashboardFiltersImplCopyWith(
    _$DashboardFiltersImpl value,
    $Res Function(_$DashboardFiltersImpl) then,
  ) = __$$DashboardFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> selectedGeoUnitIds,
    int? ageMin,
    int? ageMax,
    List<String> selectedGenders,
    List<int> selectedReligionIds,
    List<int> selectedCasteIds,
    List<int> selectedEducationIds,
    bool? isPolled,
    bool? isDead,
    bool? isShifted,
    DateTime? lastVisitedFrom,
    DateTime? lastVisitedTo,
    bool neverVisited,
    bool? hasPhone,
    bool hasMobile,
    List<String> selectedFavorabilities,
  });
}

/// @nodoc
class __$$DashboardFiltersImplCopyWithImpl<$Res>
    extends _$DashboardFiltersCopyWithImpl<$Res, _$DashboardFiltersImpl>
    implements _$$DashboardFiltersImplCopyWith<$Res> {
  __$$DashboardFiltersImplCopyWithImpl(
    _$DashboardFiltersImpl _value,
    $Res Function(_$DashboardFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGeoUnitIds = null,
    Object? ageMin = freezed,
    Object? ageMax = freezed,
    Object? selectedGenders = null,
    Object? selectedReligionIds = null,
    Object? selectedCasteIds = null,
    Object? selectedEducationIds = null,
    Object? isPolled = freezed,
    Object? isDead = freezed,
    Object? isShifted = freezed,
    Object? lastVisitedFrom = freezed,
    Object? lastVisitedTo = freezed,
    Object? neverVisited = null,
    Object? hasPhone = freezed,
    Object? hasMobile = null,
    Object? selectedFavorabilities = null,
  }) {
    return _then(
      _$DashboardFiltersImpl(
        selectedGeoUnitIds: null == selectedGeoUnitIds
            ? _value._selectedGeoUnitIds
            : selectedGeoUnitIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        ageMin: freezed == ageMin
            ? _value.ageMin
            : ageMin // ignore: cast_nullable_to_non_nullable
                  as int?,
        ageMax: freezed == ageMax
            ? _value.ageMax
            : ageMax // ignore: cast_nullable_to_non_nullable
                  as int?,
        selectedGenders: null == selectedGenders
            ? _value._selectedGenders
            : selectedGenders // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        selectedReligionIds: null == selectedReligionIds
            ? _value._selectedReligionIds
            : selectedReligionIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        selectedCasteIds: null == selectedCasteIds
            ? _value._selectedCasteIds
            : selectedCasteIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        selectedEducationIds: null == selectedEducationIds
            ? _value._selectedEducationIds
            : selectedEducationIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        isPolled: freezed == isPolled
            ? _value.isPolled
            : isPolled // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isDead: freezed == isDead
            ? _value.isDead
            : isDead // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isShifted: freezed == isShifted
            ? _value.isShifted
            : isShifted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        lastVisitedFrom: freezed == lastVisitedFrom
            ? _value.lastVisitedFrom
            : lastVisitedFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastVisitedTo: freezed == lastVisitedTo
            ? _value.lastVisitedTo
            : lastVisitedTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        neverVisited: null == neverVisited
            ? _value.neverVisited
            : neverVisited // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPhone: freezed == hasPhone
            ? _value.hasPhone
            : hasPhone // ignore: cast_nullable_to_non_nullable
                  as bool?,
        hasMobile: null == hasMobile
            ? _value.hasMobile
            : hasMobile // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedFavorabilities: null == selectedFavorabilities
            ? _value._selectedFavorabilities
            : selectedFavorabilities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardFiltersImpl implements _DashboardFilters {
  const _$DashboardFiltersImpl({
    final List<String> selectedGeoUnitIds = const [],
    this.ageMin,
    this.ageMax,
    final List<String> selectedGenders = const [],
    final List<int> selectedReligionIds = const [],
    final List<int> selectedCasteIds = const [],
    final List<int> selectedEducationIds = const [],
    this.isPolled,
    this.isDead,
    this.isShifted,
    this.lastVisitedFrom,
    this.lastVisitedTo,
    this.neverVisited = false,
    this.hasPhone,
    this.hasMobile = false,
    final List<String> selectedFavorabilities = const [],
  }) : _selectedGeoUnitIds = selectedGeoUnitIds,
       _selectedGenders = selectedGenders,
       _selectedReligionIds = selectedReligionIds,
       _selectedCasteIds = selectedCasteIds,
       _selectedEducationIds = selectedEducationIds,
       _selectedFavorabilities = selectedFavorabilities;

  factory _$DashboardFiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardFiltersImplFromJson(json);

  // Geographic filters
  final List<String> _selectedGeoUnitIds;
  // Geographic filters
  @override
  @JsonKey()
  List<String> get selectedGeoUnitIds {
    if (_selectedGeoUnitIds is EqualUnmodifiableListView)
      return _selectedGeoUnitIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGeoUnitIds);
  }

  // Demographics filters
  @override
  final int? ageMin;
  @override
  final int? ageMax;
  final List<String> _selectedGenders;
  @override
  @JsonKey()
  List<String> get selectedGenders {
    if (_selectedGenders is EqualUnmodifiableListView) return _selectedGenders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGenders);
  }

  final List<int> _selectedReligionIds;
  @override
  @JsonKey()
  List<int> get selectedReligionIds {
    if (_selectedReligionIds is EqualUnmodifiableListView)
      return _selectedReligionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedReligionIds);
  }

  final List<int> _selectedCasteIds;
  @override
  @JsonKey()
  List<int> get selectedCasteIds {
    if (_selectedCasteIds is EqualUnmodifiableListView)
      return _selectedCasteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCasteIds);
  }

  final List<int> _selectedEducationIds;
  @override
  @JsonKey()
  List<int> get selectedEducationIds {
    if (_selectedEducationIds is EqualUnmodifiableListView)
      return _selectedEducationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedEducationIds);
  }

  // Status filters
  @override
  final bool? isPolled;
  @override
  final bool? isDead;
  @override
  final bool? isShifted;
  // Activity filters
  @override
  final DateTime? lastVisitedFrom;
  @override
  final DateTime? lastVisitedTo;
  @override
  @JsonKey()
  final bool neverVisited;
  // Contact filters
  @override
  final bool? hasPhone;
  @override
  @JsonKey()
  final bool hasMobile;
  // Favorability filters
  final List<String> _selectedFavorabilities;
  // Favorability filters
  @override
  @JsonKey()
  List<String> get selectedFavorabilities {
    if (_selectedFavorabilities is EqualUnmodifiableListView)
      return _selectedFavorabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedFavorabilities);
  }

  @override
  String toString() {
    return 'DashboardFilters(selectedGeoUnitIds: $selectedGeoUnitIds, ageMin: $ageMin, ageMax: $ageMax, selectedGenders: $selectedGenders, selectedReligionIds: $selectedReligionIds, selectedCasteIds: $selectedCasteIds, selectedEducationIds: $selectedEducationIds, isPolled: $isPolled, isDead: $isDead, isShifted: $isShifted, lastVisitedFrom: $lastVisitedFrom, lastVisitedTo: $lastVisitedTo, neverVisited: $neverVisited, hasPhone: $hasPhone, hasMobile: $hasMobile, selectedFavorabilities: $selectedFavorabilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardFiltersImpl &&
            const DeepCollectionEquality().equals(
              other._selectedGeoUnitIds,
              _selectedGeoUnitIds,
            ) &&
            (identical(other.ageMin, ageMin) || other.ageMin == ageMin) &&
            (identical(other.ageMax, ageMax) || other.ageMax == ageMax) &&
            const DeepCollectionEquality().equals(
              other._selectedGenders,
              _selectedGenders,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedReligionIds,
              _selectedReligionIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedCasteIds,
              _selectedCasteIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedEducationIds,
              _selectedEducationIds,
            ) &&
            (identical(other.isPolled, isPolled) ||
                other.isPolled == isPolled) &&
            (identical(other.isDead, isDead) || other.isDead == isDead) &&
            (identical(other.isShifted, isShifted) ||
                other.isShifted == isShifted) &&
            (identical(other.lastVisitedFrom, lastVisitedFrom) ||
                other.lastVisitedFrom == lastVisitedFrom) &&
            (identical(other.lastVisitedTo, lastVisitedTo) ||
                other.lastVisitedTo == lastVisitedTo) &&
            (identical(other.neverVisited, neverVisited) ||
                other.neverVisited == neverVisited) &&
            (identical(other.hasPhone, hasPhone) ||
                other.hasPhone == hasPhone) &&
            (identical(other.hasMobile, hasMobile) ||
                other.hasMobile == hasMobile) &&
            const DeepCollectionEquality().equals(
              other._selectedFavorabilities,
              _selectedFavorabilities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedGeoUnitIds),
    ageMin,
    ageMax,
    const DeepCollectionEquality().hash(_selectedGenders),
    const DeepCollectionEquality().hash(_selectedReligionIds),
    const DeepCollectionEquality().hash(_selectedCasteIds),
    const DeepCollectionEquality().hash(_selectedEducationIds),
    isPolled,
    isDead,
    isShifted,
    lastVisitedFrom,
    lastVisitedTo,
    neverVisited,
    hasPhone,
    hasMobile,
    const DeepCollectionEquality().hash(_selectedFavorabilities),
  );

  /// Create a copy of DashboardFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardFiltersImplCopyWith<_$DashboardFiltersImpl> get copyWith =>
      __$$DashboardFiltersImplCopyWithImpl<_$DashboardFiltersImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardFiltersImplToJson(this);
  }
}

abstract class _DashboardFilters implements DashboardFilters {
  const factory _DashboardFilters({
    final List<String> selectedGeoUnitIds,
    final int? ageMin,
    final int? ageMax,
    final List<String> selectedGenders,
    final List<int> selectedReligionIds,
    final List<int> selectedCasteIds,
    final List<int> selectedEducationIds,
    final bool? isPolled,
    final bool? isDead,
    final bool? isShifted,
    final DateTime? lastVisitedFrom,
    final DateTime? lastVisitedTo,
    final bool neverVisited,
    final bool? hasPhone,
    final bool hasMobile,
    final List<String> selectedFavorabilities,
  }) = _$DashboardFiltersImpl;

  factory _DashboardFilters.fromJson(Map<String, dynamic> json) =
      _$DashboardFiltersImpl.fromJson;

  // Geographic filters
  @override
  List<String> get selectedGeoUnitIds; // Demographics filters
  @override
  int? get ageMin;
  @override
  int? get ageMax;
  @override
  List<String> get selectedGenders;
  @override
  List<int> get selectedReligionIds;
  @override
  List<int> get selectedCasteIds;
  @override
  List<int> get selectedEducationIds; // Status filters
  @override
  bool? get isPolled;
  @override
  bool? get isDead;
  @override
  bool? get isShifted; // Activity filters
  @override
  DateTime? get lastVisitedFrom;
  @override
  DateTime? get lastVisitedTo;
  @override
  bool get neverVisited; // Contact filters
  @override
  bool? get hasPhone;
  @override
  bool get hasMobile; // Favorability filters
  @override
  List<String> get selectedFavorabilities;

  /// Create a copy of DashboardFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardFiltersImplCopyWith<_$DashboardFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
