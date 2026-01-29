// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return _Survey.fromJson(json);
}

/// @nodoc
mixin _$Survey {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_local')
  String? get titleLocal => throw _privateConstructorUsedError; // New
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_local')
  String? get descriptionLocal => throw _privateConstructorUsedError; // New
  @JsonKey(name: 'survey_mode')
  SurveyMode get mode => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_context')
  TargetContext get targetContext => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_order')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'allow_multiple_submissions',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  bool get allowMultipleSubmissions => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isMandatory => throw _privateConstructorUsedError;
  List<SurveyQuestion> get questions => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyCopyWith<Survey> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyCopyWith<$Res> {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) then) =
      _$SurveyCopyWithImpl<$Res, Survey>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    String code,
    String title,
    @JsonKey(name: 'title_local') String? titleLocal,
    String? description,
    @JsonKey(name: 'description_local') String? descriptionLocal,
    @JsonKey(name: 'survey_mode') SurveyMode mode,
    @JsonKey(name: 'target_context') TargetContext targetContext,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(
      name: 'allow_multiple_submissions',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    bool allowMultipleSubmissions,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isMandatory,
    List<SurveyQuestion> questions,
    @JsonKey(fromJson: _metadataFromJson) Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$SurveyCopyWithImpl<$Res, $Val extends Survey>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? code = null,
    Object? title = null,
    Object? titleLocal = freezed,
    Object? description = freezed,
    Object? descriptionLocal = freezed,
    Object? mode = null,
    Object? targetContext = null,
    Object? isActive = null,
    Object? displayOrder = null,
    Object? allowMultipleSubmissions = null,
    Object? isMandatory = null,
    Object? questions = null,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            titleLocal: freezed == titleLocal
                ? _value.titleLocal
                : titleLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionLocal: freezed == descriptionLocal
                ? _value.descriptionLocal
                : descriptionLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as SurveyMode,
            targetContext: null == targetContext
                ? _value.targetContext
                : targetContext // ignore: cast_nullable_to_non_nullable
                      as TargetContext,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            allowMultipleSubmissions: null == allowMultipleSubmissions
                ? _value.allowMultipleSubmissions
                : allowMultipleSubmissions // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMandatory: null == isMandatory
                ? _value.isMandatory
                : isMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<SurveyQuestion>,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyImplCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$$SurveyImplCopyWith(
    _$SurveyImpl value,
    $Res Function(_$SurveyImpl) then,
  ) = __$$SurveyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    String code,
    String title,
    @JsonKey(name: 'title_local') String? titleLocal,
    String? description,
    @JsonKey(name: 'description_local') String? descriptionLocal,
    @JsonKey(name: 'survey_mode') SurveyMode mode,
    @JsonKey(name: 'target_context') TargetContext targetContext,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(
      name: 'allow_multiple_submissions',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    bool allowMultipleSubmissions,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isMandatory,
    List<SurveyQuestion> questions,
    @JsonKey(fromJson: _metadataFromJson) Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$SurveyImplCopyWithImpl<$Res>
    extends _$SurveyCopyWithImpl<$Res, _$SurveyImpl>
    implements _$$SurveyImplCopyWith<$Res> {
  __$$SurveyImplCopyWithImpl(
    _$SurveyImpl _value,
    $Res Function(_$SurveyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? code = null,
    Object? title = null,
    Object? titleLocal = freezed,
    Object? description = freezed,
    Object? descriptionLocal = freezed,
    Object? mode = null,
    Object? targetContext = null,
    Object? isActive = null,
    Object? displayOrder = null,
    Object? allowMultipleSubmissions = null,
    Object? isMandatory = null,
    Object? questions = null,
    Object? metadata = null,
  }) {
    return _then(
      _$SurveyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        titleLocal: freezed == titleLocal
            ? _value.titleLocal
            : titleLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionLocal: freezed == descriptionLocal
            ? _value.descriptionLocal
            : descriptionLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as SurveyMode,
        targetContext: null == targetContext
            ? _value.targetContext
            : targetContext // ignore: cast_nullable_to_non_nullable
                  as TargetContext,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        allowMultipleSubmissions: null == allowMultipleSubmissions
            ? _value.allowMultipleSubmissions
            : allowMultipleSubmissions // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMandatory: null == isMandatory
            ? _value.isMandatory
            : isMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<SurveyQuestion>,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyImpl extends _Survey with DiagnosticableTreeMixin {
  const _$SurveyImpl({
    required this.id,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    required this.code,
    required this.title,
    @JsonKey(name: 'title_local') this.titleLocal,
    this.description,
    @JsonKey(name: 'description_local') this.descriptionLocal,
    @JsonKey(name: 'survey_mode') this.mode = SurveyMode.standardForm,
    @JsonKey(name: 'target_context') this.targetContext = TargetContext.none,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isActive = true,
    @JsonKey(name: 'display_order') this.displayOrder = 1,
    @JsonKey(
      name: 'allow_multiple_submissions',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    this.allowMultipleSubmissions = false,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isMandatory = false,
    final List<SurveyQuestion> questions = const [],
    @JsonKey(fromJson: _metadataFromJson)
    final Map<String, dynamic> metadata = const {},
  }) : _questions = questions,
       _metadata = metadata,
       super._();

  factory _$SurveyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  final String code;
  @override
  final String title;
  @override
  @JsonKey(name: 'title_local')
  final String? titleLocal;
  // New
  @override
  final String? description;
  @override
  @JsonKey(name: 'description_local')
  final String? descriptionLocal;
  // New
  @override
  @JsonKey(name: 'survey_mode')
  final SurveyMode mode;
  @override
  @JsonKey(name: 'target_context')
  final TargetContext targetContext;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isActive;
  @override
  @JsonKey(name: 'display_order')
  final int displayOrder;
  @override
  @JsonKey(
    name: 'allow_multiple_submissions',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  final bool allowMultipleSubmissions;
  @override
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isMandatory;
  final List<SurveyQuestion> _questions;
  @override
  @JsonKey()
  List<SurveyQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Survey(id: $id, campaignId: $campaignId, code: $code, title: $title, titleLocal: $titleLocal, description: $description, descriptionLocal: $descriptionLocal, mode: $mode, targetContext: $targetContext, isActive: $isActive, displayOrder: $displayOrder, allowMultipleSubmissions: $allowMultipleSubmissions, isMandatory: $isMandatory, questions: $questions, metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Survey'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('campaignId', campaignId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('titleLocal', titleLocal))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('descriptionLocal', descriptionLocal))
      ..add(DiagnosticsProperty('mode', mode))
      ..add(DiagnosticsProperty('targetContext', targetContext))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('displayOrder', displayOrder))
      ..add(
        DiagnosticsProperty(
          'allowMultipleSubmissions',
          allowMultipleSubmissions,
        ),
      )
      ..add(DiagnosticsProperty('isMandatory', isMandatory))
      ..add(DiagnosticsProperty('questions', questions))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleLocal, titleLocal) ||
                other.titleLocal == titleLocal) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionLocal, descriptionLocal) ||
                other.descriptionLocal == descriptionLocal) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.targetContext, targetContext) ||
                other.targetContext == targetContext) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(
                  other.allowMultipleSubmissions,
                  allowMultipleSubmissions,
                ) ||
                other.allowMultipleSubmissions == allowMultipleSubmissions) &&
            (identical(other.isMandatory, isMandatory) ||
                other.isMandatory == isMandatory) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    code,
    title,
    titleLocal,
    description,
    descriptionLocal,
    mode,
    targetContext,
    isActive,
    displayOrder,
    allowMultipleSubmissions,
    isMandatory,
    const DeepCollectionEquality().hash(_questions),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      __$$SurveyImplCopyWithImpl<_$SurveyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyImplToJson(this);
  }
}

