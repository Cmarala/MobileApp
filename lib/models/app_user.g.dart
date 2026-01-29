// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['user_id'] as String,
      userName: json['user_name'] as String?,
      userPhone: json['user_phone'] as String?,
      userRole: json['user_role'] as String?,
      campaignId: json['campaign_id'] as String,
      geoUnitId: json['geo_unit_id'] as String,
      token: json['token'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'user_id': instance.id,
      'user_name': instance.userName,
      'user_phone': instance.userPhone,
      'user_role': instance.userRole,
      'campaign_id': instance.campaignId,
      'geo_unit_id': instance.geoUnitId,
      'token': instance.token,
      'is_active': instance.isActive,
    };
