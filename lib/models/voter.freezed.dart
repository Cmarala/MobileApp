// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Voter _$VoterFromJson(Map<String, dynamic> json) {
  return _Voter.fromJson(json);
}

/// @nodoc
mixin _$Voter {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String? get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'geo_unit_id')
  String? get geoUnitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'epic_id')
  String? get epicId => throw _privateConstructorUsedError;
  String? get vid => throw _privateConstructorUsedError;
  @JsonKey(name: 'vid_2')
  String? get vid2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_number')
  String? get sectionNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_name')
  String? get sectionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'part_no')
  String? get partNo => throw _privateConstructorUsedError;
  String? get name =>
      throw _privateConstructorUsedError; // Bilingual Name Support
  @JsonKey(name: 'name_local')
  String? get nameLocal => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  Gender? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get birthDate => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'house_no')
  String? get houseNo => throw _privateConstructorUsedError;
  String? get address =>
      throw _privateConstructorUsedError; // Bilingual Address & Metadata Support
  @JsonKey(name: 'address_local')
  String? get addressLocal => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_name_local')
  String? get sectionNameLocal => throw _privateConstructorUsedError;
  @JsonKey(name: 'relation_name_local')
  String? get relationNameLocal => throw _privateConstructorUsedError;
  @JsonKey(name: 'religion_id')
  int? get religionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'caste_id')
  int? get casteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_caste_id')
  int? get subCasteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'education_id')
  int? get educationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'occupation_id')
  int? get occupationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'relation_name')
  String? get relationName => throw _privateConstructorUsedError;
  String? get relation => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isDead => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isRented => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isShifted => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
  VoterFavorability get favorability => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_visited_at')
  String? get lastVisitedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_visited_by')
  String? get lastVisitedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get metadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by_user_id')
  String? get createdByUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_by_user_id')
  String? get updatedByUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'geo_unit_path')
  String? get geoUnitPath => throw _privateConstructorUsedError;
  String? get ancestors =>
      throw _privateConstructorUsedError; // Coordinates: Model uses double?, DB uses TEXT
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'geo_address')
  String? get geoAddress => throw _privateConstructorUsedError; // Polling Live fields
  @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isPolled => throw _privateConstructorUsedError;
  @JsonKey(name: 'serial_number')
  int? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'polled_at')
  String? get polledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'polled_by_user_id')
  String? get polledByUserId => throw _privateConstructorUsedError;

  /// Serializes this Voter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Voter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoterCopyWith<Voter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoterCopyWith<$Res> {
  factory $VoterCopyWith(Voter value, $Res Function(Voter) then) =
      _$VoterCopyWithImpl<$Res, Voter>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String? campaignId,
    @JsonKey(name: 'geo_unit_id') String? geoUnitId,
    @JsonKey(name: 'epic_id') String? epicId,
    String? vid,
    @JsonKey(name: 'vid_2') String? vid2,
    @JsonKey(name: 'section_number') String? sectionNumber,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(name: 'part_no') String? partNo,
    String? name,
    @JsonKey(name: 'name_local') String? nameLocal,
    int? age,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson) Gender? gender,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? phone,
    String? email,
    @JsonKey(name: 'house_no') String? houseNo,
    String? address,
    @JsonKey(name: 'address_local') String? addressLocal,
    @JsonKey(name: 'section_name_local') String? sectionNameLocal,
    @JsonKey(name: 'relation_name_local') String? relationNameLocal,
    @JsonKey(name: 'religion_id') int? religionId,
    @JsonKey(name: 'caste_id') int? casteId,
    @JsonKey(name: 'sub_caste_id') int? subCasteId,
    @JsonKey(name: 'education_id') int? educationId,
    @JsonKey(name: 'occupation_id') int? occupationId,
    @JsonKey(name: 'relation_name') String? relationName,
    String? relation,
    @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isDead,
    @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isRented,
    @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isShifted,
    @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
    VoterFavorability favorability,
    @JsonKey(name: 'last_visited_at') String? lastVisitedAt,
    @JsonKey(name: 'last_visited_by') String? lastVisitedBy,
    @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isDeleted,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? metadata,
    @JsonKey(name: 'created_by_user_id') String? createdByUserId,
    @JsonKey(name: 'updated_by_user_id') String? updatedByUserId,
    @JsonKey(name: 'geo_unit_path') String? geoUnitPath,
    String? ancestors,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? longitude,
    @JsonKey(name: 'geo_address') String? geoAddress,
    @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isPolled,
    @JsonKey(name: 'serial_number') int? serialNumber,
    @JsonKey(name: 'polled_at') String? polledAt,
    @JsonKey(name: 'polled_by_user_id') String? polledByUserId,
  });
}

