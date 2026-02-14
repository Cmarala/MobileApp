import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobileapp/volunteer/home_screen.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/sync/powersync_backend_connector.dart';
import 'package:mobileapp/sync/sync_state_manager.dart';
import 'package:mobileapp/sync/sync_diagnostics.dart';
import 'package:mobileapp/utils/asset_manager.dart';
import 'package:mobileapp/utils/logger.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String _syncStatus = "Initializing...";
  String? _splashPath;
  String? _error;
  bool _isSyncingVoters = false;
  int _recordCount = 0;

  @override
  void initState() {
    super.initState();
    _startSetup();
  }

  Future<void> _startSetup() async {
    try {
      setState(() => _error = null);
      
      Logger.logInfo('=== SYNC DEBUG: Starting setup ===');
      
      // Run diagnostics first
      final diagnostics = await SyncDiagnostics.runDiagnostics();
      final report = SyncDiagnostics.generateReport(diagnostics);
      Logger.logInfo(report);
      
      // Check for critical issues
      if (diagnostics['has_powersync_token'] != true) {
        throw Exception('Missing PowerSync token. Please reactivate the app.');
      }
      
      if (diagnostics['powersync_url_valid'] != true) {
        throw Exception('Invalid PowerSync URL configuration.');
      }
      
      // Initialize DB
      await PowerSyncService().initialize();
      final db = PowerSyncService().db;
      Logger.logInfo('SYNC DEBUG: DB initialized');
      
      // Check if this is first-time or incremental sync
      final isFirstSync = !await SyncStateManager.hasCompletedInitialSync();
      Logger.logInfo('SYNC DEBUG: isFirstSync = $isFirstSync');
      
      // SPLASH SCREEN FIX: Check cache first (works for returning users)
      final cachedSplash = await AssetManager.getAssetPath('splash_screen_image');
      if (cachedSplash != null && mounted) {
        setState(() => _splashPath = cachedSplash);
      }
      
      if (isFirstSync) {
        // FULL SYNC FLOW - First-time users
        Logger.logInfo('SYNC DEBUG: Starting FULL SYNC flow');
        
        // Setup status listener BEFORE connecting
        db.statusStream.listen((status) {
          Logger.logInfo('SYNC DEBUG: Status update - connected: ${status.connected}, downloading: ${status.downloading}, uploading: ${status.uploading}, lastSyncedAt: ${status.lastSyncedAt}');
          _onSyncStatusChange(status);
        });
        
        Logger.logInfo('SYNC DEBUG: Connecting to PowerSync...');
        await db.connect(connector: MyPowerSyncBackendConnector());
        Logger.logInfo('SYNC DEBUG: Connected to PowerSync');
        
        // Check connection status
        final currentStatus = db.currentStatus;
        Logger.logInfo('SYNC DEBUG: Current status after connect - connected: ${currentStatus.connected}, hasSynced: ${currentStatus.hasSynced}');
        
        setState(() => _syncStatus = "Optimizing offline files...");
        await AssetManager.cacheAllActiveAssetsParallel();
        Logger.logInfo('SYNC DEBUG: Assets cached');
        
        setState(() {
          _isSyncingVoters = true;
          _syncStatus = "Syncing voter records...";
        });
        
        Logger.logInfo('SYNC DEBUG: Waiting for first sync...');
        
        // Add timeout protection for waitForFirstSync
        try {
          await db.waitForFirstSync().timeout(
            const Duration(seconds: 120),
            onTimeout: () {
              Logger.logError('waitForFirstSync timed out after 120 seconds', null);
              throw TimeoutException('Sync took too long. Please check your connection.');
            },
          );
          Logger.logInfo('SYNC DEBUG: First sync completed!');
        } catch (e) {
          Logger.logError('SYNC DEBUG: waitForFirstSync failed', null, e.toString());
          rethrow;
        }
        
        // Check what actually synced
        await _logDatabaseCounts();
        
        // Download splash for next launch (after campaign_assets synced)
        if (_splashPath == null) {
          setState(() => _syncStatus = "Finalizing setup...");
          await _downloadAssetWithTimeout('splash_screen_image', 3000);
        }
        
        // Mark as completed
        await SyncStateManager.markInitialSyncComplete();
        
      } else {
        // INCREMENTAL SYNC FLOW - Fast path for returning users
        Logger.logInfo('SYNC DEBUG: Starting INCREMENTAL sync flow');
        setState(() => _syncStatus = "Checking for updates...");
        
        // Connect and let background sync run
        await db.connect(connector: MyPowerSyncBackendConnector());
        Logger.logInfo('SYNC DEBUG: Connected for incremental sync');
        
        // Download only new/changed assets
        await AssetManager.updateCachedAssets();
        Logger.logInfo('SYNC DEBUG: Updated cached assets');
        
        // Don't wait - background sync handles incremental updates
        await Future.delayed(const Duration(milliseconds: 500));
        Logger.logInfo('SYNC DEBUG: Incremental sync flow complete');
      }
      
      Logger.logInfo('SYNC DEBUG: Sync setup complete, navigating to HomeScreen');
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e, st) {
      Logger.logError('Sync sequence failed', st, 'SYNC ERROR: ${e.toString()}');
      if (mounted) {
        final errorMsg = e is TimeoutException 
            ? "Sync timed out. Check your connection and try again."
            : "Sync failed: ${e.toString()}";
        setState(() => _error = errorMsg);
      }
    }
  }

  /// Helper method for splash download with timeout
  Future<void> _downloadAssetWithTimeout(String type, int milliseconds) async {
    try {
      final path = await AssetManager.getAssetPath(type)
          .timeout(Duration(milliseconds: milliseconds));
      if (path != null && mounted) {
        setState(() => _splashPath = path);
      }
    } catch (e) {
      Logger.logInfo('Splash download timeout - will retry next launch');
    }
  }

  /// Debug helper to check database record counts
  Future<void> _logDatabaseCounts() async {
    try {
      final db = PowerSyncService().db;
      
      // Check voters count
      final votersResult = await db.execute('SELECT COUNT(*) as count FROM voters');
      final votersCount = votersResult.isNotEmpty ? votersResult.first['count'] : 0;
      
      // Check other tables
      final surveysResult = await db.execute('SELECT COUNT(*) as count FROM surveys');
      final surveysCount = surveysResult.isNotEmpty ? surveysResult.first['count'] : 0;
      
      final assetsResult = await db.execute('SELECT COUNT(*) as count FROM campaign_assets');
      final assetsCount = assetsResult.isNotEmpty ? assetsResult.first['count'] : 0;
      
      Logger.logInfo('SYNC DEBUG: Database counts - Voters: $votersCount, Surveys: $surveysCount, Assets: $assetsCount');
      
      if (votersCount > 0) {
        // Sample first voter to check data quality
        final sampleVoter = await db.execute('SELECT id, name, epic_id FROM voters LIMIT 1');
        Logger.logInfo('SYNC DEBUG: Sample voter: ${sampleVoter.first}');
      }
    } catch (e) {
      Logger.logError('Failed to check database counts', null, e.toString());
    }
  }

  void _onSyncStatusChange(dynamic status) {
    if (!mounted) return;
    if (status.downloading == true && _isSyncingVoters) {
      _updateRecordCountAndStatus();
    }
  }
  
  /// Update the current record count in the database and status message
  Future<void> _updateRecordCountAndStatus() async {
    try {
      final db = PowerSyncService().db;
      final result = await db.execute('SELECT COUNT(*) as count FROM voters');
      final count = result.isNotEmpty ? (result.first['count'] as int?) ?? 0 : 0;
      if (mounted && count != _recordCount) {
        setState(() {
          _recordCount = count;
          _syncStatus = "Building your offline voter database... $_recordCount records downloaded";
        });
      }
    } catch (e) {
      // Ignore errors during count updates
    }
  }

  /// Update the current record count in the database
  Future<void> _updateRecordCount() async {
    try {
      final db = PowerSyncService().db;
      final result = await db.execute('SELECT COUNT(*) as count FROM voters');
      final count = result.isNotEmpty ? (result.first['count'] as int?) ?? 0 : 0;
      if (mounted && count != _recordCount) {
        setState(() => _recordCount = count);
      }
    } catch (e) {
      // Ignore errors during count updates
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildSplashBackground(),
          Container(color: Colors.black.withAlpha(140)),
          Center(
            child: _error != null ? _buildErrorView() : _buildLoadingView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashBackground() {
    if (_splashPath == null) return const SizedBox.shrink();
    final file = File(_splashPath!);
    if (!file.existsSync()) return const SizedBox.shrink();
    return Positioned.fill(child: Image.file(file, fit: BoxFit.cover));
  }

  Widget _buildLoadingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        const SizedBox(height: 24),
        Text(_syncStatus, 
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        if (_isSyncingVoters && _recordCount > 0) ...[
          const SizedBox(height: 8),
          Text('$_recordCount records synced',
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "IMPORTANT: Keep app open while we prepare your campaign data.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.cloud_off, color: Colors.redAccent, size: 60),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(_error!, 
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _startSetup, child: const Text("Retry Sync")),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () async {
            await _logDatabaseCounts();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Check console logs for debug info')),
              );
            }
          },
          child: const Text("Check Database Status", 
            style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}