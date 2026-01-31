import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powersync/powersync.dart';
import 'package:mobileapp/models/survey_model.dart';
import 'package:mobileapp/data/survey_repository.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:mobileapp/features/survey/screens/survey_screen.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart'; 

class SurveyListScreen extends ConsumerStatefulWidget {
  final PowerSyncDatabase db;
  final String campaignId;
  final String currentGeoUnitId; // The volunteer's current booth

  const SurveyListScreen({
    super.key,
    required this.db,
    required this.campaignId,
    required this.currentGeoUnitId,
  });

  @override
  ConsumerState<SurveyListScreen> createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends ConsumerState<SurveyListScreen> {
  late SurveyRepository _repo;
  List<Survey> _surveys = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repo = SurveyRepository(widget.db);
    _loadSurveys();
  }

  Future<void> _loadSurveys() async {
    final list = await _repo.getActiveSurveys(widget.campaignId);
    if (mounted) {
      setState(() {
        _surveys = list;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Campaign Surveys")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _surveys.isEmpty
              ? const Center(child: Text("No active surveys found."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _surveys.length,
                  itemBuilder: (context, index) {
                    return _buildSurveyCard(_surveys[index]);
                  },
                ),
    );
  }

  Widget _buildSurveyCard(Survey survey) {
    final langCode = ref.watch(settingsProvider).langCode;
    
    // Icon logic based on mode
    IconData icon;
    Color color;
    
    switch (survey.mode) {
      case SurveyMode.opinionPoll:
        icon = Icons.poll;
        color = Colors.purple;
        break;
      case SurveyMode.complaintBox:
        icon = Icons.camera_alt;
        color = Colors.orange;
        break;
      case SurveyMode.standardForm:
        icon = Icons.assignment;
        color = Colors.blue;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          BilingualHelper.getSurveyTitle(survey.title, survey.titleLocal, langCode),
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        subtitle: Text(
          BilingualHelper.getSurveyDescription(
            survey.description ?? (survey.requiresVoterContext ? "Requires Voter Selection" : "General Survey"),
            survey.descriptionLocal,
            langCode
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _handleSurveyTap(survey),
      ),
    );
  }

  void _handleSurveyTap(Survey survey) {
    if (survey.requiresVoterContext) {
      // CASE A: VOTER SURVEY - Must pick a voter first
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => VoterConsoleScreen(
            onVoterSelected: (voter) {
              // Close the picker
              Navigator.pop(context);
              
              // Navigate to Survey with voter context
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurveyScreen(
                    db: widget.db,
                    surveyId: survey.id,
                    campaignId: widget.campaignId,
                    geoUnitId: widget.currentGeoUnitId,
                    voterId: voter.id,
                    voterSnapshot: {
                      'name': voter.name,
                      'age': voter.age,
                      'epic_id': voter.epicId,
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      // CASE B: GENERAL / ANONYMOUS SURVEY - Go straight to the form
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => SurveyScreen(
            db: widget.db,
            surveyId: survey.id,
            campaignId: widget.campaignId,
            geoUnitId: widget.currentGeoUnitId,
            voterId: null, // No voter
          ),
        ),
      );
    }
  }
}