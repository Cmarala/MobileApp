import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobileapp/volunteer/home_screen.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/sync/powersync_backend_connector.dart';
import 'package:mobileapp/sync/sync_state_manager.dart';
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

  @override
  void initState() {
    super.initState();
    _startSetup();
  }

  Future<void> _startSetup() async {
    try {
      setState(() => _error = null);
      
      // Initialize DB
      await PowerSyncService().initialize();
      final db = PowerSyncService().db;
      
      // Check if this is first-time or incremental sync
      final isFirstSync = !await SyncStateManager.hasCompletedInitialSync();
      
      // SPLASH SCREEN FIX: Check cache first (works for returning users)
      final cachedSplash = await AssetManager.getAssetPath('splash_screen_image');
      if (cachedSplash != null && mounted) {
        setState(() => _splashPath = cachedSplash);
      }
      
      if (isFirstSync) {
        // FULL SYNC FLOW - First-time users
        db.statusStream.listen(_onSyncStatusChange);
        await db.connect(connector: MyPowerSyncBackendConnector());
        
        setState(() => _syncStatus = "Optimizing offline files...");
        await AssetManager.cacheAllActiveAssetsParallel();
        
        setState(() {
          _isSyncingVoters = true;
          _syncStatus = "Syncing voter records...";
        });
        
        await db.waitForFirstSync();
        
        // Download splash for next launch (after campaign_assets synced)
        if (_splashPath == null) {
          setState(() => _syncStatus = "Finalizing setup...");
          await _downloadAssetWithTimeout('splash_screen_image', 3000);
        }
        
        // Mark as completed
        await SyncStateManager.markInitialSyncComplete();
        
      } else {
        // INCREMENTAL SYNC FLOW - Fast path for returning users
        setState(() => _syncStatus = "Checking for updates...");
        
        // Connect and let background sync run
        await db.connect(connector: MyPowerSyncBackendConnector());
        
        // Download only new/changed assets
        await AssetManager.updateCachedAssets();
        
        // Don't wait - background sync handles incremental updates
        await Future.delayed(const Duration(milliseconds: 500));
      }
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e, st) {
      Logger.logError('Sync sequence failed', st);
      if (mounted) setState(() => _error = "Sync failed. Check connection.");
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

  void _onSyncStatusChange(dynamic status) {
    if (!mounted) return;
    if (status.downloading == true && _isSyncingVoters) {
      setState(() => _syncStatus = "Ingesting records into local storage...");
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
        Text(_error!, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _startSetup, child: const Text("Retry Sync")),
      ],
    );
  }
}