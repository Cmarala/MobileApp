import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapp/config/env.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:http/http.dart' as http;

/// Diagnostic utilities for debugging PowerSync issues
class SyncDiagnostics {
  
  /// Run comprehensive diagnostics on sync setup
  static Future<Map<String, dynamic>> runDiagnostics() async {
    final results = <String, dynamic>{};
    
    try {
      // 1. Check stored credentials
      final prefs = await SharedPreferences.getInstance();
      results['has_user_id'] = prefs.getString('user_id') != null;
      results['has_campaign_id'] = prefs.getString('campaign_id') != null;
      results['has_powersync_token'] = prefs.getString('powersync_token') != null;
      results['token_length'] = prefs.getString('powersync_token')?.length ?? 0;
      
      // 2. Check PowerSync configuration
      results['powersync_url'] = powerSyncUrl;
      results['powersync_url_valid'] = powerSyncUrl.isNotEmpty && 
                                       (powerSyncUrl.startsWith('https://') || 
                                        powerSyncUrl.startsWith('http://'));
      
      // 3. Check database initialization
      try {
        await PowerSyncService().initialize();
        results['db_initialized'] = true;
        
        // Try to query database
        final db = PowerSyncService().db;
        final votersCount = await db.execute('SELECT COUNT(*) as count FROM voters');
        results['voters_count'] = votersCount.isNotEmpty ? votersCount.first['count'] : 0;
        
        final surveysCount = await db.execute('SELECT COUNT(*) as count FROM surveys');
        results['surveys_count'] = surveysCount.isNotEmpty ? surveysCount.first['count'] : 0;
        
        // Check if database has any sync metadata
        results['db_has_data'] = (results['voters_count'] as int? ?? 0) > 0;
      } catch (e) {
        results['db_initialized'] = false;
        results['db_error'] = e.toString();
      }
      
      // 4. Test PowerSync endpoint connectivity (basic check)
      if (results['powersync_url_valid'] == true) {
        try {
          final token = prefs.getString('powersync_token');
          if (token != null) {
            // Try to reach the endpoint
            final uri = Uri.parse(powerSyncUrl);
            final response = await http.head(uri).timeout(
              const Duration(seconds: 10),
            );
            results['endpoint_reachable'] = response.statusCode < 500;
            results['endpoint_status_code'] = response.statusCode;
          } else {
            results['endpoint_reachable'] = false;
            results['endpoint_error'] = 'No token available';
          }
        } catch (e) {
          results['endpoint_reachable'] = false;
          results['endpoint_error'] = e.toString();
        }
      }
      
      // 5. Check sync state
      results['has_completed_initial_sync'] = prefs.getBool('initial_sync_completed') ?? false;
      final lastSync = prefs.getString('last_sync_timestamp');
      results['last_sync'] = lastSync;
      
    } catch (e) {
      results['diagnostic_error'] = e.toString();
    }
    
    // Log all results
    Logger.logInfo('=== SYNC DIAGNOSTICS ===');
    results.forEach((key, value) {
      Logger.logInfo('  $key: $value');
    });
    Logger.logInfo('========================');
    
    return results;
  }
  
  /// Generate a human-readable diagnostic report
  static String generateReport(Map<String, dynamic> results) {
    final buffer = StringBuffer();
    buffer.writeln('SYNC DIAGNOSTIC REPORT');
    buffer.writeln('=' * 50);
    buffer.writeln();
    
    // Authentication
    buffer.writeln('AUTHENTICATION:');
    buffer.writeln('  User ID: ${results['has_user_id'] == true ? '✓' : '✗'}');
    buffer.writeln('  Campaign ID: ${results['has_campaign_id'] == true ? '✓' : '✗'}');
    buffer.writeln('  PowerSync Token: ${results['has_powersync_token'] == true ? '✓ (${results['token_length']} chars)' : '✗'}');
    buffer.writeln();
    
    // Configuration
    buffer.writeln('CONFIGURATION:');
    buffer.writeln('  PowerSync URL: ${results['powersync_url']}');
    buffer.writeln('  URL Valid: ${results['powersync_url_valid'] == true ? '✓' : '✗'}');
    buffer.writeln();
    
    // Database
    buffer.writeln('DATABASE:');
    buffer.writeln('  Initialized: ${results['db_initialized'] == true ? '✓' : '✗'}');
    if (results['db_error'] != null) {
      buffer.writeln('  Error: ${results['db_error']}');
    }
    buffer.writeln('  Voters: ${results['voters_count'] ?? 0}');
    buffer.writeln('  Surveys: ${results['surveys_count'] ?? 0}');
    buffer.writeln();
    
    // Connectivity
    buffer.writeln('CONNECTIVITY:');
    buffer.writeln('  Endpoint Reachable: ${results['endpoint_reachable'] == true ? '✓' : '✗'}');
    if (results['endpoint_status_code'] != null) {
      buffer.writeln('  Status Code: ${results['endpoint_status_code']}');
    }
    if (results['endpoint_error'] != null) {
      buffer.writeln('  Error: ${results['endpoint_error']}');
    }
    buffer.writeln();
    
    // Sync State
    buffer.writeln('SYNC STATE:');
    buffer.writeln('  Initial Sync Complete: ${results['has_completed_initial_sync'] == true ? '✓' : '✗'}');
    buffer.writeln('  Last Sync: ${results['last_sync'] ?? 'Never'}');
    buffer.writeln();
    
    return buffer.toString();
  }
}
