import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/models/voter.dart';

class VoterConsoleController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  Map<String, dynamic> _filters = {};
  Timer? _debounceTimer;

  Map<String, dynamic> get filters => _filters;

  VoterConsoleController({Map<String, dynamic>? initialFilters}) {
    _initFilters(initialFilters);
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _initFilters(Map<String, dynamic>? initialFilters) async {
    final savedFilters = await AppRepository.getPersistentFilters();
    _filters = initialFilters ?? savedFilters;
    notifyListeners();
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

  void updateFilters(Map<String, dynamic> newFilters) {
    _filters = newFilters;
    notifyListeners();
  }

  Stream<List<Voter>> watchVoters() {
    return AppRepository.watchVoters(
      filters: _filters,
      query: searchController.text.trim(),
    );
  }
}
