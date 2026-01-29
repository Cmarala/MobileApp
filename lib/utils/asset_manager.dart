import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/utils/logger.dart';

/// A pure Logic Utility for managing campaign media files on device storage.
/// Adheres to MRU principles by delegating data fetching to the Repository.
class AssetManager {
  /// Logic: Orchestrates the discovery and caching of a specific asset type.
  /// Returns the local [String] file path or null if unavailable.
  static Future<String?> getAssetPath(String assetType) async {
    try {
      Logger.logInfo('📁 [ASSET MANAGER] Starting getAssetPath for: $assetType');
      
      // 1. Data Fetching (Delegated to Repository)
      final url = await AppRepository.getAssetUrl(assetType);
      
      if (url == null || url.isEmpty) {
        Logger.logInfo('⚠️  [ASSET MANAGER] No URL returned from DB for: $assetType');
        return null;
      }

      Logger.logInfo('🔗 [ASSET MANAGER] Got URL, attempting download/cache: $url');
      // 2. Cache Execution
      final path = await _downloadAndCache(url, assetType);
      if (path != null) {
        Logger.logInfo('✅ [ASSET MANAGER] Successfully cached at: $path');
      } else {
        Logger.logInfo('❌ [ASSET MANAGER] Failed to download/cache asset');
      }
      return path;
    } catch (e, st) {
      Logger.logError(e, st, 'AssetManager error fetching path for: $assetType');
      return null;
    }
  }

  /// Logic: Batch downloads all active campaign assets for offline readiness.
  /// Typically called during the SyncScreen process.
  static Future<void> cacheAllActiveAssets() async {
    try {
      // 1. Fetch mapping from Repository
      final assets = await AppRepository.getActiveAssetMapping();

      if (assets.isEmpty) return;

      // 2. Iterate and Cache
      for (final asset in assets) {
        final url = asset['url'];
        final type = asset['type'];
        
        if (url != null && type != null) {
          await _downloadAndCache(url, type);
        }
      }
      Logger.logInfo('AssetManager: Batch caching completed successfully.');
    } catch (e, st) {
      Logger.logError(e, st, 'AssetManager: Batch caching process failed.');
    }
  }

  /// Logic: The technical "Workhorse" for file I/O and Networking.
  /// Uses a stable naming convention based on asset type and URL hash.
  static Future<String?> _downloadAndCache(String url, String assetType) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      
      // We combine type and hash to ensure that if the URL changes on the 
      // backend for the same asset type, the app triggers a new download.
      final filename = '${assetType}_${url.hashCode}.img';
      final file = File('${dir.path}/$filename');
      Logger.logInfo('💾 [CACHE] Target file path: ${file.path}');

      // Check local storage first (Efficiency/Offline-First)
      if (await file.exists()) {
        Logger.logInfo('✅ [CACHE] File already exists locally: $filename');
        return file.path;
      }

      Logger.logInfo('⬇️  [DOWNLOAD] File not cached, downloading from: $url');
      // Download if not found locally
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));

      Logger.logInfo('📥 [DOWNLOAD] Response status: ${response.statusCode}, bytes: ${response.bodyBytes.length}');
      
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        Logger.logInfo('✅ [CACHE] Successfully cached new asset: $filename');
        return file.path;
      } else {
        Logger.logInfo('❌ [DOWNLOAD] Failed with status code: ${response.statusCode}');
      }

      return null;
    } catch (e, st) {
      Logger.logError(e, st, 'Error in _downloadAndCache for $assetType');
      return null;
    }
  }
}