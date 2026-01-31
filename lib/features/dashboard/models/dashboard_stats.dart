import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';
part 'dashboard_stats.g.dart';

@freezed
class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    @Default(0) int totalVoters,
    @Default(0) int contactedToday,
    @Default(0) int polledVoters,
    @Default(0) int pendingContacts,
    @Default(0.0) double contactedTodayPercentage,
    @Default(0.0) double polledPercentage,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

@freezed
class FavorabilityDistribution with _$FavorabilityDistribution {
  const factory FavorabilityDistribution({
    @Default('') String favorability,
    @Default('') String favorabilityLocal,
    @Default('') String code,
    @Default(0) int count,
    @Default(0.0) double percentage,
  }) = _FavorabilityDistribution;

  factory FavorabilityDistribution.fromJson(Map<String, dynamic> json) =>
      _$FavorabilityDistributionFromJson(json);
}
