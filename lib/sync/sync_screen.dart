import 'package:flutter/material.dart';
import 'package:mobileapp/volunteer/home_screen.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/sync/powersync_backend_connector.dart';
import 'package:mobileapp/utils/image_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobileapp/utils/logger.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool _syncing = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startSync();
  }

  Future<void> _startSync() async {
    try {
      Logger.logInfo('Starting sync process...');
      // Initialize PowerSyncService (local DB, repositories, etc)
      Logger.logInfo('Initializing PowerSyncService...');
      await PowerSyncService().initialize();
      Logger.logInfo('PowerSyncService initialized. Creating connector...');
      final connector = MyPowerSyncBackendConnector();
      final db = PowerSyncService().db;
      Logger.logInfo('About to check initial_sync_done flag...');
      final prefs = await SharedPreferences.getInstance();
      final isFirstSync = !(prefs.getBool('initial_sync_done') ?? false);
      Logger.logInfo('isFirstSync: $isFirstSync');
      try {
        await db.connect(connector: connector);
        Logger.logInfo('db.connect(connector: connector) completed successfully.');
      } catch (e, st) {
        Logger.logError('db.connect(connector: connector) threw: $e\n$st', st);
        rethrow;
      }
      Logger.logInfo('Database connected. Sync should be running.');

      // Download and cache campaign asset images for offline use
      try {
        // Query campaign_assets for image URLs
        final assetRows = await db.query('SELECT file_url, title FROM campaign_assets WHERE file_url IS NOT NULL AND is_active = 1');
        for (final row in assetRows) {
          final url = row['file_url'] as String?;
          final title = row['title'] as String? ?? 'asset';
          if (url != null && url.isNotEmpty) {
            // Use title or hash for filename
            final filename = '${title.replaceAll(' ', '_')}_${url.hashCode}.img';
            // Download and cache
            await ImageCacheUtil.downloadAndCacheImage(url, filename);
          }
        }
        Logger.logInfo('Campaign asset images downloaded and cached.');
      } catch (e, st) {
        Logger.logError('Image download/cache failed: $e\n$st', st);
      }

      if (isFirstSync) {
        await prefs.setBool('initial_sync_done', true);
        Logger.logInfo('Initial sync done, navigating to HomeScreen.');
      } else {
        Logger.logInfo('Quick sync done, navigating to HomeScreen.');
      }

      if (!mounted) return;
      setState(() => _syncing = false);

      // Navigate to HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e, st) {
      Logger.logError('Sync failed: $e\n$st', st);
      if (mounted) setState(() { _error = e.toString(); _syncing = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _syncing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Downloading campaign data...'),
                ],
              )
            : _error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text('Sync failed: $_error'),
                    ],
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}
