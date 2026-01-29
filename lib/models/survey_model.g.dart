// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurveyImpl _$$SurveyImplFromJson(Map<String, dynamic> json) => _$SurveyImpl(
  id: json['id'] as String,
  campaignId: json['campaign_id'] as String,
  code: json['code'] as String,
  title: json['title'] as String,
  titleLocal: json['title_local'] as String?,
  description: json['description'] as String?,
  descriptionLocal: json['description_local'] as String?,
  mode:
      $enumDecodeNullable(_$SurveyModeEnumMap, json['survey_mode']) ??
      SurveyMode.standardForm,
  targetContext:
      $enumDecodeNullable(_$TargetContextEnumMap, json['target_context']) ??
      TargetContext.none,
  isActive: json['is_active'] == null ? true : _boolFromInt(json['is_active']),
  displayOrder: (json['display_order'] as num?)?.toInt() ?? 1,
  allowMultipleSubmissions: json['allow_multiple_submissions'] == null
      ? false
      : _boolFromInt(json['allow_multiple_submissions']),
  isMandatory: json['is_mandatory'] == null
      ? false
      : _boolFromInt(json['is_mandatory']),
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => SurveyQuestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  metadata: json['metadata'] == null
      ? const {}
      : _metadataFromJson(json['metadata']),
);

Map<String, dynamic> _$$SurveyImplToJson(
  _$SurveyImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'code': instance.code,
  'title': instance.title,
  'title_local': instance.titleLocal,
  'description': instance.description,
  'description_local': instance.descriptionLocal,
  'survey_mode': _$SurveyModeEnumMap[instance.mode]!,
  'target_context': _$TargetContextEnumMap[instance.targetContext]!,
  'is_active': _boolToInt(instance.isActive),
  'display_order': instance.displayOrder,
  'allow_multiple_submissions': _boolToInt(instance.allowMultipleSubmissions),
  'is_mandatory': _boolToInt(instance.isMandatory),
  'questions': instance.questions,
  'metadata': instance.metadata,
};

const _$SurveyModeEnumMap = {
  SurveyMode.standardForm: 'standard_form',
  SurveyMode.opinionPoll: 'opinion_poll',
  SurveyMode.complaintBox: 'complaint_box',
};

const _$TargetContextEnumMap = {
  TargetContext.none: 'none',
  TargetContext.voter: 'voter',
  TargetContext.geoUnit: 'geo_unit',
};

_$SurveyQuestionImpl _$$SurveyQuestionImplFromJson(Map<String, dynamic> json) =>
    _$SurveyQuestionImpl(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      surveyId: json['survey_id'] as String,
      code: json['code'] as String,
      text: json['question_text'] as String,
      textLocal: json['question_text_local'] as String?,
      uiType:
          $enumDecodeNullable(
            _$QuestionUiTypeEnumMap,
            json['question_ui_type'],
          ) ??
          QuestionUiType.textInput,
      isMandatory: json['is_mandatory'] == null
          ? false
          : _boolFromInt(json['is_mandatory']),
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 1,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => SurveyOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      metadata: json['metadata'] == null
          ? const {}
          : _metadataFromJson(json['metadata']),
    );

Map<String, dynamic> _$$SurveyQuestionImplToJson(
  _$SurveyQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'survey_id': instance.surveyId,
  'code': instance.code,
  'question_text': instance.text,
  'question_text_local': instance.textLocal,
  'question_ui_type': _$QuestionUiTypeEnumMap[instance.uiType]!,
  'is_mandatory': _boolToInt(instance.isMandatory),
  'display_order': instance.displayOrder,
  'options': instance.options,
  'metadata': instance.metadata,
};

const _$QuestionUiTypeEnumMap = {
  QuestionUiType.textInput: 'text_input',
  QuestionUiType.numericInput: 'numeric_input',
  QuestionUiType.radioList: 'radio_list',
  QuestionUiType.checkboxList: 'checkbox_list',
  QuestionUiType.searchableDropdown: 'searchable_dropdown',
  QuestionUiType.searchableMultiSelect: 'searchable_multi_select',
  QuestionUiType.chipSelect: 'chip_select',
  QuestionUiType.imageGrid: 'image_grid',
  QuestionUiType.sectionHeader: 'section_header',
  QuestionUiType.cameraCapture: 'camera_capture',
  QuestionUiType.datePicker: 'date_picker',
};

_$SurveyOptionImpl _$$SurveyOptionImplFromJson(Map<String, dynamic> json) =>
    _$SurveyOptionImpl(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      questionId: json['survey_question_id'] as String,
      code: json['code'] as String,
      text: json['option_text'] as String,
      textLocal: json['option_text_local'] as String?,
      imageUrl: json['image_url'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 1,
      isActive: json['is_active'] == null
          ? true
          : _boolFromInt(json['is_active']),
    );

Map<String, dynamic> _$$SurveyOptionImplToJson(_$SurveyOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign_id': instance.campaignId,
      'survey_question_id': instance.questionId,
      'code': instance.code,
      'option_text': instance.text,
      'option_text_local': instance.textLocal,
      'image_url': instance.imageUrl,
      'display_order': instance.displayOrder,
      'is_active': _boolToInt(instance.isActive),
    };

_$SurveyResponseImpl _$$SurveyResponseImplFromJson(Map<String, dynamic> json) =>
    _$SurveyResponseImpl(
      id: json['id'] as String?,
      campaignId: json['campaign_id'] as String,
      surveyId: json['survey_id'] as String,
      geoUnitId: json['geo_unit_id'] as String,
      voterId: json['voter_id'] as String?,
      respondentName: json['respondent_name'] as String?,
      respondentPhone: json['respondent_phone'] as String?,
      status: json['status'] as String? ?? 'completed',
      latitude: _doubleFromDynamic(json['latitude']),
      longitude: _doubleFromDynamic(json['longitude']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      clientResponseId: json['client_response_id'] as String?,
    );

Map<String, dynamic> _$$SurveyResponseImplToJson(
  _$SurveyResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'survey_id': instance.surveyId,
  'geo_unit_id': instance.geoUnitId,
  'voter_id': instance.voterId,
  'respondent_name': instance.respondentName,
  'respondent_phone': instance.respondentPhone,
  'status': instance.status,
  'latitude': _doubleToString(instance.latitude),
  'longitude': _doubleToString(instance.longitude),
  'created_at': instance.createdAt?.toIso8601String(),
  'client_response_id': instance.clientResponseId,
};

_$SurveyResponseOptionImpl _$$SurveyResponseOptionImplFromJson(
  Map<String, dynamic> json,
) => _$SurveyResponseOptionImpl(
  id: json['id'] as String?,
  campaignId: json['campaign_id'] as String,
  responseId: json['survey_response_id'] as String,
  questionId: json['survey_question_id'] as String,
  surveyOptionId: json['survey_option_id'] as String?,
  answerValue: json['answer_value'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$$SurveyResponseOptionImplToJson(
  _$SurveyResponseOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'survey_response_id': instance.responseId,
  'survey_question_id': instance.questionId,
  'survey_option_id': instance.surveyOptionId,
  'answer_value': instance.answerValue,
  'created_at': instance.createdAt,
};