abstract class _Survey extends Survey {
  const factory _Survey({
    required final String id,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    required final String code,
    required final String title,
    @JsonKey(name: 'title_local') final String? titleLocal,
    final String? description,
    @JsonKey(name: 'description_local') final String? descriptionLocal,
    @JsonKey(name: 'survey_mode') final SurveyMode mode,
    @JsonKey(name: 'target_context') final TargetContext targetContext,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isActive,
    @JsonKey(name: 'display_order') final int displayOrder,
    @JsonKey(
      name: 'allow_multiple_submissions',
      fromJson: _boolFromInt,
      toJson: _boolToInt,
    )
    final bool allowMultipleSubmissions,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isMandatory,
    final List<SurveyQuestion> questions,
    @JsonKey(fromJson: _metadataFromJson) final Map<String, dynamic> metadata,
  }) = _$SurveyImpl;
  const _Survey._() : super._();

  factory _Survey.fromJson(Map<String, dynamic> json) = _$SurveyImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  String get code;
  @override
  String get title;
  @override
  @JsonKey(name: 'title_local')
  String? get titleLocal; // New
  @override
  String? get description;
  @override
  @JsonKey(name: 'description_local')
  String? get descriptionLocal; // New
  @override
  @JsonKey(name: 'survey_mode')
  SurveyMode get mode;
  @override
  @JsonKey(name: 'target_context')
  TargetContext get targetContext;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive;
  @override
  @JsonKey(name: 'display_order')
  int get displayOrder;
  @override
  @JsonKey(
    name: 'allow_multiple_submissions',
    fromJson: _boolFromInt,
    toJson: _boolToInt,
  )
  bool get allowMultipleSubmissions;
  @override
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isMandatory;
  @override
  List<SurveyQuestion> get questions;
  @override
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) {
  return _SurveyQuestion.fromJson(json);
}

