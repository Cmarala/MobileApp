// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      langCode: json['langCode'] as String? ?? 'en',
      headerTextEnabled: json['headerTextEnabled'] as bool? ?? true,
      headerImageEnabled: json['headerImageEnabled'] as bool? ?? true,
      footerEnabled: json['footerEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'langCode': instance.langCode,
      'headerTextEnabled': instance.headerTextEnabled,
      'headerImageEnabled': instance.headerImageEnabled,
      'footerEnabled': instance.footerEnabled,
    };
