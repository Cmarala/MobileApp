// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      langCode: json['langCode'] as String? ?? 'en',
      headerEnabled: json['headerEnabled'] as bool? ?? false,
      footerEnabled: json['footerEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'langCode': instance.langCode,
      'headerEnabled': instance.headerEnabled,
      'footerEnabled': instance.footerEnabled,
    };
