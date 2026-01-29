import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default('en') String langCode, // 'en' or locale-specific code (default English)
    @Default(false) bool headerEnabled, // Show/hide header message
    @Default(false) bool footerEnabled, // Show/hide footer message
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
}