/// @nodoc
class _$VoterCopyWithImpl<$Res, $Val extends Voter>
    implements $VoterCopyWith<$Res> {
  _$VoterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Voter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = freezed,
    Object? geoUnitId = freezed,
    Object? epicId = freezed,
    Object? vid = freezed,
    Object? vid2 = freezed,
    Object? sectionNumber = freezed,
    Object? sectionName = freezed,
    Object? partNo = freezed,
    Object? name = freezed,
    Object? nameLocal = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? houseNo = freezed,
    Object? address = freezed,
    Object? addressLocal = freezed,
    Object? sectionNameLocal = freezed,
    Object? relationNameLocal = freezed,
    Object? religionId = freezed,
    Object? casteId = freezed,
    Object? subCasteId = freezed,
    Object? educationId = freezed,
    Object? occupationId = freezed,
    Object? relationName = freezed,
    Object? relation = freezed,
    Object? isDead = null,
    Object? isRented = null,
    Object? isShifted = null,
    Object? favorability = null,
    Object? lastVisitedAt = freezed,
    Object? lastVisitedBy = freezed,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = freezed,
    Object? createdByUserId = freezed,
    Object? updatedByUserId = freezed,
    Object? geoUnitPath = freezed,
    Object? ancestors = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? geoAddress = freezed,
    Object? isPolled = null,
    Object? serialNumber = freezed,
    Object? polledAt = freezed,
    Object? polledByUserId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: freezed == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
            geoUnitId: freezed == geoUnitId
                ? _value.geoUnitId
                : geoUnitId // ignore: cast_nullable_to_non_nullable
                      as String?,
            epicId: freezed == epicId
                ? _value.epicId
                : epicId // ignore: cast_nullable_to_non_nullable
                      as String?,
            vid: freezed == vid
                ? _value.vid
                : vid // ignore: cast_nullable_to_non_nullable
                      as String?,
            vid2: freezed == vid2
                ? _value.vid2
                : vid2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            sectionNumber: freezed == sectionNumber
                ? _value.sectionNumber
                : sectionNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            sectionName: freezed == sectionName
                ? _value.sectionName
                : sectionName // ignore: cast_nullable_to_non_nullable
                      as String?,
            partNo: freezed == partNo
                ? _value.partNo
                : partNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            nameLocal: freezed == nameLocal
                ? _value.nameLocal
                : nameLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            age: freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as Gender?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            houseNo: freezed == houseNo
                ? _value.houseNo
                : houseNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressLocal: freezed == addressLocal
                ? _value.addressLocal
                : addressLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            sectionNameLocal: freezed == sectionNameLocal
                ? _value.sectionNameLocal
                : sectionNameLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            relationNameLocal: freezed == relationNameLocal
                ? _value.relationNameLocal
                : relationNameLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            religionId: freezed == religionId
                ? _value.religionId
                : religionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            casteId: freezed == casteId
                ? _value.casteId
                : casteId // ignore: cast_nullable_to_non_nullable
                      as int?,
            subCasteId: freezed == subCasteId
                ? _value.subCasteId
                : subCasteId // ignore: cast_nullable_to_non_nullable
                      as int?,
            educationId: freezed == educationId
                ? _value.educationId
                : educationId // ignore: cast_nullable_to_non_nullable
                      as int?,
            occupationId: freezed == occupationId
                ? _value.occupationId
                : occupationId // ignore: cast_nullable_to_non_nullable
                      as int?,
            relationName: freezed == relationName
                ? _value.relationName
                : relationName // ignore: cast_nullable_to_non_nullable
                      as String?,
            relation: freezed == relation
                ? _value.relation
                : relation // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDead: null == isDead
                ? _value.isDead
                : isDead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRented: null == isRented
                ? _value.isRented
                : isRented // ignore: cast_nullable_to_non_nullable
                      as bool,
            isShifted: null == isShifted
                ? _value.isShifted
                : isShifted // ignore: cast_nullable_to_non_nullable
                      as bool,
            favorability: null == favorability
                ? _value.favorability
                : favorability // ignore: cast_nullable_to_non_nullable
                      as VoterFavorability,
            lastVisitedAt: freezed == lastVisitedAt
                ? _value.lastVisitedAt
                : lastVisitedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastVisitedBy: freezed == lastVisitedBy
                ? _value.lastVisitedBy
                : lastVisitedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdByUserId: freezed == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedByUserId: freezed == updatedByUserId
                ? _value.updatedByUserId
                : updatedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            geoUnitPath: freezed == geoUnitPath
                ? _value.geoUnitPath
                : geoUnitPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            ancestors: freezed == ancestors
                ? _value.ancestors
                : ancestors // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            geoAddress: freezed == geoAddress
                ? _value.geoAddress
                : geoAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPolled: null == isPolled
                ? _value.isPolled
                : isPolled // ignore: cast_nullable_to_non_nullable
                      as bool,
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            polledAt: freezed == polledAt
                ? _value.polledAt
                : polledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            polledByUserId: freezed == polledByUserId
                ? _value.polledByUserId
                : polledByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VoterImplCopyWith<$Res> implements $VoterCopyWith<$Res> {
  factory _$$VoterImplCopyWith(
    _$VoterImpl value,
    $Res Function(_$VoterImpl) then,
  ) = __$$VoterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String? campaignId,
    @JsonKey(name: 'geo_unit_id') String? geoUnitId,
    @JsonKey(name: 'epic_id') String? epicId,
    String? vid,
    @JsonKey(name: 'vid_2') String? vid2,
    @JsonKey(name: 'section_number') String? sectionNumber,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(name: 'part_no') String? partNo,
    String? name,
    @JsonKey(name: 'name_local') String? nameLocal,
    int? age,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson) Gender? gender,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? phone,
    String? email,
    @JsonKey(name: 'house_no') String? houseNo,
    String? address,
    @JsonKey(name: 'address_local') String? addressLocal,
    @JsonKey(name: 'section_name_local') String? sectionNameLocal,
    @JsonKey(name: 'relation_name_local') String? relationNameLocal,
    @JsonKey(name: 'religion_id') int? religionId,
    @JsonKey(name: 'caste_id') int? casteId,
    @JsonKey(name: 'sub_caste_id') int? subCasteId,
    @JsonKey(name: 'education_id') int? educationId,
    @JsonKey(name: 'occupation_id') int? occupationId,
    @JsonKey(name: 'relation_name') String? relationName,
    String? relation,
    @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isDead,
    @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isRented,
    @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isShifted,
    @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
    VoterFavorability favorability,
    @JsonKey(name: 'last_visited_at') String? lastVisitedAt,
    @JsonKey(name: 'last_visited_by') String? lastVisitedBy,
    @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isDeleted,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? metadata,
    @JsonKey(name: 'created_by_user_id') String? createdByUserId,
    @JsonKey(name: 'updated_by_user_id') String? updatedByUserId,
    @JsonKey(name: 'geo_unit_path') String? geoUnitPath,
    String? ancestors,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? longitude,
    @JsonKey(name: 'geo_address') String? geoAddress,
    @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isPolled,
    @JsonKey(name: 'serial_number') int? serialNumber,
    @JsonKey(name: 'polled_at') String? polledAt,
    @JsonKey(name: 'polled_by_user_id') String? polledByUserId,
  });
}