/// @nodoc
mixin _$SurveyQuestion {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_id')
  String get surveyId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_text')
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_text_local')
  String? get textLocal => throw _privateConstructorUsedError; // New
  @JsonKey(name: 'question_ui_type')
  QuestionUiType get uiType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isMandatory => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_order')
  int get displayOrder => throw _privateConstructorUsedError;
  List<SurveyOption> get options => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this SurveyQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyQuestionCopyWith<SurveyQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyQuestionCopyWith<$Res> {
  factory $SurveyQuestionCopyWith(
    SurveyQuestion value,
    $Res Function(SurveyQuestion) then,
  ) = _$SurveyQuestionCopyWithImpl<$Res, SurveyQuestion>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_id') String surveyId,
    String code,
    @JsonKey(name: 'question_text') String text,
    @JsonKey(name: 'question_text_local') String? textLocal,
    @JsonKey(name: 'question_ui_type') QuestionUiType uiType,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isMandatory,
    @JsonKey(name: 'display_order') int displayOrder,
    List<SurveyOption> options,
    @JsonKey(fromJson: _metadataFromJson) Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$SurveyQuestionCopyWithImpl<$Res, $Val extends SurveyQuestion>
    implements $SurveyQuestionCopyWith<$Res> {
  _$SurveyQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? surveyId = null,
    Object? code = null,
    Object? text = null,
    Object? textLocal = freezed,
    Object? uiType = null,
    Object? isMandatory = null,
    Object? displayOrder = null,
    Object? options = null,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            surveyId: null == surveyId
                ? _value.surveyId
                : surveyId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            textLocal: freezed == textLocal
                ? _value.textLocal
                : textLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            uiType: null == uiType
                ? _value.uiType
                : uiType // ignore: cast_nullable_to_non_nullable
                      as QuestionUiType,
            isMandatory: null == isMandatory
                ? _value.isMandatory
                : isMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<SurveyOption>,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyQuestionImplCopyWith<$Res>
    implements $SurveyQuestionCopyWith<$Res> {
  factory _$$SurveyQuestionImplCopyWith(
    _$SurveyQuestionImpl value,
    $Res Function(_$SurveyQuestionImpl) then,
  ) = __$$SurveyQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_id') String surveyId,
    String code,
    @JsonKey(name: 'question_text') String text,
    @JsonKey(name: 'question_text_local') String? textLocal,
    @JsonKey(name: 'question_ui_type') QuestionUiType uiType,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isMandatory,
    @JsonKey(name: 'display_order') int displayOrder,
    List<SurveyOption> options,
    @JsonKey(fromJson: _metadataFromJson) Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$SurveyQuestionImplCopyWithImpl<$Res>
    extends _$SurveyQuestionCopyWithImpl<$Res, _$SurveyQuestionImpl>
    implements _$$SurveyQuestionImplCopyWith<$Res> {
  __$$SurveyQuestionImplCopyWithImpl(
    _$SurveyQuestionImpl _value,
    $Res Function(_$SurveyQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? surveyId = null,
    Object? code = null,
    Object? text = null,
    Object? textLocal = freezed,
    Object? uiType = null,
    Object? isMandatory = null,
    Object? displayOrder = null,
    Object? options = null,
    Object? metadata = null,
  }) {
    return _then(
      _$SurveyQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        surveyId: null == surveyId
            ? _value.surveyId
            : surveyId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        textLocal: freezed == textLocal
            ? _value.textLocal
            : textLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        uiType: null == uiType
            ? _value.uiType
            : uiType // ignore: cast_nullable_to_non_nullable
                  as QuestionUiType,
        isMandatory: null == isMandatory
            ? _value.isMandatory
            : isMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<SurveyOption>,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyQuestionImpl extends _SurveyQuestion
    with DiagnosticableTreeMixin {
  const _$SurveyQuestionImpl({
    required this.id,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    @JsonKey(name: 'survey_id') required this.surveyId,
    required this.code,
    @JsonKey(name: 'question_text') required this.text,
    @JsonKey(name: 'question_text_local') this.textLocal,
    @JsonKey(name: 'question_ui_type') this.uiType = QuestionUiType.textInput,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isMandatory = false,
    @JsonKey(name: 'display_order') this.displayOrder = 1,
    final List<SurveyOption> options = const [],
    @JsonKey(fromJson: _metadataFromJson)
    final Map<String, dynamic> metadata = const {},
  }) : _options = options,
       _metadata = metadata,
       super._();

  factory _$SurveyQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyQuestionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @override
  final String code;
  @override
  @JsonKey(name: 'question_text')
  final String text;
  @override
  @JsonKey(name: 'question_text_local')
  final String? textLocal;
  // New
  @override
  @JsonKey(name: 'question_ui_type')
  final QuestionUiType uiType;
  @override
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isMandatory;
  @override
  @JsonKey(name: 'display_order')
  final int displayOrder;
  final List<SurveyOption> _options;
  @override
  @JsonKey()
  List<SurveyOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SurveyQuestion(id: $id, campaignId: $campaignId, surveyId: $surveyId, code: $code, text: $text, textLocal: $textLocal, uiType: $uiType, isMandatory: $isMandatory, displayOrder: $displayOrder, options: $options, metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SurveyQuestion'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('campaignId', campaignId))
      ..add(DiagnosticsProperty('surveyId', surveyId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('textLocal', textLocal))
      ..add(DiagnosticsProperty('uiType', uiType))
      ..add(DiagnosticsProperty('isMandatory', isMandatory))
      ..add(DiagnosticsProperty('displayOrder', displayOrder))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textLocal, textLocal) ||
                other.textLocal == textLocal) &&
            (identical(other.uiType, uiType) || other.uiType == uiType) &&
            (identical(other.isMandatory, isMandatory) ||
                other.isMandatory == isMandatory) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    surveyId,
    code,
    text,
    textLocal,
    uiType,
    isMandatory,
    displayOrder,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyQuestionImplCopyWith<_$SurveyQuestionImpl> get copyWith =>
      __$$SurveyQuestionImplCopyWithImpl<_$SurveyQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyQuestionImplToJson(this);
  }
}

abstract class _SurveyQuestion extends SurveyQuestion {
  const factory _SurveyQuestion({
    required final String id,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    @JsonKey(name: 'survey_id') required final String surveyId,
    required final String code,
    @JsonKey(name: 'question_text') required final String text,
    @JsonKey(name: 'question_text_local') final String? textLocal,
    @JsonKey(name: 'question_ui_type') final QuestionUiType uiType,
    @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isMandatory,
    @JsonKey(name: 'display_order') final int displayOrder,
    final List<SurveyOption> options,
    @JsonKey(fromJson: _metadataFromJson) final Map<String, dynamic> metadata,
  }) = _$SurveyQuestionImpl;
  const _SurveyQuestion._() : super._();

  factory _SurveyQuestion.fromJson(Map<String, dynamic> json) =
      _$SurveyQuestionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  @JsonKey(name: 'survey_id')
  String get surveyId;
  @override
  String get code;
  @override
  @JsonKey(name: 'question_text')
  String get text;
  @override
  @JsonKey(name: 'question_text_local')
  String? get textLocal; // New
  @override
  @JsonKey(name: 'question_ui_type')
  QuestionUiType get uiType;
  @override
  @JsonKey(name: 'is_mandatory', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isMandatory;
  @override
  @JsonKey(name: 'display_order')
  int get displayOrder;
  @override
  List<SurveyOption> get options;
  @override
  @JsonKey(fromJson: _metadataFromJson)
  Map<String, dynamic> get metadata;

  /// Create a copy of SurveyQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyQuestionImplCopyWith<_$SurveyQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SurveyOption _$SurveyOptionFromJson(Map<String, dynamic> json) {
  return _SurveyOption.fromJson(json);
}

/// @nodoc
mixin _$SurveyOption {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_question_id')
  String get questionId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_text')
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_text_local')
  String? get textLocal => throw _privateConstructorUsedError; // New
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_order')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this SurveyOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyOptionCopyWith<SurveyOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyOptionCopyWith<$Res> {
  factory $SurveyOptionCopyWith(
    SurveyOption value,
    $Res Function(SurveyOption) then,
  ) = _$SurveyOptionCopyWithImpl<$Res, SurveyOption>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_question_id') String questionId,
    String code,
    @JsonKey(name: 'option_text') String text,
    @JsonKey(name: 'option_text_local') String? textLocal,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
  });
}

/// @nodoc
class _$SurveyOptionCopyWithImpl<$Res, $Val extends SurveyOption>
    implements $SurveyOptionCopyWith<$Res> {
  _$SurveyOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? questionId = null,
    Object? code = null,
    Object? text = null,
    Object? textLocal = freezed,
    Object? imageUrl = freezed,
    Object? displayOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            textLocal: freezed == textLocal
                ? _value.textLocal
                : textLocal // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyOptionImplCopyWith<$Res>
    implements $SurveyOptionCopyWith<$Res> {
  factory _$$SurveyOptionImplCopyWith(
    _$SurveyOptionImpl value,
    $Res Function(_$SurveyOptionImpl) then,
  ) = __$$SurveyOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_question_id') String questionId,
    String code,
    @JsonKey(name: 'option_text') String text,
    @JsonKey(name: 'option_text_local') String? textLocal,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
  });
}

/// @nodoc
class __$$SurveyOptionImplCopyWithImpl<$Res>
    extends _$SurveyOptionCopyWithImpl<$Res, _$SurveyOptionImpl>
    implements _$$SurveyOptionImplCopyWith<$Res> {
  __$$SurveyOptionImplCopyWithImpl(
    _$SurveyOptionImpl _value,
    $Res Function(_$SurveyOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? questionId = null,
    Object? code = null,
    Object? text = null,
    Object? textLocal = freezed,
    Object? imageUrl = freezed,
    Object? displayOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$SurveyOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        textLocal: freezed == textLocal
            ? _value.textLocal
            : textLocal // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyOptionImpl extends _SurveyOption with DiagnosticableTreeMixin {
  const _$SurveyOptionImpl({
    required this.id,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    @JsonKey(name: 'survey_question_id') required this.questionId,
    required this.code,
    @JsonKey(name: 'option_text') required this.text,
    @JsonKey(name: 'option_text_local') this.textLocal,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'display_order') this.displayOrder = 1,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    this.isActive = true,
  }) : super._();

  factory _$SurveyOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyOptionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  @JsonKey(name: 'survey_question_id')
  final String questionId;
  @override
  final String code;
  @override
  @JsonKey(name: 'option_text')
  final String text;
  @override
  @JsonKey(name: 'option_text_local')
  final String? textLocal;
  // New
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'display_order')
  final int displayOrder;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SurveyOption(id: $id, campaignId: $campaignId, questionId: $questionId, code: $code, text: $text, textLocal: $textLocal, imageUrl: $imageUrl, displayOrder: $displayOrder, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SurveyOption'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('campaignId', campaignId))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('textLocal', textLocal))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('displayOrder', displayOrder))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textLocal, textLocal) ||
                other.textLocal == textLocal) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    questionId,
    code,
    text,
    textLocal,
    imageUrl,
    displayOrder,
    isActive,
  );

  /// Create a copy of SurveyOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyOptionImplCopyWith<_$SurveyOptionImpl> get copyWith =>
      __$$SurveyOptionImplCopyWithImpl<_$SurveyOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyOptionImplToJson(this);
  }
}

abstract class _SurveyOption extends SurveyOption {
  const factory _SurveyOption({
    required final String id,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    @JsonKey(name: 'survey_question_id') required final String questionId,
    required final String code,
    @JsonKey(name: 'option_text') required final String text,
    @JsonKey(name: 'option_text_local') final String? textLocal,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'display_order') final int displayOrder,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    final bool isActive,
  }) = _$SurveyOptionImpl;
  const _SurveyOption._() : super._();

  factory _SurveyOption.fromJson(Map<String, dynamic> json) =
      _$SurveyOptionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  @JsonKey(name: 'survey_question_id')
  String get questionId;
  @override
  String get code;
  @override
  @JsonKey(name: 'option_text')
  String get text;
  @override
  @JsonKey(name: 'option_text_local')
  String? get textLocal; // New
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'display_order')
  int get displayOrder;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive;

  /// Create a copy of SurveyOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyOptionImplCopyWith<_$SurveyOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) {
  return _SurveyResponse.fromJson(json);
}

