// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStatsImpl _$$DashboardStatsImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStatsImpl(
      totalVoters: (json['totalVoters'] as num?)?.toInt() ?? 0,
      contactedToday: (json['contactedToday'] as num?)?.toInt() ?? 0,
      polledVoters: (json['polledVoters'] as num?)?.toInt() ?? 0,
      pendingContacts: (json['pendingContacts'] as num?)?.toInt() ?? 0,
      contactedTodayPercentage:
          (json['contactedTodayPercentage'] as num?)?.toDouble() ?? 0.0,
      polledPercentage: (json['polledPercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DashboardStatsImplToJson(
  _$DashboardStatsImpl instance,
) => <String, dynamic>{
  'totalVoters': instance.totalVoters,
  'contactedToday': instance.contactedToday,
  'polledVoters': instance.polledVoters,
  'pendingContacts': instance.pendingContacts,
  'contactedTodayPercentage': instance.contactedTodayPercentage,
  'polledPercentage': instance.polledPercentage,
};

_$FavorabilityDistributionImpl _$$FavorabilityDistributionImplFromJson(
  Map<String, dynamic> json,
) => _$FavorabilityDistributionImpl(
  favorability: json['favorability'] as String? ?? '',
  favorabilityLocal: json['favorabilityLocal'] as String? ?? '',
  code: json['code'] as String? ?? '',
  count: (json['count'] as num?)?.toInt() ?? 0,
  percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$FavorabilityDistributionImplToJson(
  _$FavorabilityDistributionImpl instance,
) => <String, dynamic>{
  'favorability': instance.favorability,
  'favorabilityLocal': instance.favorabilityLocal,
  'code': instance.code,
  'count': instance.count,
  'percentage': instance.percentage,
};