/// @nodoc
class __$$VoterImplCopyWithImpl<$Res>
    extends _$VoterCopyWithImpl<$Res, _$VoterImpl>
    implements _$$VoterImplCopyWith<$Res> {
  __$$VoterImplCopyWithImpl(
    _$VoterImpl _value,
    $Res Function(_$VoterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Voter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = freezed,
    Object? geoUnitId = freezed,
    Object? epicId = freezed,
    Object? vid = freezed,
    Object? vid2 = freezed,
    Object? sectionNumber = freezed,
    Object? sectionName = freezed,
    Object? partNo = freezed,
    Object? name = freezed,
    Object? nameLocal = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? houseNo = freezed,
    Object? address = freezed,
    Object? addressLocal = freezed,
    Object? sectionNameLocal = freezed,
    Object? relationNameLocal = freezed,
    Object? religionId = freezed,
    Object? casteId = freezed,
    Object? subCasteId = freezed,
    Object? educationId = freezed,
    Object? occupationId = freezed,
    Object? relationName = freezed,
    Object? relation = freezed,
    Object? isDead = null,
    Object? isRented = null,
    Object? isShifted = null,
    Object? favorability = null,
    Object? lastVisitedAt = freezed,
    Object? lastVisitedBy = freezed,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = freezed,
    Object? createdByUserId = freezed,
    Object? updatedByUserId = freezed,
    Object? geoUnitPath = freezed,
    Object? ancestors = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? geoAddress = freezed,
    Object? isPolled = null,
    Object? serialNumber = freezed,
    Object? polledAt = freezed,
    Object? polledByUserId = freezed,
  }) {
    return _then(
      _$VoterImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: freezed == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
        geoUnitId: freezed == geoUnitId
            ? _value.geoUnitId
            : geoUnitId // ignore: cast_nullable_to_non_nullable
                  as String?,
        epicId: freezed == epicId
            ? _value.epicId
            : epicId // ignore: cast_nullable_to_non_nullable
                  as String?,
        vid: freezed == vid
            ? _value.vid
            : vid // ignore: cast_nullable_to_non_nullable
                  as String?,
        vid2: freezed == vid2
            ? _value.vid2
            : vid2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        sectionNumber: freezed == sectionNumber
            ? _value.sectionNumber
            : sectionNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        sectionName: freezed == sectionName
            ? _value.sectionName
            : sectionName // ignore: cast_nullable_to_non_nullable
                  as String?,
        partNo: freezed == partNo
            ? _value.partNo
            : partNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        nameLocal: freezed == nameLocal
            ? _value.nameLocal
            : nameLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        age: freezed == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as Gender?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        houseNo: freezed == houseNo
            ? _value.houseNo
            : houseNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressLocal: freezed == addressLocal
            ? _value.addressLocal
            : addressLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        sectionNameLocal: freezed == sectionNameLocal
            ? _value.sectionNameLocal
            : sectionNameLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        relationNameLocal: freezed == relationNameLocal
            ? _value.relationNameLocal
            : relationNameLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        religionId: freezed == religionId
            ? _value.religionId
            : religionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        casteId: freezed == casteId
            ? _value.casteId
            : casteId // ignore: cast_nullable_to_non_nullable
                  as int?,
        subCasteId: freezed == subCasteId
            ? _value.subCasteId
            : subCasteId // ignore: cast_nullable_to_non_nullable
                  as int?,
        educationId: freezed == educationId
            ? _value.educationId
            : educationId // ignore: cast_nullable_to_non_nullable
                  as int?,
        occupationId: freezed == occupationId
            ? _value.occupationId
            : occupationId // ignore: cast_nullable_to_non_nullable
                  as int?,
        relationName: freezed == relationName
            ? _value.relationName
            : relationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        relation: freezed == relation
            ? _value.relation
            : relation // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDead: null == isDead
            ? _value.isDead
            : isDead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRented: null == isRented
            ? _value.isRented
            : isRented // ignore: cast_nullable_to_non_nullable
                  as bool,
        isShifted: null == isShifted
            ? _value.isShifted
            : isShifted // ignore: cast_nullable_to_non_nullable
                  as bool,
        favorability: null == favorability
            ? _value.favorability
            : favorability // ignore: cast_nullable_to_non_nullable
                  as VoterFavorability,
        lastVisitedAt: freezed == lastVisitedAt
            ? _value.lastVisitedAt
            : lastVisitedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastVisitedBy: freezed == lastVisitedBy
            ? _value.lastVisitedBy
            : lastVisitedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: freezed == metadata
            ? _value.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdByUserId: freezed == createdByUserId
            ? _value.createdByUserId
            : createdByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedByUserId: freezed == updatedByUserId
            ? _value.updatedByUserId
            : updatedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        geoUnitPath: freezed == geoUnitPath
            ? _value.geoUnitPath
            : geoUnitPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        ancestors: freezed == ancestors
            ? _value.ancestors
            : ancestors // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        geoAddress: freezed == geoAddress
            ? _value.geoAddress
            : geoAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPolled: null == isPolled
            ? _value.isPolled
            : isPolled // ignore: cast_nullable_to_non_nullable
                  as bool,
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        polledAt: freezed == polledAt
            ? _value.polledAt
            : polledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        polledByUserId: freezed == polledByUserId
            ? _value.polledByUserId
            : polledByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VoterImpl extends _Voter {
  const _$VoterImpl({
    required this.id,
    @JsonKey(name: 'campaign_id') this.campaignId,
    @JsonKey(name: 'geo_unit_id') this.geoUnitId,
    @JsonKey(name: 'epic_id') this.epicId,
    this.vid,
    @JsonKey(name: 'vid_2') this.vid2,
    @JsonKey(name: 'section_number') this.sectionNumber,
    @JsonKey(name: 'section_name') this.sectionName,
    @JsonKey(name: 'part_no') this.partNo,
    this.name,
    @JsonKey(name: 'name_local') this.nameLocal,
    this.age,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson) this.gender,
    @JsonKey(name: 'birth_date') this.birthDate,
    this.phone,
    this.email,
    @JsonKey(name: 'house_no') this.houseNo,
    this.address,
    @JsonKey(name: 'address_local') this.addressLocal,
    @JsonKey(name: 'section_name_local') this.sectionNameLocal,
    @JsonKey(name: 'relation_name_local') this.relationNameLocal,
    @JsonKey(name: 'religion_id') this.religionId,
    @JsonKey(name: 'caste_id') this.casteId,
    @JsonKey(name: 'sub_caste_id') this.subCasteId,
    @JsonKey(name: 'education_id') this.educationId,
    @JsonKey(name: 'occupation_id') this.occupationId,
    @JsonKey(name: 'relation_name') this.relationName,
    this.relation,
    @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isDead = false,
    @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isRented = false,
    @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isShifted = false,
    @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
    this.favorability = VoterFavorability.neutral,
    @JsonKey(name: 'last_visited_at') this.lastVisitedAt,
    @JsonKey(name: 'last_visited_by') this.lastVisitedBy,
    @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isDeleted = false,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    this.metadata,
    @JsonKey(name: 'created_by_user_id') this.createdByUserId,
    @JsonKey(name: 'updated_by_user_id') this.updatedByUserId,
    @JsonKey(name: 'geo_unit_path') this.geoUnitPath,
    this.ancestors,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    this.latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    this.longitude,
    @JsonKey(name: 'geo_address') this.geoAddress,
    @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isPolled = false,
    @JsonKey(name: 'serial_number') this.serialNumber,
    @JsonKey(name: 'polled_at') this.polledAt,
    @JsonKey(name: 'polled_by_user_id') this.polledByUserId,
  }) : super._();

  factory _$VoterImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoterImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'campaign_id')
  final String? campaignId;
  @override
  @JsonKey(name: 'geo_unit_id')
  final String? geoUnitId;
  @override
  @JsonKey(name: 'epic_id')
  final String? epicId;
  @override
  final String? vid;
  @override
  @JsonKey(name: 'vid_2')
  final String? vid2;
  @override
  @JsonKey(name: 'section_number')
  final String? sectionNumber;
  @override
  @JsonKey(name: 'section_name')
  final String? sectionName;
  @override
  @JsonKey(name: 'part_no')
  final String? partNo;
  @override
  final String? name;
  // Bilingual Name Support
  @override
  @JsonKey(name: 'name_local')
  final String? nameLocal;
  @override
  final int? age;
  @override
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  final Gender? gender;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'house_no')
  final String? houseNo;
  @override
  final String? address;
  // Bilingual Address & Metadata Support
  @override
  @JsonKey(name: 'address_local')
  final String? addressLocal;
  @override
  @JsonKey(name: 'section_name_local')
  final String? sectionNameLocal;
  @override
  @JsonKey(name: 'relation_name_local')
  final String? relationNameLocal;
  @override
  @JsonKey(name: 'religion_id')
  final int? religionId;
  @override
  @JsonKey(name: 'caste_id')
  final int? casteId;
  @override
  @JsonKey(name: 'sub_caste_id')
  final int? subCasteId;
  @override
  @JsonKey(name: 'education_id')
  final int? educationId;
  @override
  @JsonKey(name: 'occupation_id')
  final int? occupationId;
  @override
  @JsonKey(name: 'relation_name')
  final String? relationName;
  @override
  final String? relation;
  @override
  @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isDead;
  @override
  @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isRented;
  @override
  @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isShifted;
  @override
  @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
  final VoterFavorability favorability;
  @override
  @JsonKey(name: 'last_visited_at')
  final String? lastVisitedAt;
  @override
  @JsonKey(name: 'last_visited_by')
  final String? lastVisitedBy;
  @override
  @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isDeleted;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final String? metadata;
  @override
  @JsonKey(name: 'created_by_user_id')
  final String? createdByUserId;
  @override
  @JsonKey(name: 'updated_by_user_id')
  final String? updatedByUserId;
  @override
  @JsonKey(name: 'geo_unit_path')
  final String? geoUnitPath;
  @override
  final String? ancestors;
  // Coordinates: Model uses double?, DB uses TEXT
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  final double? latitude;
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  final double? longitude;
  @override
  @JsonKey(name: 'geo_address')
  final String? geoAddress;
  // Polling Live fields
  @override
  @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isPolled;
  @override
  @JsonKey(name: 'serial_number')
  final int? serialNumber;
  @override
  @JsonKey(name: 'polled_at')
  final String? polledAt;
  @override
  @JsonKey(name: 'polled_by_user_id')
  final String? polledByUserId;

  @override
  String toString() {
    return 'Voter(id: $id, campaignId: $campaignId, geoUnitId: $geoUnitId, epicId: $epicId, vid: $vid, vid2: $vid2, sectionNumber: $sectionNumber, sectionName: $sectionName, partNo: $partNo, name: $name, nameLocal: $nameLocal, age: $age, gender: $gender, birthDate: $birthDate, phone: $phone, email: $email, houseNo: $houseNo, address: $address, addressLocal: $addressLocal, sectionNameLocal: $sectionNameLocal, relationNameLocal: $relationNameLocal, religionId: $religionId, casteId: $casteId, subCasteId: $subCasteId, educationId: $educationId, occupationId: $occupationId, relationName: $relationName, relation: $relation, isDead: $isDead, isRented: $isRented, isShifted: $isShifted, favorability: $favorability, lastVisitedAt: $lastVisitedAt, lastVisitedBy: $lastVisitedBy, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata, createdByUserId: $createdByUserId, updatedByUserId: $updatedByUserId, geoUnitPath: $geoUnitPath, ancestors: $ancestors, latitude: $latitude, longitude: $longitude, geoAddress: $geoAddress, isPolled: $isPolled, serialNumber: $serialNumber, polledAt: $polledAt, polledByUserId: $polledByUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.geoUnitId, geoUnitId) ||
                other.geoUnitId == geoUnitId) &&
            (identical(other.epicId, epicId) || other.epicId == epicId) &&
            (identical(other.vid, vid) || other.vid == vid) &&
            (identical(other.vid2, vid2) || other.vid2 == vid2) &&
            (identical(other.sectionNumber, sectionNumber) ||
                other.sectionNumber == sectionNumber) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.partNo, partNo) || other.partNo == partNo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameLocal, nameLocal) ||
                other.nameLocal == nameLocal) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.houseNo, houseNo) || other.houseNo == houseNo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressLocal, addressLocal) ||
                other.addressLocal == addressLocal) &&
            (identical(other.sectionNameLocal, sectionNameLocal) ||
                other.sectionNameLocal == sectionNameLocal) &&
            (identical(other.relationNameLocal, relationNameLocal) ||
                other.relationNameLocal == relationNameLocal) &&
            (identical(other.religionId, religionId) ||
                other.religionId == religionId) &&
            (identical(other.casteId, casteId) || other.casteId == casteId) &&
            (identical(other.subCasteId, subCasteId) ||
                other.subCasteId == subCasteId) &&
            (identical(other.educationId, educationId) ||
                other.educationId == educationId) &&
            (identical(other.occupationId, occupationId) ||
                other.occupationId == occupationId) &&
            (identical(other.relationName, relationName) ||
                other.relationName == relationName) &&
            (identical(other.relation, relation) ||
                other.relation == relation) &&
            (identical(other.isDead, isDead) || other.isDead == isDead) &&
            (identical(other.isRented, isRented) ||
                other.isRented == isRented) &&
            (identical(other.isShifted, isShifted) ||
                other.isShifted == isShifted) &&
            (identical(other.favorability, favorability) ||
                other.favorability == favorability) &&
            (identical(other.lastVisitedAt, lastVisitedAt) ||
                other.lastVisitedAt == lastVisitedAt) &&
            (identical(other.lastVisitedBy, lastVisitedBy) ||
                other.lastVisitedBy == lastVisitedBy) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.createdByUserId, createdByUserId) ||
                other.createdByUserId == createdByUserId) &&
            (identical(other.updatedByUserId, updatedByUserId) ||
                other.updatedByUserId == updatedByUserId) &&
            (identical(other.geoUnitPath, geoUnitPath) ||
                other.geoUnitPath == geoUnitPath) &&
            (identical(other.ancestors, ancestors) ||
                other.ancestors == ancestors) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.geoAddress, geoAddress) ||
                other.geoAddress == geoAddress) &&
            (identical(other.isPolled, isPolled) ||
                other.isPolled == isPolled) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.polledAt, polledAt) ||
                other.polledAt == polledAt) &&
            (identical(other.polledByUserId, polledByUserId) ||
                other.polledByUserId == polledByUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    campaignId,
    geoUnitId,
    epicId,
    vid,
    vid2,
    sectionNumber,
    sectionName,
    partNo,
    name,
    nameLocal,
    age,
    gender,
    birthDate,
    phone,
    email,
    houseNo,
    address,
    addressLocal,
    sectionNameLocal,
    relationNameLocal,
    religionId,
    casteId,
    subCasteId,
    educationId,
    occupationId,
    relationName,
    relation,
    isDead,
    isRented,
    isShifted,
    favorability,
    lastVisitedAt,
    lastVisitedBy,
    isDeleted,
    createdAt,
    updatedAt,
    metadata,
    createdByUserId,
    updatedByUserId,
    geoUnitPath,
    ancestors,
    latitude,
    longitude,
    geoAddress,
    isPolled,
    serialNumber,
    polledAt,
    polledByUserId,
  ]);

  /// Create a copy of Voter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoterImplCopyWith<_$VoterImpl> get copyWith =>
      __$$VoterImplCopyWithImpl<_$VoterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoterImplToJson(this);
  }
}

