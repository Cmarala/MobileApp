// PowerSyncService: Singleton service for PowerSync database management
import 'package:powersync/powersync.dart';
import 'powersync_schema.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobileapp/utils/logger.dart';

class PowerSyncService {
  PowerSyncService._internal();
  static final PowerSyncService _instance = PowerSyncService._internal();
  factory PowerSyncService() => _instance;

  late final PowerSyncDatabase db;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return; // Already initialized
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = '${dir.path}/powersync.db';
      db = PowerSyncDatabase(schema: schema, path: dbPath);
      _initialized = true;
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Failed to initialize local database');
      rethrow;
    }
  }
}
