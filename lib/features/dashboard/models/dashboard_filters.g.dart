// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardFiltersImpl _$$DashboardFiltersImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardFiltersImpl(
  selectedGeoUnitIds:
      (json['selectedGeoUnitIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  ageMin: (json['ageMin'] as num?)?.toInt(),
  ageMax: (json['ageMax'] as num?)?.toInt(),
  selectedGenders:
      (json['selectedGenders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  selectedReligionIds:
      (json['selectedReligionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  selectedCasteIds:
      (json['selectedCasteIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  selectedEducationIds:
      (json['selectedEducationIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  isPolled: json['isPolled'] as bool?,
  isDead: json['isDead'] as bool?,
  isShifted: json['isShifted'] as bool?,
  lastVisitedFrom: json['lastVisitedFrom'] == null
      ? null
      : DateTime.parse(json['lastVisitedFrom'] as String),
  lastVisitedTo: json['lastVisitedTo'] == null
      ? null
      : DateTime.parse(json['lastVisitedTo'] as String),
  neverVisited: json['neverVisited'] as bool? ?? false,
  hasPhone: json['hasPhone'] as bool?,
  hasMobile: json['hasMobile'] as bool? ?? false,
  selectedFavorabilities:
      (json['selectedFavorabilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DashboardFiltersImplToJson(
  _$DashboardFiltersImpl instance,
) => <String, dynamic>{
  'selectedGeoUnitIds': instance.selectedGeoUnitIds,
  'ageMin': instance.ageMin,
  'ageMax': instance.ageMax,
  'selectedGenders': instance.selectedGenders,
  'selectedReligionIds': instance.selectedReligionIds,
  'selectedCasteIds': instance.selectedCasteIds,
  'selectedEducationIds': instance.selectedEducationIds,
  'isPolled': instance.isPolled,
  'isDead': instance.isDead,
  'isShifted': instance.isShifted,
  'lastVisitedFrom': instance.lastVisitedFrom?.toIso8601String(),
  'lastVisitedTo': instance.lastVisitedTo?.toIso8601String(),
  'neverVisited': instance.neverVisited,
  'hasPhone': instance.hasPhone,
  'hasMobile': instance.hasMobile,
  'selectedFavorabilities': instance.selectedFavorabilities,
};