/// @nodoc
mixin _$SurveyResponse {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_id')
  String get surveyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'geo_unit_id')
  String get geoUnitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'voter_id')
  String? get voterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'respondent_name')
  String? get respondentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'respondent_phone')
  String? get respondentPhone => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // DB uses TEXT for lat/long strings
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_response_id')
  String? get clientResponseId => throw _privateConstructorUsedError;

  /// Serializes this SurveyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyResponseCopyWith<SurveyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyResponseCopyWith<$Res> {
  factory $SurveyResponseCopyWith(
    SurveyResponse value,
    $Res Function(SurveyResponse) then,
  ) = _$SurveyResponseCopyWithImpl<$Res, SurveyResponse>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_id') String surveyId,
    @JsonKey(name: 'geo_unit_id') String geoUnitId,
    @JsonKey(name: 'voter_id') String? voterId,
    @JsonKey(name: 'respondent_name') String? respondentName,
    @JsonKey(name: 'respondent_phone') String? respondentPhone,
    String status,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? longitude,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'client_response_id') String? clientResponseId,
  });
}

/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res, $Val extends SurveyResponse>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? campaignId = null,
    Object? surveyId = null,
    Object? geoUnitId = null,
    Object? voterId = freezed,
    Object? respondentName = freezed,
    Object? respondentPhone = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? clientResponseId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            surveyId: null == surveyId
                ? _value.surveyId
                : surveyId // ignore: cast_nullable_to_non_nullable
                      as String,
            geoUnitId: null == geoUnitId
                ? _value.geoUnitId
                : geoUnitId // ignore: cast_nullable_to_non_nullable
                      as String,
            voterId: freezed == voterId
                ? _value.voterId
                : voterId // ignore: cast_nullable_to_non_nullable
                      as String?,
            respondentName: freezed == respondentName
                ? _value.respondentName
                : respondentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            respondentPhone: freezed == respondentPhone
                ? _value.respondentPhone
                : respondentPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            clientResponseId: freezed == clientResponseId
                ? _value.clientResponseId
                : clientResponseId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyResponseImplCopyWith<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  factory _$$SurveyResponseImplCopyWith(
    _$SurveyResponseImpl value,
    $Res Function(_$SurveyResponseImpl) then,
  ) = __$$SurveyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_id') String surveyId,
    @JsonKey(name: 'geo_unit_id') String geoUnitId,
    @JsonKey(name: 'voter_id') String? voterId,
    @JsonKey(name: 'respondent_name') String? respondentName,
    @JsonKey(name: 'respondent_phone') String? respondentPhone,
    String status,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    double? longitude,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'client_response_id') String? clientResponseId,
  });
}

