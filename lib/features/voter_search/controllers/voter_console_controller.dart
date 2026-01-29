import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/features/voter_search/models/voter_search_filters.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoterConsoleController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController epicIdController = TextEditingController();
  final TextEditingController doorNoController = TextEditingController();
  final TextEditingController boothNoController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  VoterSearchFilters _filters = const VoterSearchFilters();
  Timer? _debounceTimer;
  
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;

  VoterSearchFilters get filters => _filters;
  bool get hasActiveFilters => _filters.hasActiveFilters;
  bool get isListening => _isListening;

  VoterConsoleController() {
    _setupListeners();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
      onError: (error) => _isListening = false,
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _isListening = false;
          notifyListeners();
        }
      },
    );
  }

  void toggleVoiceSearch() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
    } else {
      if (_speechAvailable) {
        _isListening = true;
        notifyListeners();
        await _speechToText.listen(
          onResult: (result) {
            searchController.text = result.recognizedWords;
            notifyListeners();
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 3),
        );
      }
    }
    notifyListeners();
  }

  void _setupListeners() {
    searchController.addListener(_onFilterChanged);
    epicIdController.addListener(_onFilterChanged);
    doorNoController.addListener(_onFilterChanged);
    boothNoController.addListener(_onFilterChanged);
    mobileController.addListener(_onFilterChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    epicIdController.dispose();
    doorNoController.dispose();
    boothNoController.dispose();
    mobileController.dispose();
    scrollController.dispose();
    _debounceTimer?.cancel();
    _speechToText.cancel();
    super.dispose();
  }

  void _onFilterChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _filters = VoterSearchFilters(
        epicId: epicIdController.text.trim(),
        doorNo: doorNoController.text.trim(),
        boothNo: boothNoController.text.trim(),
        mobileNumber: mobileController.text.trim(),
      );
      notifyListeners();
    });
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      notifyListeners();
    });
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  void clearAllFilters() {
    searchController.clear();
    epicIdController.clear();
    doorNoController.clear();
    boothNoController.clear();
    mobileController.clear();
    _filters = const VoterSearchFilters();
    notifyListeners();
  }

  Stream<List<Voter>> watchVoters() {
    return AppRepository.watchVoters(
      filters: _filters.toMap(),
      query: searchController.text.trim(),
    );
  }
}
