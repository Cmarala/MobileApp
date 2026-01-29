import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/polling_providers.dart';
import 'polling_console_screen.dart';
import '../../../models/enums.dart';

class PollingDashboardScreen extends ConsumerStatefulWidget {
  const PollingDashboardScreen({super.key});

  @override
  ConsumerState<PollingDashboardScreen> createState() => _PollingDashboardScreenState();
}

class _PollingDashboardScreenState extends ConsumerState<PollingDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BoothInfo> _filterBooths(List<BoothInfo> booths) {
    if (_searchQuery.isEmpty) return booths;
    final query = _searchQuery.toLowerCase();
    return booths.where((booth) {
      return booth.name.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final boothsAsync = ref.watch(boothsStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Polling Live', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: boothsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $err', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.refresh(boothsStreamProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (booths) {
          final filteredBooths = _filterBooths(booths);
          return Column(
            children: [
              // Search Box
              Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search booth by name or number...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              // Stats Summary
              if (filteredBooths.isNotEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.how_to_vote, size: 18, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Showing ${filteredBooths.length} booth${filteredBooths.length != 1 ? "s" : ""}',
                        style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              // Booth List
              Expanded(
                child: filteredBooths.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No booths found',
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: filteredBooths.length,
                        itemBuilder: (context, index) {
                          final booth = filteredBooths[index];
                          return _BoothSummaryCard(
                            boothId: booth.id,
                            boothName: booth.name,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BoothSummaryCard extends ConsumerWidget {
  final String boothId;
  final String boothName;

  const _BoothSummaryCard({required this.boothId, required this.boothName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsStream = ref.watch(pollingRepositoryProvider).watchBoothStats(boothId);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PollingConsoleScreen(boothId: boothId, boothName: boothName),
              ),
            );
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error opening booth: ${e.toString()}'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.how_to_vote,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      boothName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: statsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: LinearProgressIndicator(minHeight: 2),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Error loading stats',
                        style: TextStyle(color: Colors.red[300], fontSize: 12),
                      ),
                    );
                  }
                  
                  final stats = snapshot.data ?? [];
                  return Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      _buildRow(['Tier', 'Total', 'Voted', 'Left'], isHeader: true),
                      ...VoterFavorability.values.map((tier) {
                        Map<String, dynamic>? tierData;
                        try {
                          tierData = stats.firstWhere(
                            (s) => s['favorability'] == tier.toValue(),
                          );
                        } catch (e) {
                          tierData = {'total': 0, 'polled': 0, 'remaining': 0};
                        }
                        return _buildRow(
                          [
                            tier.label,
                            '${tierData['total'] ?? 0}',
                            '${tierData['polled'] ?? 0}',
                            '${tierData['remaining'] ?? 0}',
                          ],
                          tierColor: tier.color,
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false, Color? tierColor}) {
    return TableRow(
      children: cells.asMap().entries.map((entry) {
        final index = entry.key;
        final cell = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              if (index == 0 && !isHeader && tierColor != null)
                Container(
                  width: 3,
                  height: 12,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: tierColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              Expanded(
                child: Text(
                  cell,
                  style: TextStyle(
                    fontSize: isHeader ? 12 : 13,
                    fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
                    color: isHeader ? Colors.grey[700] : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}