/// @nodoc
class __$$SurveyResponseImplCopyWithImpl<$Res>
    extends _$SurveyResponseCopyWithImpl<$Res, _$SurveyResponseImpl>
    implements _$$SurveyResponseImplCopyWith<$Res> {
  __$$SurveyResponseImplCopyWithImpl(
    _$SurveyResponseImpl _value,
    $Res Function(_$SurveyResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? campaignId = null,
    Object? surveyId = null,
    Object? geoUnitId = null,
    Object? voterId = freezed,
    Object? respondentName = freezed,
    Object? respondentPhone = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? clientResponseId = freezed,
  }) {
    return _then(
      _$SurveyResponseImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        surveyId: null == surveyId
            ? _value.surveyId
            : surveyId // ignore: cast_nullable_to_non_nullable
                  as String,
        geoUnitId: null == geoUnitId
            ? _value.geoUnitId
            : geoUnitId // ignore: cast_nullable_to_non_nullable
                  as String,
        voterId: freezed == voterId
            ? _value.voterId
            : voterId // ignore: cast_nullable_to_non_nullable
                  as String?,
        respondentName: freezed == respondentName
            ? _value.respondentName
            : respondentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        respondentPhone: freezed == respondentPhone
            ? _value.respondentPhone
            : respondentPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        clientResponseId: freezed == clientResponseId
            ? _value.clientResponseId
            : clientResponseId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyResponseImpl extends _SurveyResponse
    with DiagnosticableTreeMixin {
  const _$SurveyResponseImpl({
    this.id,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    @JsonKey(name: 'survey_id') required this.surveyId,
    @JsonKey(name: 'geo_unit_id') required this.geoUnitId,
    @JsonKey(name: 'voter_id') this.voterId,
    @JsonKey(name: 'respondent_name') this.respondentName,
    @JsonKey(name: 'respondent_phone') this.respondentPhone,
    this.status = 'completed',
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    this.latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    this.longitude,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'client_response_id') this.clientResponseId,
  }) : super._();

  factory _$SurveyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyResponseImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @override
  @JsonKey(name: 'geo_unit_id')
  final String geoUnitId;
  @override
  @JsonKey(name: 'voter_id')
  final String? voterId;
  @override
  @JsonKey(name: 'respondent_name')
  final String? respondentName;
  @override
  @JsonKey(name: 'respondent_phone')
  final String? respondentPhone;
  @override
  @JsonKey()
  final String status;
  // DB uses TEXT for lat/long strings
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  final double? latitude;
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  final double? longitude;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'client_response_id')
  final String? clientResponseId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SurveyResponse(id: $id, campaignId: $campaignId, surveyId: $surveyId, geoUnitId: $geoUnitId, voterId: $voterId, respondentName: $respondentName, respondentPhone: $respondentPhone, status: $status, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, clientResponseId: $clientResponseId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SurveyResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('campaignId', campaignId))
      ..add(DiagnosticsProperty('surveyId', surveyId))
      ..add(DiagnosticsProperty('geoUnitId', geoUnitId))
      ..add(DiagnosticsProperty('voterId', voterId))
      ..add(DiagnosticsProperty('respondentName', respondentName))
      ..add(DiagnosticsProperty('respondentPhone', respondentPhone))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('clientResponseId', clientResponseId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.geoUnitId, geoUnitId) ||
                other.geoUnitId == geoUnitId) &&
            (identical(other.voterId, voterId) || other.voterId == voterId) &&
            (identical(other.respondentName, respondentName) ||
                other.respondentName == respondentName) &&
            (identical(other.respondentPhone, respondentPhone) ||
                other.respondentPhone == respondentPhone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.clientResponseId, clientResponseId) ||
                other.clientResponseId == clientResponseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    surveyId,
    geoUnitId,
    voterId,
    respondentName,
    respondentPhone,
    status,
    latitude,
    longitude,
    createdAt,
    clientResponseId,
  );

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      __$$SurveyResponseImplCopyWithImpl<_$SurveyResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyResponseImplToJson(this);
  }
}

