import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobileapp/volunteer/home_screen.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/sync/powersync_backend_connector.dart';
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

    // 1. Initialize & Connect
    await PowerSyncService().initialize();
    final db = PowerSyncService().db;
    db.statusStream.listen(_onSyncStatusChange);
    await db.connect(connector: MyPowerSyncBackendConnector());

    // 2. STAGE 1: Branding (Poll for Splash)
    setState(() => _syncStatus = "Setting up branding...");
    int splashRetries = 0;
    while (_splashPath == null && splashRetries < 5) {
      final path = await AssetManager.getAssetPath('splash_screen_image');
      if (path != null) {
        if (mounted) setState(() => _splashPath = path);
        break;
      }
      await Future.delayed(const Duration(milliseconds: 800));
      splashRetries++;
    }

    // 3. STAGE 2: Optimize Offline Files
    setState(() => _syncStatus = "Optimizing offline files...");
    await AssetManager.cacheAllActiveAssets();

    // 4. STAGE 3: Massive Voter Sync (Generic Status)
    setState(() {
      _isSyncingVoters = true;
      _syncStatus = "Syncing voter records...";
    });

    // This is the functional gate for the 1 Lakh records
    await db.waitForFirstSync();

    // 5. FINISH
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