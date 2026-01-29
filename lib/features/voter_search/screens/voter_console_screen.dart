import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/voter_search/controllers/voter_console_controller.dart';
import 'package:mobileapp/features/voter_search/screens/voter_detail_screen.dart';
import 'package:mobileapp/features/voter_search/widgets/search_filter_chip.dart';
import 'package:mobileapp/features/voter_search/widgets/voter_list_card.dart';
import 'package:mobileapp/widgets/app_bottom_nav.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';

class VoterConsoleScreen extends ConsumerStatefulWidget {
  final Function(Voter)? onVoterSelected;
  
  const VoterConsoleScreen({super.key, this.onVoterSelected});

  @override
  ConsumerState<VoterConsoleScreen> createState() => _VoterConsoleScreenState();
}

class _VoterConsoleScreenState extends ConsumerState<VoterConsoleScreen> {
  late VoterConsoleController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = VoterConsoleController();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPickerMode = widget.onVoterSelected != null;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          isPickerMode ? 'Select Voter' : 'Voter Search',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          if (_controller.hasActiveFilters)
            IconButton(
              icon: const Icon(Icons.clear_all, color: Colors.red),
              onPressed: _controller.clearAllFilters,
              tooltip: 'Clear All Filters',
            ),
        ],
      ),
      body: Column(
        children: [
          // Compact Filters Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            child: Column(
              children: [
                // Name filter with voice search
                Row(
                  children: [
                    Expanded(
                      child: SearchFilterChip(
                        controller: _controller.searchController,
                        label: 'Name',
                        icon: Icons.person_outline,
                        hint: 'Search by Name',
                        onClear: () => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: _controller.isListening ? Colors.red.shade50 : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _controller.isListening ? Colors.red.shade200 : Colors.blue.shade200,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        icon: Icon(
                          _controller.isListening ? Icons.mic : Icons.mic_none,
                          color: _controller.isListening ? Colors.red : Colors.blue,
                        ),
                        onPressed: _controller.toggleVoiceSearch,
                        tooltip: _controller.isListening ? 'Stop' : 'Voice',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // EPIC ID and Door No
                Row(
                  children: [
                    Expanded(
                      child: SearchFilterChip(
                        controller: _controller.epicIdController,
                        label: 'EPIC',
                        icon: Icons.badge_outlined,
                        hint: 'ABC1234567',
                        onClear: () => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: SearchFilterChip(
                        controller: _controller.doorNoController,
                        label: 'Door',
                        icon: Icons.door_front_door_outlined,
                        hint: '12-34',
                        onClear: () => setState(() {}),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Booth No and Mobile
                Row(
                  children: [
                    Expanded(
                      child: SearchFilterChip(
                        controller: _controller.boothNoController,
                        label: 'Booth',
                        icon: Icons.place_outlined,
                        hint: '123',
                        keyboardType: TextInputType.number,
                        onClear: () => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: SearchFilterChip(
                        controller: _controller.mobileController,
                        label: 'Mobile',
                        icon: Icons.phone_outlined,
                        hint: '9876543210',
                        keyboardType: TextInputType.phone,
                        onClear: () => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Results Section
          Expanded(
            child: StreamBuilder<List<Voter>>(
              stream: _controller.watchVoters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final voters = snapshot.data ?? [];

                if (voters.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No voters found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    // Results Count
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Icon(Icons.people_outline, size: 18, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(
                            '${voters.length} voter${voters.length != 1 ? 's' : ''} found',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Voter List
                    Expanded(
                      child: ListView.builder(
                        controller: _controller.scrollController,
                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                        itemCount: voters.length,
                        itemBuilder: (context, index) {
                          final langCode = ref.watch(settingsProvider).langCode;
                          final voter = voters[index];
                          
                          return VoterListCard(
                            voter: voter,
                            langCode: langCode,
                            onTap: () {
                              if (widget.onVoterSelected != null) {
                                widget.onVoterSelected!(voter);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VoterDetailScreen(voterId: voter.id),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
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
