import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/polling_providers.dart';
import '../../../models/voter.dart';
import '../../../utils/bilingual_helper.dart';
import '../../settings/providers/settings_providers.dart';

class PollingConsoleScreen extends ConsumerWidget {
  final String boothId;
  final String boothName;

  const PollingConsoleScreen({
    super.key, 
    required this.boothId, 
    required this.boothName
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pollingLiveControllerProvider);
    final controller = ref.read(pollingLiveControllerProvider.notifier);
    final votersAsync = ref.watch(pollingVoterStreamProvider(boothId));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(boothName, style: const TextStyle(fontSize: 16)),
            Text(
              state.isHistoryMode ? 'History / Undo Mode' : 'Live Polling Mode',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Search and Toggle Section
          _buildTopPanel(context, ref, state, controller),

          // 2. The Voter List
          Expanded(
            child: votersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (voters) => voters.isEmpty
                  ? _buildEmptyState(state.isHistoryMode)
                  : ListView.builder(
                      itemCount: voters.length,
                      itemBuilder: (context, index) => _PollingVoterCard(
                        voter: voters[index],
                        isHistoryMode: state.isHistoryMode,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPanel(BuildContext context, WidgetRef ref, state, controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Column(
        children: [
          TextField(
            onChanged: controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'Search Name or Serial Number...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pending'),
              Switch(
                value: state.isHistoryMode,
                onChanged: (_) => controller.toggleMode(),
                activeThumbColor: Colors.orange,
              ),
              const Text('Voted (Undo)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isHistory) {
    return Center(
      child: Text(
        isHistory ? 'No one has voted yet.' : 'All voters polled or no matches found.',
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

class _PollingVoterCard extends ConsumerWidget {
  final Voter voter;
  final bool isHistoryMode;

  const _PollingVoterCard({required this.voter, required this.isHistoryMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pollingLiveControllerProvider.notifier);
    final langCode = ref.watch(settingsProvider).langCode;

    return Dismissible(
      key: Key('polling_${voter.id}_$isHistoryMode'),
      // Directional Control based on your requirement
      direction: isHistoryMode 
          ? DismissDirection.endToStart  // History mode: Only Left Swipe (Undo)
          : DismissDirection.startToEnd, // Pending mode: Only Right Swipe (Vote)
      
      background: _buildSwipeBackground(Alignment.centerLeft, Colors.green, Icons.check_circle, 'VOTED'),
      secondaryBackground: _buildSwipeBackground(Alignment.centerRight, Colors.red, Icons.undo, 'UNDO'),
      
      onDismissed: (direction) async {
        try {
          await controller.handleAction(
            voterId: voter.id,
            isRightSwipe: direction == DismissDirection.startToEnd,
          );
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${e.toString()}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: voter.favorability.color.withOpacity(0.2),
          child: Text('${voter.serialNumber ?? '?' }', 
            style: TextStyle(color: voter.favorability.color, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode).isEmpty
            ? 'Unknown Voter'
            : BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode),
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        subtitle: Text('Age: ${voter.age} | ${voter.gender?.label} | Section: ${voter.sectionNumber}'),
        trailing: isHistoryMode 
            ? const Icon(Icons.history, color: Colors.orange)
            : Icon(Icons.circle_outlined, color: Colors.grey.shade300),
      ),
    );
  }

  Widget _buildSwipeBackground(Alignment align, Color color, IconData icon, String label) {
    return Container(
      color: color,
      alignment: align,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (align == Alignment.centerLeft) Icon(icon, color: Colors.white),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          if (align == Alignment.centerRight) Icon(icon, color: Colors.white),
        ],
      ),
    );
  }
}