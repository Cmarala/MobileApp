import 'package:powersync/powersync.dart' as ps;

// Repository/data access classes for PowerSync entities
// These provide CRUD and sync helpers for each table

class ReligionRepository {
  final ps.PowerSyncDatabase db;
  ReligionRepository(this.db);
  // Add methods for fetch, insert, update, delete, sync
}

class CasteRepository {
  final ps.PowerSyncDatabase db;
  CasteRepository(this.db);
  // Add methods for fetch, insert, update, delete, sync
}

class SubCasteRepository {
  final ps.PowerSyncDatabase db;
  SubCasteRepository(this.db);
  // Add methods for fetch, insert, update, delete, sync
}

class EducationRepository {
  final ps.PowerSyncDatabase db;
  EducationRepository(this.db);
  // Add methods for fetch, insert, update, delete, sync
}

class OccupationRepository {
  final ps.PowerSyncDatabase db;
  OccupationRepository(this.db);
  // Add methods for fetch, insert, update, delete, sync
}

// ...continue for all tables (campaigns, geo_units, voters, etc.)
