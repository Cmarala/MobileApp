// PowerSyncService: wires up schema, adapters, and manages sync
import 'package:powersync/powersync.dart' as ps;
import 'powersync_schema.dart';
// import '../models/entities.dart';
import '../data/repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class PowerSyncService {
  PowerSyncService._internal();
  static final PowerSyncService _instance = PowerSyncService._internal();
  factory PowerSyncService() => _instance;

  late final ps.PowerSyncDatabase db;
  late final ReligionRepository religionRepo;
  late final CasteRepository casteRepo;
  late final SubCasteRepository subCasteRepo;
  late final EducationRepository educationRepo;
  late final OccupationRepository occupationRepo;
  // ...add for all entities

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/powersync.db';
    db = ps.PowerSyncDatabase(schema: schema, path: dbPath);
    religionRepo = ReligionRepository(db);
    casteRepo = CasteRepository(db);
    subCasteRepo = SubCasteRepository(db);
    educationRepo = EducationRepository(db);
    occupationRepo = OccupationRepository(db);
    // ...init for all entities
  }

  // Add methods to start sync, get adapters, etc.
}
