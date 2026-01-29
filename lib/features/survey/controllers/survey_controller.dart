// lib/features/survey/controllers/survey_controller.dart

import 'package:flutter/foundation.dart';
import 'package:mobileapp/models/survey_model.dart';
import 'package:mobileapp/data/survey_repository.dart';
import 'package:mobileapp/features/survey/services/location_service.dart';

class SurveyController extends ChangeNotifier {
  final SurveyRepository _repository;
  final String surveyId;
  final String campaignId;
  final String geoUnitId;
  final String? voterId;

  // --- STATE ---
  bool isLoading = true;
  bool isSubmitting = false;
  String? errorMessage;
  Survey? survey;
  bool hasExistingResponse = false;
  String? existingResponseId;

  // Form State
  final Map<String, String> textAnswers = {};          // For Text/Date
  final Map<String, List<String>> selectedOptions = {}; // For Checkbox/Radio/Search
  
  // Anonymous Respondent State
  String respondentName = '';
  String respondentPhone = '';

  SurveyController({
    required SurveyRepository repository,
    required this.surveyId,
    required this.campaignId,
    required this.geoUnitId,
    this.voterId,
  }) : _repository = repository {
    _loadSurvey();
  }

  // --- 1. INITIALIZATION ---

  Future<void> _loadSurvey() async {
    isLoading = true;
    notifyListeners();

    try {
      survey = await _repository.getSurveyWithDetails(surveyId);
      if (survey == null) {
        errorMessage = "Survey not found.";
      } else {
        // Check if response already exists for this voter
        existingResponseId = await _repository.getExistingResponseId(
          surveyId: surveyId,
          voterId: voterId,
        );
        hasExistingResponse = existingResponseId != null;
      }
    } catch (e) {
      errorMessage = "Error loading survey: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- 2. USER INTERACTION ---

  void setRespondentInfo({String? name, String? phone}) {
    if (name != null) respondentName = name;
    if (phone != null) respondentPhone = phone;
    // No notifyListeners needed for text fields usually, unless validating real-time
  }

  void setTextAnswer(String questionId, String value) {
    textAnswers[questionId] = value;
    // We don't notifyListeners here to avoid rebuilding the whole screen on every keypress
  }

  void setOptionAnswer(String questionId, List<String> optionIds) {
    selectedOptions[questionId] = optionIds;
    notifyListeners(); // Rebuilds UI (e.g. checkbox state changes)
  }

  // Helpers for UI to read state
  String? getTextValue(String qId) => textAnswers[qId];
  List<String> getOptionIds(String qId) => selectedOptions[qId] ?? [];

  // --- 3. SUBMISSION LOGIC ---

  /// Returns NULL if success, or an error message String if failed
  Future<String?> submit() async {
    if (survey == null) return "Survey not loaded";

    // Set loading state IMMEDIATELY before any async work
    isSubmitting = true;
    notifyListeners();

    try {
      // A. Validation
      final validationError = _validateAnswers();
      if (validationError != null) {
        isSubmitting = false;
        notifyListeners();
        return validationError;
      }

      // B. Get Location
      final coords = await LocationService.getCurrentCoordinates();

      // C. Build Header (with generated ID)
      final responseId = _repository.generateId();
      final response = SurveyResponse(
        id: responseId,
        campaignId: campaignId,
        surveyId: surveyId,
        geoUnitId: geoUnitId,
        voterId: voterId,
        respondentName: voterId == null ? respondentName : null,
        respondentPhone: voterId == null ? respondentPhone : null,
        status: 'completed',
        latitude: coords?.$1 ?? 0.0, 
        longitude: coords?.$2 ?? 0.0,
      );

      // D. Build Answer Rows with the correct responseId
      final List<SurveyResponseOption> answersList = [];

      // Flatten Text Answers
      textAnswers.forEach((qId, val) {
        if (val.isNotEmpty) {
          answersList.add(SurveyResponseOption(
            campaignId: campaignId,
            responseId: responseId, 
            questionId: qId,
            answerValue: val,
          ));
        }
      });

      // Flatten Option Answers
      selectedOptions.forEach((qId, ids) {
        for (var optId in ids) {
          answersList.add(SurveyResponseOption(
            campaignId: campaignId,
            responseId: responseId,
            questionId: qId,
            surveyOptionId: optId,
          ));
        }
      });

      // E. Repository Call
      await _repository.submitSurveyResponse(
        response: response, 
        answers: answersList
      );
      
      isSubmitting = false;
      notifyListeners();
      return null; // Success!

    } catch (e) {
      isSubmitting = false;
      notifyListeners();
      return "Save failed: $e";
    }
  }

  // --- PRIVATE HELPERS ---

  String? _validateAnswers() {
    for (var q in survey!.questions) {
      if (q.isMandatory) {
        final hasText = textAnswers[q.id]?.isNotEmpty ?? false;
        final hasOption = selectedOptions[q.id]?.isNotEmpty ?? false;
        
        if (!q.isHeader && !hasText && !hasOption) {
          return "Missing mandatory field: ${q.text}";
        }
      }
    }
    return null;
  }
}