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
  int _voterCount = 0;
  int _expectedVoterCount = 0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _startSetup();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  Future<void> _startSetup() async {
    try {
      setState(() => _error = null);
      
      // Validate configuration
      final diagnostics = await SyncDiagnostics.runDiagnostics();
      _validateDiagnostics(diagnostics);
      
      // Initialize database
      await PowerSyncService().initialize();
      final db = PowerSyncService().db;
      
      // Load cached splash screen
      _splashPath = await AssetManager.getAssetPath('splash_screen_image');
      if (mounted) setState(() {});
      
      // Determine sync type
      final isFirstSync = !await SyncStateManager.hasCompletedInitialSync();
      
      if (isFirstSync) {
        await _performFirstSync(db);
      } else {
        await _performIncrementalSync(db);
      }
      
      // Navigate to home
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e, st) {
      Logger.logError('Sync failed', st, e.toString());
      if (mounted) {
        setState(() => _error = _getErrorMessage(e));
      }
    }
  }

  void _validateDiagnostics(Map<String, dynamic> diagnostics) {
    if (diagnostics['has_powersync_token'] != true) {
      throw Exception('Missing PowerSync token. Please reactivate the app.');
    }
    if (diagnostics['powersync_url_valid'] != true) {
      throw Exception('Invalid PowerSync configuration.');
    }
  }

  Future<void> _performFirstSync(dynamic db) async {
    _updateStatus("Connecting to server...");
    
    // Listen to sync progress
    db.statusStream.listen(_handleSyncProgress);
    
    // Connect to PowerSync
    await db.connect(connector: MyPowerSyncBackendConnector());
    
    // Cache assets in parallel
    _updateStatus("Preparing offline files...");
    await AssetManager.cacheAllActiveAssetsParallel();
    
    // Start voter sync with progress tracking
    _updateStatus("Downloading voter records... 0%");
    _startProgressTracking();
    
    // Wait for sync with timeout
    await db.waitForFirstSync().timeout(
      const Duration(seconds: 120),
      onTimeout: () => throw TimeoutException('Sync timeout'),
    );
    
    _progressTimer?.cancel();
    
    // Finalize
    _updateStatus("Finalizing...");
    await SyncStateManager.markInitialSyncComplete();
    
    Logger.logInfo('First sync complete. Voters synced: $_voterCount');
  }

  Future<void> _performIncrementalSync(dynamic db) async {
    _updateStatus("Checking for updates...");
    
    // Quick connect - no waiting
    await db.connect(connector: MyPowerSyncBackendConnector());
    
    // Update only changed assets
    await AssetManager.updateCachedAssets();
    
    // Small delay for UX smoothness
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void _handleSyncProgress(dynamic status) {
    if (!mounted) return;
    
    // Get expected count from metadata or estimate
    if (_expectedVoterCount == 0 && status.downloading == true) {
      _estimateExpectedCount();
    }
  }

  void _startProgressTracking() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      await _updateVoterProgress();
    });
  }

  Future<void> _updateVoterProgress() async {
    try {
      final db = PowerSyncService().db;
      final result = await db.execute('SELECT COUNT(*) as count FROM voters');
      final count = (result.firstOrNull?['count'] as int?) ?? 0;
      
      if (count != _voterCount && mounted) {
        _voterCount = count;
        final percentage = _expectedVoterCount > 0
            ? ((count / _expectedVoterCount) * 100).clamp(0, 99).toInt()
            : 0;
        
        setState(() {
          _syncStatus = percentage > 0
              ? "Downloading voter records... $percentage%"
              : "Downloading voter records... $_voterCount records";
        });
      }
    } catch (e) {
      // Ignore count errors
    }
  }

  Future<void> _estimateExpectedCount() async {
    // Try to get expected count from backend or use last known count
    // For now, we'll update dynamically as records come in
    _expectedVoterCount = await _getExpectedVoterCount();
  }

  Future<int> _getExpectedVoterCount() async {
    // TODO: Get from backend metadata or campaign settings
    // For now, return 0 to show count instead of percentage until we know total
    return 0;
  }

  void _updateStatus(String status) {
    if (mounted) setState(() => _syncStatus = status);
  }

  String _getErrorMessage(Object error) {
    if (error is TimeoutException) {
      return "Sync timed out. Check your connection and try again.";
    }
    return "Sync failed: ${error.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_splashPath != null) _buildSplashBackground(),
          Container(color: Colors.black.withAlpha(140)),
          Center(
            child: _error != null ? _buildErrorView() : _buildLoadingView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashBackground() {
    final file = File(_splashPath!);
    return file.existsSync()
        ? Positioned.fill(child: Image.file(file, fit: BoxFit.cover))
        : const SizedBox.shrink();
  }

  Widget _buildLoadingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        const SizedBox(height: 24),
        Text(
          _syncStatus,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (_voterCount > 0) ...[
          const SizedBox(height: 8),
          Text(
            '$_voterCount records downloaded',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Keep the app open during setup",
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
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _startSetup,
          child: const Text("Retry Sync"),
        ),
      ],
    );
  }
}