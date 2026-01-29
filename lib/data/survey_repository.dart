import 'package:powersync/powersync.dart';
import 'package:uuid/uuid.dart'; // Ensure you have this package
import 'package:mobileapp/models/survey_model.dart';
import 'package:mobileapp/utils/logger.dart';


class SurveyRepository {
  final PowerSyncDatabase _db;
  final _uuid = const Uuid();

  SurveyRepository(this._db);

  /// Generate a unique ID for entities
  String generateId() => _uuid.v4();

  /// Check if a survey response already exists for this voter+survey combination
  Future<String?> getExistingResponseId({required String surveyId, String? voterId}) async {
    if (voterId == null) return null; // Anonymous surveys can be submitted multiple times
    
    try {
      final results = await _db.getOptional(
        'SELECT id FROM survey_responses WHERE survey_id = ? AND voter_id = ? LIMIT 1',
        [surveyId, voterId],
      );
      return results?['id'] as String?;
    } catch (e, st) {
      Logger.logError(e, st, 'Error checking existing survey response');
      return null;
    }
  }

  // ===========================================================================
  // 1. FETCH LOGIC (The "Stitcher")
  // ===========================================================================

  /// Fetches a Survey + Questions + Options in a single robust call.
  /// We use 3 parallel queries instead of one massive JOIN to avoid 
  /// cartesian product performance issues and complex mapping logic.
  Future<Survey?> getSurveyWithDetails(String surveyId) async {
    // 1. Fetch the Survey Core
    final surveyRows = await _db.getAll(
      'SELECT * FROM surveys WHERE id = ?', 
      [surveyId]
    );

    if (surveyRows.isEmpty) return null;
    final surveyData = surveyRows.first;

    // 2. Fetch All Questions for this Survey
    final questionRows = await _db.getAll(
      'SELECT * FROM survey_questions WHERE survey_id = ? ORDER BY display_order ASC', 
      [surveyId]
    );

    // 3. Fetch All Options for these Questions
    // We fetch ALL options for this survey in one go to minimize DB roundtrips.
    final optionRows = await _db.getAll(
      '''
      SELECT o.* FROM survey_options o
      JOIN survey_questions q ON o.survey_question_id = q.id
      WHERE q.survey_id = ? 
      ORDER BY o.display_order ASC
      ''', 
      [surveyId]
    );

    // 4. The "Stitching" Logic (Dart side is faster than SQL for hierarchy)
    
    // Group options by question_id for O(1) lookup
    final optionsMap = <String, List<SurveyOption>>{};
    for (var row in optionRows) {
      final option = SurveyOption.fromJson(row);
      if (!optionsMap.containsKey(option.questionId)) {
        optionsMap[option.questionId] = [];
      }
      optionsMap[option.questionId]!.add(option);
    }

    // Map Questions and attach their Options
    final questions = questionRows.map((row) {
      final question = SurveyQuestion.fromJson(row);
      return question.copyWith(
        options: optionsMap[question.id] ?? [],
      );
    }).toList();

    // Return the fully hydrated Survey
    return Survey.fromJson(surveyData).copyWith(
      questions: questions,
    );
  }
  // Inside SurveyRepository class...

Future<List<Survey>> getActiveSurveys(String campaignId) async {
  final rows = await _db.getAll(
    'SELECT * FROM surveys WHERE campaign_id = ? AND is_active = 1 ORDER BY display_order ASC', 
    [campaignId]
  );
  
  return rows.map((row) => Survey.fromJson(row)).toList();
}
  // ===========================================================================
  // 2. SAVE LOGIC (The "Atomic Transaction")
  // ===========================================================================

  
  /// This ensures we never have "orphan" data or half-saved states.
  // lib/repositories/survey_repository.dart

  Future<void> submitSurveyResponse({
    required SurveyResponse response,
    required List<SurveyResponseOption> answers,
  }) async {
    try {
      await _db.writeTransaction((tx) async {
        // 1. Prepare ID
        final responseId = response.id ?? _uuid.v4();
        
        // 2. Check if response already exists (for voter-based surveys)
        String? existingResponseId;
        if (response.voterId != null) {
          final existing = await tx.getOptional(
            'SELECT id FROM survey_responses WHERE survey_id = ? AND voter_id = ?',
            [response.surveyId, response.voterId],
          );
          existingResponseId = existing?['id'] as String?;
        }

        if (existingResponseId != null) {
          // UPSERT: Update existing response
          await tx.execute(
            '''
            UPDATE survey_responses 
            SET status = ?, latitude = ?, longitude = ?, updated_at = ?
            WHERE id = ?
            ''',
            [
              response.status,
              response.latitude,
              response.longitude,
              DateTime.now().toIso8601String(),
              existingResponseId,
            ],
          );

          // Delete old answers before inserting new ones
          await tx.execute(
            'DELETE FROM survey_response_options WHERE survey_response_id = ?',
            [existingResponseId],
          );
        } else {
          // INSERT: New response
          await tx.execute(
            '''
            INSERT INTO survey_responses (
              id, campaign_id, survey_id, geo_unit_id, voter_id, 
              respondent_name, respondent_phone, status, 
              latitude, longitude, created_at, client_response_id
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              responseId,
              response.campaignId,
              response.surveyId,
              response.geoUnitId,
              response.voterId,
              response.respondentName,
              response.respondentPhone,
              response.status,
              response.latitude,
              response.longitude,
              DateTime.now().toIso8601String(),
              response.clientResponseId ?? _uuid.v4(),
            ],
          );
        }

        // 3. Insert new answers (using correct responseId)
        final targetResponseId = existingResponseId ?? responseId;
        
        for (var answer in answers) {
          final answerId = answer.id ?? _uuid.v4();
          
          await tx.execute(
            '''
            INSERT INTO survey_response_options (
              id, campaign_id, survey_response_id, survey_question_id, 
              survey_option_id, answer_value, created_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              answerId,
              answer.campaignId,
              targetResponseId,
              answer.questionId,
              answer.surveyOptionId,
              answer.answerValue,
              DateTime.now().toIso8601String(),
            ],
          );
        }
      });
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Error submitting survey response');
      rethrow;
    }
  }
}