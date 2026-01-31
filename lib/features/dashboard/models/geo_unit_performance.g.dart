// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_unit_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeoUnitPerformanceImpl _$$GeoUnitPerformanceImplFromJson(
  Map<String, dynamic> json,
) => _$GeoUnitPerformanceImpl(
  geoUnitId: json['geoUnitId'] as String? ?? '',
  geoUnitName: json['geoUnitName'] as String? ?? '',
  geoUnitNameLocal: json['geoUnitNameLocal'] as String? ?? '',
  totalVoters: (json['totalVoters'] as num?)?.toInt() ?? 0,
  metricCount: (json['metricCount'] as num?)?.toInt() ?? 0,
  percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$GeoUnitPerformanceImplToJson(
  _$GeoUnitPerformanceImpl instance,
) => <String, dynamic>{
  'geoUnitId': instance.geoUnitId,
  'geoUnitName': instance.geoUnitName,
  'geoUnitNameLocal': instance.geoUnitNameLocal,
  'totalVoters': instance.totalVoters,
  'metricCount': instance.metricCount,
  'percentage': instance.percentage,
};