abstract class _Voter extends Voter {
  const factory _Voter({
    required final String id,
    @JsonKey(name: 'campaign_id') final String? campaignId,
    @JsonKey(name: 'geo_unit_id') final String? geoUnitId,
    @JsonKey(name: 'epic_id') final String? epicId,
    final String? vid,
    @JsonKey(name: 'vid_2') final String? vid2,
    @JsonKey(name: 'section_number') final String? sectionNumber,
    @JsonKey(name: 'section_name') final String? sectionName,
    @JsonKey(name: 'part_no') final String? partNo,
    final String? name,
    @JsonKey(name: 'name_local') final String? nameLocal,
    final int? age,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
    final Gender? gender,
    @JsonKey(name: 'birth_date') final String? birthDate,
    final String? phone,
    final String? email,
    @JsonKey(name: 'house_no') final String? houseNo,
    final String? address,
    @JsonKey(name: 'address_local') final String? addressLocal,
    @JsonKey(name: 'section_name_local') final String? sectionNameLocal,
    @JsonKey(name: 'relation_name_local') final String? relationNameLocal,
    @JsonKey(name: 'religion_id') final int? religionId,
    @JsonKey(name: 'caste_id') final int? casteId,
    @JsonKey(name: 'sub_caste_id') final int? subCasteId,
    @JsonKey(name: 'education_id') final int? educationId,
    @JsonKey(name: 'occupation_id') final int? occupationId,
    @JsonKey(name: 'relation_name') final String? relationName,
    final String? relation,
    @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isDead,
    @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isRented,
    @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isShifted,
    @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
    final VoterFavorability favorability,
    @JsonKey(name: 'last_visited_at') final String? lastVisitedAt,
    @JsonKey(name: 'last_visited_by') final String? lastVisitedBy,
    @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isDeleted,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    final String? metadata,
    @JsonKey(name: 'created_by_user_id') final String? createdByUserId,
    @JsonKey(name: 'updated_by_user_id') final String? updatedByUserId,
    @JsonKey(name: 'geo_unit_path') final String? geoUnitPath,
    final String? ancestors,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    final double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    final double? longitude,
    @JsonKey(name: 'geo_address') final String? geoAddress,
    @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isPolled,
    @JsonKey(name: 'serial_number') final int? serialNumber,
    @JsonKey(name: 'polled_at') final String? polledAt,
    @JsonKey(name: 'polled_by_user_id') final String? polledByUserId,
  }) = _$VoterImpl;
  const _Voter._() : super._();

