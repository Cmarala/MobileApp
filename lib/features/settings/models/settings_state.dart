import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default('en') String langCode, // 'en' or locale-specific code (default English)
    @Default(true) bool headerTextEnabled, // Show/hide section1 text
    @Default(true) bool headerImageEnabled, // Show/hide message_section_1_image
    @Default(true) bool footerEnabled, // Show/hide section3 text
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
}
