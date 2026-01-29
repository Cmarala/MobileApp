import 'package:flutter/material.dart' hide Column;
import 'package:flutter/material.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powersync/powersync.dart';
import 'package:mobileapp/features/survey/controllers/survey_controller.dart';
import 'package:mobileapp/data/survey_repository.dart';
import 'package:mobileapp/features/voter_search/screens/voter_detail_screen.dart';
import 'package:mobileapp/features/survey/widgets/question_renderer.dart';
import 'package:mobileapp/features/survey/services/voter_service.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  // Navigation Args
  final String surveyId;
  final String campaignId;
  final String geoUnitId;
  final String? voterId; 
  final Map<String, dynamic>? voterSnapshot;

  // Dependency Injection
  final PowerSyncDatabase db; 

  const SurveyScreen({
    Key? key,
    required this.db,
    required this.surveyId,
    required this.campaignId,
    required this.geoUnitId,
    this.voterId,
    this.voterSnapshot,
  }) : super(key: key);

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  late SurveyController _controller;
  late VoterService _voterService;
  Map<String, dynamic>? _voterSnapshot;
  final _respondentNameController = TextEditingController();
  final _respondentPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _voterSnapshot = widget.voterSnapshot;
    _voterService = VoterService(widget.db);
    
    // Initialize Controller
    _controller = SurveyController(
      repository: SurveyRepository(widget.db),
      surveyId: widget.surveyId,
      campaignId: widget.campaignId,
      geoUnitId: widget.geoUnitId,
      voterId: widget.voterId,
    );
  }

  @override
  void dispose() {
    _respondentNameController.dispose();
    _respondentPhoneController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder listens to ChangeNotifier (Flutter 3.10+)
    // If on older Flutter, use AnimatedBuilder
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        if (_controller.isLoading && _controller.survey == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (_controller.errorMessage != null) {
          return Scaffold(body: Center(child: Text(_controller.errorMessage!)));
        }

        final survey = _controller.survey!;
        final langCode = ref.watch(settingsProvider).langCode;

        return Scaffold(
          appBar: AppBar(
            title: Text(BilingualHelper.getSurveyTitle(survey.title, survey.titleLocal, langCode))
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: flutter.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Context Header
                _buildContextHeader(),
                
                const SizedBox(height: 24),
                const Divider(thickness: 2),
                const SizedBox(height: 24),

                // 2. Question List
                ...survey.questions.map((q) {
                  return QuestionRenderer(
                    question: q,
                    // Read from Controller
                    currentAnswerValue: _controller.getTextValue(q.id),
                    selectedOptionIds: _controller.getOptionIds(q.id),
                    // Write to Controller
                    onTextChanged: (val) => _controller.setTextAnswer(q.id, val),
                    onOptionChanged: (ids) => _controller.setOptionAnswer(q.id, ids),
                  );
                }).toList(),

                // 3. Submit Button
                const SizedBox(height: 32),
                
                // Show warning if survey already completed
                if (_controller.hasExistingResponse)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This survey was already completed. Submitting will update the previous response.',
                            style: TextStyle(color: Colors.orange.shade900, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _controller.isSubmitting ? null : _handleSubmit,
                    child: _controller.isSubmitting 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(_controller.hasExistingResponse ? "UPDATE SURVEY" : "SUBMIT SURVEY"),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContextHeader() {
    // STATE A: Voter Mode
    if (widget.voterId != null && _voterSnapshot != null) {
      return Card(
        color: Colors.blue.shade50,
        elevation: 2,
        child: ListTile(
          leading: const Icon(Icons.person, size: 40, color: Colors.blue),
          title: Text(
            _voterSnapshot!['name']?.toString() ?? 'Voter',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            'Age: ${_voterSnapshot!['age']?.toString() ?? '--'} | EPIC: ${_voterSnapshot!['epic_id']?.toString() ?? '--'}',
            style: const TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _navigateToVoterDetail(),
          ),
        ),
      );
    } 
    
    // STATE B: General Mode
    else {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: flutter.Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Respondent Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _respondentNameController,
                decoration: const InputDecoration(
                  labelText: "Respondent Name *",
                  hintText: "Enter full name",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Respondent name is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  _controller.setRespondentInfo(name: value.trim());
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _respondentPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  hintText: "Optional",
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _controller.setRespondentInfo(phone: value.trim());
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  // --- UI EVENT HANDLERS ---

  Future<void> _navigateToVoterDetail() async {
    if (widget.voterId == null) return;

    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VoterDetailScreen(voterId: widget.voterId!),
        ),
      );

      // Refresh voter snapshot after returning
      if (mounted) {
        final updatedSnapshot = await _voterService.getVoterSnapshot(widget.voterId!);
        if (updatedSnapshot != null) {
          setState(() {
            _voterSnapshot = updatedSnapshot;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to voter detail: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _handleSubmit() async {
    try {
      final error = await _controller.submit();
      
      if (!mounted) return;

      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Survey Saved!"), 
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error), 
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting survey: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}