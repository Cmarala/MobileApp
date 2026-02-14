import 'package:powersync/powersync.dart' as ps;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapp/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobileapp/utils/logger.dart';

class MyPowerSyncBackendConnector extends ps.PowerSyncBackendConnector {
  // Define supabase at the class level so it's always found
  final _supabase = Supabase.instance.client;

  @override
  Future<ps.PowerSyncCredentials?> fetchCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('powersync_token');

      Logger.logInfo('SYNC DEBUG: Fetching credentials - token exists: ${jwt != null}, token length: ${jwt?.length ?? 0}');

      if (jwt == null) {
        Logger.logError('No PowerSync token found', null, 'User may not be authenticated');
        return null;
      }

      Logger.logInfo('SYNC DEBUG: Credentials endpoint: $powerSyncUrl');
      return ps.PowerSyncCredentials(endpoint: powerSyncUrl, token: jwt);
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Failed to fetch sync credentials');
      rethrow;
    }
  }

  /// Postgres Response codes that we cannot recover from by retrying.
  final List<RegExp> fatalResponseCodes = [
    RegExp(r'^22...$'), // Data Exception
    RegExp(r'^23...$'), // Integrity Constraint Violation
    RegExp(r'^42501$'), // RLS violation
  ];

  @override
  Future<void> uploadData(ps.PowerSyncDatabase database) async {
    ps.CrudTransaction? transaction;
    ps.CrudEntry? lastOp;

    try {
      // 1. Use getNextCrudTransaction - this is the standard for ps 1.7.0+
      transaction = await database.getNextCrudTransaction();
      if (transaction == null) return;
      for (var operation in transaction.crud) {
        lastOp = operation;
        final table = _supabase.from(operation.table);
        final Map<String, dynamic>? row = operation.opData;
      
        if (row == null && operation.op != ps.UpdateType.delete) {
          continue; 
        }

        switch (operation.op) {
          case ps.UpdateType.put:
            await table.upsert(row!);
            break;
          case ps.UpdateType.patch:
            await table.update(row!).eq('id', operation.id);
            break;
          case ps.UpdateType.delete:
            await table.delete().eq('id', operation.id);
            break;
        }
      }

      // 2. Clear the queue on success
      await transaction.complete();
    } on PostgrestException catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Sync error on table ${lastOp?.table}');
      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        // Fatal error: discard and complete to unblock sync queue
        await transaction?.complete();
      } else {
        // Retryable error: rethrow so PowerSync retries later
        rethrow;
      }
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Unexpected sync error');
      // Always rethrow to let PowerSync handle retries
      rethrow;
    }
  }
}