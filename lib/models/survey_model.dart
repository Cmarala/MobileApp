import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'survey_model.freezed.dart';
part 'survey_model.g.dart';

// ==============================================================================
// 1. ENUMS (Matching DB constraints exactly)
// ==============================================================================

enum SurveyMode {
  @JsonValue('standard_form') standardForm,
  @JsonValue('opinion_poll') opinionPoll,
  @JsonValue('complaint_box') complaintBox,
}

enum TargetContext {
  @JsonValue('none') none,
  @JsonValue('voter') voter,
  @JsonValue('geo_unit') geoUnit,
}

enum QuestionUiType {
  @JsonValue('text_input') textInput,
  @JsonValue('numeric_input') numericInput,
  @JsonValue('radio_list') radioList,
  @JsonValue('checkbox_list') checkboxList,
  @JsonValue('searchable_dropdown') searchableDropdown,
  @JsonValue('searchable_multi_select') searchableMultiSelect,
  @JsonValue('chip_select') chipSelect,
  @JsonValue('image_grid') imageGrid,
  @JsonValue('section_header') sectionHeader,
  @JsonValue('camera_capture') cameraCapture,
  @JsonValue('date_picker') datePicker,
}

// ==============================================================================
// 2. DOMAIN MODELS (Configuration Read-Models)
// ==============================================================================

@freezed
class Survey with _$Survey {
  const Survey._();

  const factory Survey({
    required String id,
    @JsonKey(name: 'campaign_id') required String campaignId,
    required String code,
    required String title,
    @JsonKey(name: 'title_local') String? titleLocal, // New
    String? description,
    @JsonKey(name: 'description_local') String? descriptionLocal, // New
    
    @JsonKey(name: 'survey_mode') 
    @Default(SurveyMode.standardForm) SurveyMode mode,
    
    @JsonKey(name: 'target_context') 
    @Default(TargetContext.none) TargetContext targetContext,

    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt) 
    @Default(true) bool isActive,
    
    @JsonKey(name: 'display_order') @Default(1) int displayOrder,
    
    @JsonKey(name: 'allow_multiple_submissions', fromJson: _boolFromInt, toJson: _boolToInt) 
    @Default(false) bool allowMultipleSubmissions,
    
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt) 
    @Default(false) bool isMandatory,
    
    @Default([]) List<SurveyQuestion> questions,
    @JsonKey(fromJson: _metadataFromJson) @Default({}) Map<String, dynamic> metadata,
  }) = _Survey;

  String getDisplayTitle(bool isEnglish) => 
      isEnglish ? title : (titleLocal?.isNotEmpty == true ? titleLocal! : title);

  String? getDisplayDescription(bool isEnglish) => 
      isEnglish ? description : (descriptionLocal?.isNotEmpty == true ? descriptionLocal! : description);
      
  // Helper getter to check if survey requires voter context
  bool get requiresVoterContext => targetContext == TargetContext.voter;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}

@freezed
class SurveyQuestion with _$SurveyQuestion {
  const SurveyQuestion._();

  const factory SurveyQuestion({
    required String id,
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'survey_id') required String surveyId,
    required String code,
    @JsonKey(name: 'question_text') required String text,
    @JsonKey(name: 'question_text_local') String? textLocal, // New
    
    @JsonKey(name: 'question_ui_type') 
    @Default(QuestionUiType.textInput) QuestionUiType uiType,
    
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt) 
    @Default(false) bool isMandatory,
    
    @JsonKey(name: 'display_order') @Default(1) int displayOrder,
    @Default([]) List<SurveyOption> options,
    @JsonKey(fromJson: _metadataFromJson) @Default({}) Map<String, dynamic> metadata,
  }) = _SurveyQuestion;

  String getDisplayText(bool isEnglish) => 
      isEnglish ? text : (textLocal?.isNotEmpty == true ? textLocal! : text);
      
  // Helper getter to check if this question is a section header
  bool get isHeader => uiType == QuestionUiType.sectionHeader;

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) => _$SurveyQuestionFromJson(json);
}

@freezed
class SurveyOption with _$SurveyOption {
  const SurveyOption._();

  const factory SurveyOption({
    required String id,
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'survey_question_id') required String questionId,
    required String code,
    @JsonKey(name: 'option_text') required String text,
    @JsonKey(name: 'option_text_local') String? textLocal, // New
    
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'display_order') @Default(1) int displayOrder,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt) 
    @Default(true) bool isActive,
  }) = _SurveyOption;

  String getDisplayText(bool isEnglish) => 
      isEnglish ? text : (textLocal?.isNotEmpty == true ? textLocal! : text);

  factory SurveyOption.fromJson(Map<String, dynamic> json) => _$SurveyOptionFromJson(json);
}

// ==============================================================================
// 3. RESPONSE MODELS (Data Capture Write-Models)
// ==============================================================================

@freezed
class SurveyResponse with _$SurveyResponse {
  const SurveyResponse._();

  const factory SurveyResponse({
    String? id, 
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'survey_id') required String surveyId,
    @JsonKey(name: 'geo_unit_id') required String geoUnitId,
    @JsonKey(name: 'voter_id') String? voterId,
    @JsonKey(name: 'respondent_name') String? respondentName,
    @JsonKey(name: 'respondent_phone') String? respondentPhone,
    @Default('completed') String status,
    
    // DB uses TEXT for lat/long strings
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString) double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString) double? longitude,
    
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'client_response_id') String? clientResponseId,
  }) = _SurveyResponse;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) => _$SurveyResponseFromJson(json);
}

@freezed
class SurveyResponseOption with _$SurveyResponseOption {
  const factory SurveyResponseOption({
    String? id, // PowerSync/Supabase will generate a UUID
    
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'survey_response_id') required String responseId,
    @JsonKey(name: 'survey_question_id') required String questionId,
    
    // The ID of the option selected (for Radio/Checkbox/Dropdown)
    @JsonKey(name: 'survey_option_id') String? surveyOptionId, 
    
    // The raw text/number/date entered (for Input fields)
    @JsonKey(name: 'answer_value') String? answerValue, 
    
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _SurveyResponseOption;

  factory SurveyResponseOption.fromJson(Map<String, dynamic> json) => _$SurveyResponseOptionFromJson(json);
}

// --- Shared Conversion Helpers ---

Map<String, dynamic> _metadataFromJson(dynamic value) {
  if (value == null) return {};
  if (value is Map<String, dynamic>) return value;
  if (value is String) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } catch (e) {
      return {};
    }
  }
  return {};
}

bool _boolFromInt(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  return false;
}

int _boolToInt(bool value) => value ? 1 : 0;

double? _doubleFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

String? _doubleToString(double? value) => value?.toString();