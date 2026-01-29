import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/data/polling_repository.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/utils/logger.dart';

class PollingLiveState {
  final String searchQuery;
  final bool isHistoryMode; // false = Pending (To-Do), true = Voted (History)
  final String? selectedBoothId;

  PollingLiveState({
    this.searchQuery = '',
    this.isHistoryMode = false,
    this.selectedBoothId,
  });

  PollingLiveState copyWith({
    String? searchQuery,
    bool? isHistoryMode,
    String? selectedBoothId,
  }) {
    return PollingLiveState(
      searchQuery: searchQuery ?? this.searchQuery,
      isHistoryMode: isHistoryMode ?? this.isHistoryMode,
      selectedBoothId: selectedBoothId ?? this.selectedBoothId,
    );
  }
}

class PollingLiveController extends StateNotifier<PollingLiveState> {
  final PollingRepository _repository;
  final String _currentUserId;

  PollingLiveController(this._repository, this._currentUserId) 
      : super(PollingLiveState());

  // --- UI Controls ---

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleMode() {
    // When switching modes, we clear search to avoid confusion
    state = state.copyWith(isHistoryMode: !state.isHistoryMode, searchQuery: '');
  }

  // --- Directional Swipe Logic ---

  /// Handles swipes based on the current mode.
  /// This ensures 'Right Swipe' only works in Pending mode
  /// and 'Left Swipe' only works in History mode.
  Future<void> handleAction({
    required String voterId, 
    required bool isRightSwipe,
  }) async {
    try {
      if (!state.isHistoryMode && isRightSwipe) {
        // MODE: PENDING -> Swipe Right to Vote
        await _repository.markAsVoted(
          voterId: voterId, 
          userId: _currentUserId,
        );
      } else if (state.isHistoryMode && !isRightSwipe) {
        // MODE: HISTORY -> Swipe Left to Undo
        await _repository.undoVote(voterId);
      }
      // Any other swipe combination is ignored by the controller
    } catch (e, stackTrace) {
      // Log error and rethrow for UI to handle
      Logger.logError(e, stackTrace, 'Error in polling action');
      rethrow;
    }
  }

  // --- Streams ---

  Stream<List<Voter>> watchVoters(String boothId) {
    if (state.isHistoryMode) {
      return _repository.watchPolledVoters(boothId);
    } else {
      return _repository.watchPendingVoters(
        geoUnitId: boothId, 
        searchquery: state.searchQuery,
      );
    }
  }
}