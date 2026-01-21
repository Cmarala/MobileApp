// Dart data models for PowerSync tables, generated from powersync_schema.dart and DBSchema.sql
// Only fields relevant for sync and app logic are included. Add methods as needed.

class Religion {
  final int? id;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  Religion({this.id, required this.name, required this.isActive, required this.createdAt});
}

class Caste {
  final int? id;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  Caste({this.id, required this.name, required this.isActive, required this.createdAt});
}

class SubCaste {
  final int? id;
  final int? casteId;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  SubCaste({this.id, this.casteId, required this.name, required this.isActive, required this.createdAt});
}

class Education {
  final int? id;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  Education({this.id, required this.name, required this.isActive, required this.createdAt});
}

class Occupation {
  final int? id;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  Occupation({this.id, required this.name, required this.isActive, required this.createdAt});
}

// ...continue for all tables (campaigns, geo_units, voters, etc.)