abstract class _SurveyResponse extends SurveyResponse {
  const factory _SurveyResponse({
    final String? id,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    @JsonKey(name: 'survey_id') required final String surveyId,
    @JsonKey(name: 'geo_unit_id') required final String geoUnitId,
    @JsonKey(name: 'voter_id') final String? voterId,
    @JsonKey(name: 'respondent_name') final String? respondentName,
    @JsonKey(name: 'respondent_phone') final String? respondentPhone,
    final String status,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    final double? latitude,
    @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
    final double? longitude,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'client_response_id') final String? clientResponseId,
  }) = _$SurveyResponseImpl;
  const _SurveyResponse._() : super._();

  factory _SurveyResponse.fromJson(Map<String, dynamic> json) =
      _$SurveyResponseImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  @JsonKey(name: 'survey_id')
  String get surveyId;
  @override
  @JsonKey(name: 'geo_unit_id')
  String get geoUnitId;
  @override
  @JsonKey(name: 'voter_id')
  String? get voterId;
  @override
  @JsonKey(name: 'respondent_name')
  String? get respondentName;
  @override
  @JsonKey(name: 'respondent_phone')
  String? get respondentPhone;
  @override
  String get status; // DB uses TEXT for lat/long strings
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get latitude;
  @override
  @JsonKey(fromJson: _doubleFromDynamic, toJson: _doubleToString)
  double? get longitude;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'client_response_id')
  String? get clientResponseId;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SurveyResponseOption _$SurveyResponseOptionFromJson(Map<String, dynamic> json) {
  return _SurveyResponseOption.fromJson(json);
}

