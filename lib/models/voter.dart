import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'voter.freezed.dart';
part 'voter.g.dart';

@freezed
class Voter with _$Voter {
  const Voter._(); 

  const factory Voter({
    required String id,
    @JsonKey(name: 'campaign_id') String? campaignId,
    @JsonKey(name: 'geo_unit_id') String? geoUnitId,
    @JsonKey(name: 'epic_id') String? epicId,
    String? vid,
    @JsonKey(name: 'vid_2') String? vid2,
    @JsonKey(name: 'section_number') String? sectionNumber,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(name: 'part_no') String? partNo,
    String? name,
    
    // Bilingual Name Support
    @JsonKey(name: 'name_local') String? nameLocal,
    
    int? age,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson) Gender? gender,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? phone,
    String? email,
    @JsonKey(name: 'house_no') String? houseNo,
    String? address,
    
    // Bilingual Address & Metadata Support
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
    @Default(false)
    bool isDead,
    
    @JsonKey(name: 'is_rented', fromJson: _boolFromInt, toJson: _boolToInt)
    @Default(false)
    bool isRented,
    
    @JsonKey(name: 'is_shifted', fromJson: _boolFromInt, toJson: _boolToInt)
    @Default(false)
    bool isShifted,
    
    @JsonKey(
      fromJson: _favorabilityFromJson,
      toJson: _favorabilityToJson,
    )
    @Default(VoterFavorability.neutral)
    VoterFavorability favorability,
    
    @JsonKey(name: 'last_visited_at') String? lastVisitedAt,
    @JsonKey(name: 'last_visited_by') String? lastVisitedBy,
    
    @JsonKey(name: 'is_deleted', fromJson: _boolFromInt, toJson: _boolToInt)
    @Default(false)
    bool isDeleted,
    
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? metadata,
    @JsonKey(name: 'created_by_user_id') String? createdByUserId,
    @JsonKey(name: 'updated_by_user_id') String? updatedByUserId,
    @JsonKey(name: 'geo_unit_path') String? geoUnitPath,
    String? ancestors,

    // Coordinates: Model uses double?, DB uses TEXT
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString) 
    double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString) 
    double? longitude,
    
    @JsonKey(name: 'geo_address') String? geoAddress,

    // Polling Live fields
    @JsonKey(name: 'is_polled', fromJson: _boolFromInt, toJson: _boolToInt)
    @Default(false)
    bool isPolled,
    @JsonKey(name: 'serial_number') int? serialNumber,
    @JsonKey(name: 'polled_at') String? polledAt,
    @JsonKey(name: 'polled_by_user_id') String? polledByUserId,
  }) = _Voter;

  factory Voter.fromJson(Map<String, dynamic> json) => _$VoterFromJson(json);

  factory Voter.fromMap(Map<String, dynamic> map) => Voter.fromJson(map);

  String getDisplayName(bool isEnglish) {
    if (isEnglish) return name ?? 'Unknown';
    return (nameLocal?.isNotEmpty == true) ? nameLocal! : (name ?? 'Unknown');
  }
}

// --- Helper Converters ---

bool _boolFromInt(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  return false;
}

int _boolToInt(bool value) => value ? 1 : 0;

VoterFavorability _favorabilityFromJson(dynamic value) => VoterFavorability.fromString(value as String?);
String _favorabilityToJson(VoterFavorability favorability) => favorability.toValue();

Gender? _genderFromJson(dynamic value) => Gender.fromString(value as String?);
String? _genderToJson(Gender? gender) => gender?.toValue();

double? _doubleFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

// Serialize double to String for PowerSync TEXT columns
String? _doubleToString(double? value) => value?.toString();