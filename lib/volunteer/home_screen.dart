import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/utils/asset_manager.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:mobileapp/features/survey/screens/survey_list_screen.dart';
import 'package:mobileapp/features/polling/screens/polling_dashboard_screen.dart' as polling;
import 'package:mobileapp/features/reports/screens/reports_entry_screen.dart';
import 'package:mobileapp/features/dashboard/screens/dashboard_screen.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/widgets/app_bottom_nav.dart';
import 'package:mobileapp/features/settings/screens/settings_screen.dart';
import 'package:mobileapp/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _localizedFeatures(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Fallback to English labels if localization is not available
    if (l10n == null) {
      return [
        {'icon': Icons.search, 'label': 'Voter Search', 'route': 'voter_search'},
        {'icon': Icons.poll, 'label': 'Survey', 'route': 'survey'},
        {'icon': Icons.how_to_reg, 'label': 'Polling Live', 'route': 'polling_live'},
        {'icon': Icons.dashboard, 'label': 'Dashboard', 'route': 'dashboard'},
        {'icon': Icons.bar_chart, 'label': 'Reports', 'route': 'reports'},
        {'icon': Icons.settings, 'label': 'Settings', 'route': 'settings'},
      ];
    }
    
    return [
      {'icon': Icons.search, 'label': l10n.voterSearch, 'route': 'voter_search'},
      {'icon': Icons.poll, 'label': l10n.survey, 'route': 'survey'},
      {'icon': Icons.how_to_reg, 'label': l10n.pollingLive, 'route': 'polling_live'},
      {'icon': Icons.dashboard, 'label': l10n.dashboard, 'route': 'dashboard'},
      {'icon': Icons.bar_chart, 'label': l10n.reports, 'route': 'reports'},
      {'icon': Icons.settings, 'label': l10n.settings, 'route': 'settings'},
    ];
  }
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final features = _localizedFeatures(context);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>?>(
          future: AppRepository.getActiveCampaign(),
          builder: (context, snapshot) {
            final name = snapshot.data?['name'] ?? 'Campaign Console';
            return Text(name, style: const TextStyle(fontWeight: FontWeight.bold));
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Banner Section: Using Path-First Architecture
          Expanded(
            flex: 6,
            child: FutureBuilder<String?>(
              // Logic is now purely "Get me the file path"
              // TODO: Change back to 'home_screen_image' once it's added to campaign_assets table
              future: AssetManager.getAssetPath('splash_screen_image'),
              builder: (context, snapshot) {
                Logger.logInfo('🖼️  [HOME SCREEN] Image FutureBuilder state: ${snapshot.connectionState}');
                if (snapshot.hasData) {
                  Logger.logInfo('🖼️  [HOME SCREEN] Image path received: ${snapshot.data}');
                } else if (snapshot.hasError) {
                  Logger.logError(snapshot.error ?? 'Unknown error', snapshot.stackTrace, 'Image loading error');
                }
                return _buildBannerImage(snapshot.data);
              },
            ),
          ),
          // Features Grid
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return _buildFeatureButton(
                  context,
                  icon: feature['icon'],
                  label: feature['label'],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  /// UI Logic: Handles how to display the file once AssetManager finds it
  Widget _buildBannerImage(String? path) {
    if (path == null) {
      Logger.logInfo('🖼️  [DISPLAY] No path provided, showing placeholder');
      return _buildImagePlaceholder();
    }

    Logger.logInfo('🖼️  [DISPLAY] Checking if file exists: $path');
    final file = File(path);
    if (!file.existsSync()) {
      Logger.logInfo('❌ [DISPLAY] File does not exist at path: $path');
      return _buildImagePlaceholder();
    }

    Logger.logInfo('✅ [DISPLAY] File exists, attempting to display image');
    return SizedBox(
      width: double.infinity,
      child: Image.file(
        file,
        fit: BoxFit.cover,
        // If file is corrupted, show placeholder
        errorBuilder: (context, error, stackTrace) {
          Logger.logError(error, stackTrace, 'Image display error');
          return _buildImagePlaceholder();
        },
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: const Icon(Icons.campaign_outlined, size: 64, color: Colors.grey),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleFeatureTap(context, label),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              label, 
              textAlign: TextAlign.center, 
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
            ),
          ],
        ),
      ),
    );
  }

  void _handleFeatureTap(BuildContext context, String label) async {
    // Find the feature config
    final features = _localizedFeatures(context);
    final feature = features.firstWhere(
      (f) => f['label'] == label,
      orElse: () => {'route': null},
    );

    final route = feature['route'];
    
    if (route == 'voter_search') {
      try {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const VoterConsoleScreen()),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error opening Voter Search: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } else if (route == 'survey') {
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);
      
      try {
        final campaign = await AppRepository.getActiveCampaign();
        final campaignId = campaign?['id'];
        
        if (campaignId == null) {
          if (mounted) {
            messenger.showSnackBar(
              const SnackBar(
                content: Text('No active campaign found'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        // Get user's geo_unit_id from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final geoUnitId = prefs.getString('geo_unit_id');
        
        if (geoUnitId == null) {
          if (mounted) {
            messenger.showSnackBar(
              const SnackBar(
                content: Text('User geo unit not found. Please re-activate the app.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        if (mounted) {
          navigator.push(
            MaterialPageRoute(
              builder: (context) => SurveyListScreen(
                db: PowerSyncService().db,
                campaignId: campaignId,
                currentGeoUnitId: geoUnitId,
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(
              content: Text('Error opening Survey: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } else if (route == 'polling_live') {
      try {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return polling.PollingDashboardScreen();
            },
          ),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error opening Polling Live: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } else if (route == 'dashboard') {
      try {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error opening Dashboard: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } else if (route == 'settings') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    } else if (route == 'reports') {
      try {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ReportsEntryScreen()),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error opening Reports: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label feature is not yet available')),
      );
    }
  }
}