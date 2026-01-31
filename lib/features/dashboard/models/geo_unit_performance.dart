import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_unit_performance.freezed.dart';
part 'geo_unit_performance.g.dart';

enum PerformanceMetric {
  contacted,
  polled,
}

@freezed
class GeoUnitPerformance with _$GeoUnitPerformance {
  const factory GeoUnitPerformance({
    @Default('') String geoUnitId,
    @Default('') String geoUnitName,
    @Default('') String geoUnitNameLocal,
    @Default(0) int totalVoters,
    @Default(0) int metricCount,
    @Default(0.0) double percentage,
  }) = _GeoUnitPerformance;

  factory GeoUnitPerformance.fromJson(Map<String, dynamic> json) =>
      _$GeoUnitPerformanceFromJson(json);
}
