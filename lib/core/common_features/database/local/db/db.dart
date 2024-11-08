import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:locate_me/core/common_features/database/local/db/tables/login_register.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../map/core/enums/map_enum.dart';
import '../type_converter/map_setting_converter.dart';
import 'tables/app_seetings.dart';
import 'tables/categories.dart';
import 'tables/location.dart';
import 'tables/map_settings.dart';

part 'db.g.dart';

@DriftDatabase(tables: [
  LocationTB,
  MapSettingsTB,
  AppSettingsTB,
  CategoriesTB,
  LoginRegisterTB,
])
class DB extends _$DB {
  // Make DB a singleton
  static DB? _instance;

  // Private constructor
  DB._internal(super.e);

  // Factory constructor for singleton instance in production
  factory DB() {
    // If the instance is null, create a new one using the default connection
    _instance ??= DB._internal(_openConnection());
    return _instance!;
  }

  // Factory constructor for testing purposes with custom QueryExecutor
  factory DB.test(QueryExecutor executor) {
    // For testing, we won't use the singleton, allowing a new instance
    return DB._internal(executor);
  }

  @override
  int get schemaVersion => 1;
}

// Function to open the connection for the actual database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
