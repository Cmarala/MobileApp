// PowerSync sync adapters/services for each entity
// These handle mapping between local DB and remote sync


import '../data/repositories.dart';

class ReligionSyncAdapter {
  final ReligionRepository repo;
  ReligionSyncAdapter(this.repo);
  // Add sync logic here
}

class CasteSyncAdapter {
  final CasteRepository repo;
  CasteSyncAdapter(this.repo);
  // Add sync logic here
}

class SubCasteSyncAdapter {
  final SubCasteRepository repo;
  SubCasteSyncAdapter(this.repo);
  // Add sync logic here
}

class EducationSyncAdapter {
  final EducationRepository repo;
  EducationSyncAdapter(this.repo);
  // Add sync logic here
}

class OccupationSyncAdapter {
  final OccupationRepository repo;
  OccupationSyncAdapter(this.repo);
  // Add sync logic here
}

// ...continue for all tables (campaigns, geo_units, voters, etc.)
