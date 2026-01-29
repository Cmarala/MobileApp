// lib/features/survey/services/voter_service.dart

import 'package:powersync/powersync.dart';
import 'package:mobileapp/models/voter.dart';

class VoterService {
  final PowerSyncDatabase _db;

  VoterService(this._db);

  /// Fetches fresh voter data from database
  Future<Map<String, dynamic>?> getVoterSnapshot(String voterId) async {
    try {
      final results = await _db.getAll(
        'SELECT id, name, age, epic_id, phone, gender, house_no, '
        'section_number, part_no FROM voters WHERE id = ?',
        [voterId],
      );
      
      if (results.isEmpty) return null;
      return results.first;
    } catch (e) {
      return null;
    }
  }

  /// Converts voter snapshot to Voter model
  Future<Voter?> getVoterModel(String voterId) async {
    try {
      final results = await _db.getAll(
        'SELECT * FROM voters WHERE id = ?',
        [voterId],
      );
      
      if (results.isEmpty) return null;
      return Voter.fromJson(results.first);
    } catch (e) {
      return null;
    }
  }
}
