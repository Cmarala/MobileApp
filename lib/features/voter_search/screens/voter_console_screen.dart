import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/voter_search/controllers/voter_console_controller.dart';
import 'package:mobileapp/features/voter_search/screens/voter_detail_screen.dart';
import 'package:mobileapp/widgets/voter_filter_drawer.dart';
import 'package:mobileapp/widgets/app_bottom_nav.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';

class VoterConsoleScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final Function(Voter)? onVoterSelected;
  
  const VoterConsoleScreen({super.key, this.initialFilters, this.onVoterSelected});

  @override
  ConsumerState<VoterConsoleScreen> createState() => _VoterConsoleScreenState();
}

class _VoterConsoleScreenState extends ConsumerState<VoterConsoleScreen> {
  late VoterConsoleController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = VoterConsoleController(initialFilters: widget.initialFilters);
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openFilterDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoterFilterDrawer(
        initialFilters: _controller.filters,
        onApply: (newFilters) {
          _controller.updateFilters(newFilters);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPickerMode = widget.onVoterSelected != null;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isPickerMode ? 'Select Voter' : 'Voter Console',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: _controller.filters.isNotEmpty,
              backgroundColor: Colors.orange,
              child: const Icon(Icons.filter_list),
            ),
            onPressed: _openFilterDrawer,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller.searchController,
              onChanged: _controller.onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by Name or EPIC ID',
                prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                suffixIcon: _controller.searchController.text.isNotEmpty 
                  ? IconButton(
                      icon: const Icon(Icons.clear), 
                      onPressed: _controller.clearSearch,
                    )
                  : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Reactive Results Section
          Expanded(
            child: StreamBuilder<List<Voter>>(
              stream: _controller.watchVoters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final voters = snapshot.data ?? [];

                if (voters.isEmpty) {
                  return const Center(
                    child: Text('No voters found for these criteria.', 
                      style: TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  controller: _controller.scrollController,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: voters.length,
                  itemBuilder: (context, index) {
                    final langCode = ref.watch(settingsProvider).langCode;
                    return _VoterCard(
                      voter: voters[index],
                      langCode: langCode,
                      onVoterSelected: widget.onVoterSelected,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.onVoterSelected != null
          ? null
          : AppBottomNav(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
    );
  }
}

// --- Optimized Voter Card (Stateless to prevent unnecessary rebuilds) ---

class _VoterCard extends StatelessWidget {
  final Voter voter;
  final String langCode;
  final Function(Voter)? onVoterSelected;
  
  const _VoterCard({required this.voter, required this.langCode, this.onVoterSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          if (onVoterSelected != null) {
            onVoterSelected!(voter);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VoterDetailScreen(voterId: voter.id)),
            );
          }
        },
        leading: Container(
          width: 5,
          height: 40,
          decoration: BoxDecoration(
            color: voter.favorability.color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Text(
          BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode).isEmpty 
            ? 'Unknown' 
            : BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('EPIC: ${voter.epicId ?? "N/A"}', style: const TextStyle(fontFamily: 'monospace')),
            if (voter.geoAddress != null)
              Text(
                voter.geoAddress!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey[600]),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