/// @nodoc
mixin _$SurveyResponseOption {
  String? get id =>
      throw _privateConstructorUsedError; // PowerSync/Supabase will generate a UUID
  @JsonKey(name: 'campaign_id')
  String get campaignId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_response_id')
  String get responseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_question_id')
  String get questionId => throw _privateConstructorUsedError; // The ID of the option selected (for Radio/Checkbox/Dropdown)
  @JsonKey(name: 'survey_option_id')
  String? get surveyOptionId => throw _privateConstructorUsedError; // The raw text/number/date entered (for Input fields)
  @JsonKey(name: 'answer_value')
  String? get answerValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SurveyResponseOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyResponseOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyResponseOptionCopyWith<SurveyResponseOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyResponseOptionCopyWith<$Res> {
  factory $SurveyResponseOptionCopyWith(
    SurveyResponseOption value,
    $Res Function(SurveyResponseOption) then,
  ) = _$SurveyResponseOptionCopyWithImpl<$Res, SurveyResponseOption>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_response_id') String responseId,
    @JsonKey(name: 'survey_question_id') String questionId,
    @JsonKey(name: 'survey_option_id') String? surveyOptionId,
    @JsonKey(name: 'answer_value') String? answerValue,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$SurveyResponseOptionCopyWithImpl<
  $Res,
  $Val extends SurveyResponseOption
>
    implements $SurveyResponseOptionCopyWith<$Res> {
  _$SurveyResponseOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyResponseOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? campaignId = null,
    Object? responseId = null,
    Object? questionId = null,
    Object? surveyOptionId = freezed,
    Object? answerValue = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            responseId: null == responseId
                ? _value.responseId
                : responseId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            surveyOptionId: freezed == surveyOptionId
                ? _value.surveyOptionId
                : surveyOptionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            answerValue: freezed == answerValue
                ? _value.answerValue
                : answerValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurveyResponseOptionImplCopyWith<$Res>
    implements $SurveyResponseOptionCopyWith<$Res> {
  factory _$$SurveyResponseOptionImplCopyWith(
    _$SurveyResponseOptionImpl value,
    $Res Function(_$SurveyResponseOptionImpl) then,
  ) = __$$SurveyResponseOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'campaign_id') String campaignId,
    @JsonKey(name: 'survey_response_id') String responseId,
    @JsonKey(name: 'survey_question_id') String questionId,
    @JsonKey(name: 'survey_option_id') String? surveyOptionId,
    @JsonKey(name: 'answer_value') String? answerValue,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$SurveyResponseOptionImplCopyWithImpl<$Res>
    extends _$SurveyResponseOptionCopyWithImpl<$Res, _$SurveyResponseOptionImpl>
    implements _$$SurveyResponseOptionImplCopyWith<$Res> {
  __$$SurveyResponseOptionImplCopyWithImpl(
    _$SurveyResponseOptionImpl _value,
    $Res Function(_$SurveyResponseOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyResponseOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? campaignId = null,
    Object? responseId = null,
    Object? questionId = null,
    Object? surveyOptionId = freezed,
    Object? answerValue = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SurveyResponseOptionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        responseId: null == responseId
            ? _value.responseId
            : responseId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        surveyOptionId: freezed == surveyOptionId
            ? _value.surveyOptionId
            : surveyOptionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        answerValue: freezed == answerValue
            ? _value.answerValue
            : answerValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyResponseOptionImpl
    with DiagnosticableTreeMixin
    implements _SurveyResponseOption {
  const _$SurveyResponseOptionImpl({
    this.id,
    @JsonKey(name: 'campaign_id') required this.campaignId,
    @JsonKey(name: 'survey_response_id') required this.responseId,
    @JsonKey(name: 'survey_question_id') required this.questionId,
    @JsonKey(name: 'survey_option_id') this.surveyOptionId,
    @JsonKey(name: 'answer_value') this.answerValue,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SurveyResponseOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyResponseOptionImplFromJson(json);

  @override
  final String? id;
  // PowerSync/Supabase will generate a UUID
  @override
  @JsonKey(name: 'campaign_id')
  final String campaignId;
  @override
  @JsonKey(name: 'survey_response_id')
  final String responseId;
  @override
  @JsonKey(name: 'survey_question_id')
  final String questionId;
  // The ID of the option selected (for Radio/Checkbox/Dropdown)
  @override
  @JsonKey(name: 'survey_option_id')
  final String? surveyOptionId;
  // The raw text/number/date entered (for Input fields)
  @override
  @JsonKey(name: 'answer_value')
  final String? answerValue;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SurveyResponseOption(id: $id, campaignId: $campaignId, responseId: $responseId, questionId: $questionId, surveyOptionId: $surveyOptionId, answerValue: $answerValue, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SurveyResponseOption'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('campaignId', campaignId))
      ..add(DiagnosticsProperty('responseId', responseId))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('surveyOptionId', surveyOptionId))
      ..add(DiagnosticsProperty('answerValue', answerValue))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyResponseOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.responseId, responseId) ||
                other.responseId == responseId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.surveyOptionId, surveyOptionId) ||
                other.surveyOptionId == surveyOptionId) &&
            (identical(other.answerValue, answerValue) ||
                other.answerValue == answerValue) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    responseId,
    questionId,
    surveyOptionId,
    answerValue,
    createdAt,
  );

  /// Create a copy of SurveyResponseOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyResponseOptionImplCopyWith<_$SurveyResponseOptionImpl>
  get copyWith =>
      __$$SurveyResponseOptionImplCopyWithImpl<_$SurveyResponseOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyResponseOptionImplToJson(this);
  }
}

abstract class _SurveyResponseOption implements SurveyResponseOption {
  const factory _SurveyResponseOption({
    final String? id,
    @JsonKey(name: 'campaign_id') required final String campaignId,
    @JsonKey(name: 'survey_response_id') required final String responseId,
    @JsonKey(name: 'survey_question_id') required final String questionId,
    @JsonKey(name: 'survey_option_id') final String? surveyOptionId,
    @JsonKey(name: 'answer_value') final String? answerValue,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$SurveyResponseOptionImpl;

  factory _SurveyResponseOption.fromJson(Map<String, dynamic> json) =
      _$SurveyResponseOptionImpl.fromJson;

  @override
  String? get id; // PowerSync/Supabase will generate a UUID
  @override
  @JsonKey(name: 'campaign_id')
  String get campaignId;
  @override
  @JsonKey(name: 'survey_response_id')
  String get responseId;
  @override
  @JsonKey(name: 'survey_question_id')
  String get questionId; // The ID of the option selected (for Radio/Checkbox/Dropdown)
  @override
  @JsonKey(name: 'survey_option_id')
  String? get surveyOptionId; // The raw text/number/date entered (for Input fields)
  @override
  @JsonKey(name: 'answer_value')
  String? get answerValue;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of SurveyResponseOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyResponseOptionImplCopyWith<_$SurveyResponseOptionImpl>
  get copyWith => throw _privateConstructorUsedError;
}