  factory _Voter.fromJson(Map<String, dynamic> json) = _$VoterImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'campaign_id')
  String? get campaignId;
  @override
  @JsonKey(name: 'geo_unit_id')
  String? get geoUnitId;
  @override
  @JsonKey(name: 'epic_id')
  String? get epicId;
  @override
  String? get vid;
  @override
  @JsonKey(name: 'vid_2')
  String? get vid2;
  @override
  @JsonKey(name: 'section_number')
  String? get sectionNumber;
  @override
  @JsonKey(name: 'section_name')
  String? get sectionName;
  @override
  @JsonKey(name: 'part_no')
  String? get partNo;
  @override
  String? get name; // Bilingual Name Support
  @override
  @JsonKey(name: 'name_local')
  String? get nameLocal;
  @override
  int? get age;
  @override
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  Gender? get gender;
  @override
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'house_no')
  String? get houseNo;
  @override
  String? get address; // Bilingual Address & Metadata Support
  @override
  @JsonKey(name: 'address_local')
  String? get addressLocal;
  @override
  @JsonKey(name: 'section_name_local')
  String? get sectionNameLocal;
  @override
  @JsonKey(name: 'relation_name_local')
  String? get relationNameLocal;
  @override
  @JsonKey(name: 'religion_id')
  int? get religionId;
  @override
  @JsonKey(name: 'caste_id')
  int? get casteId;
  @override
  @JsonKey(name: 'sub_caste_id')
  int? get subCasteId;
  @override
  @JsonKey(name: 'education_id')
  int? get educationId;
  @override
  @JsonKey(name: 'occupation_id')
  int? get occupationId;
  @override
  @JsonKey(name: 'relation_name')
  String? get relationName;
  @override
  String? get relation;
  @override
  @JsonKey(name: 'is_dead', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isDead;
  @override
  @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isRented;
  @override
  @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isShifted;
  @override
  @JsonKey(fromJson: _favorabilityFromJson, toJson: _favorabilityToJson)
  VoterFavorability get favorability;
  @override
  @JsonKey(name: 'last_visited_at')
  String? get lastVisitedAt;
  @override
  @JsonKey(name: 'last_visited_by')
  String? get lastVisitedBy;
  @override
  @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isDeleted;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  String? get metadata;
  @override
  @JsonKey(name: 'created_by_user_id')
  String? get createdByUserId;
  @override
  @JsonKey(name: 'updated_by_user_id')
  String? get updatedByUserId;
  @override
  @JsonKey(name: 'geo_unit_path')
  String? get geoUnitPath;
  @override
  String? get ancestors; // Coordinates: Model uses double?, DB uses TEXT
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get latitude;
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get longitude;
  @override
  @JsonKey(name: 'geo_address')
  String? get geoAddress; // Polling Live fields
  @override
  @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isPolled;
  @override
  @JsonKey(name: 'serial_number')
  int? get serialNumber;
  @override
  @JsonKey(name: 'polled_at')
  String? get polledAt;
  @override
  @JsonKey(name: 'polled_by_user_id')
  String? get polledByUserId;

  /// Create a copy of Voter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoterImplCopyWith<_$VoterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
