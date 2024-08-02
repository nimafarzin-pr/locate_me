import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:locate_me/core/common_features/database/db/tables/categories.dart';
import 'package:locate_me/core/common_features/database/db/tables/map_settings.dart';
import 'package:path_provider/path_provider.dart';

import '../../map/core/enums/map_enum.dart';
import '../type_converter/map_setting_converter.dart';
import 'tables/app_seetings.dart';
import 'tables/location.dart';

import 'package:path/path.dart' as p;

part 'db.g.dart';

@DriftDatabase(tables: [
  LocationTB,
  MapSettingsTB,
  AppSettingsTB,
  CategoriesTB,
])
class DB extends _$DB {
  // Make DB a singleton
  static final DB _instance = DB._internal();

  factory DB() {
    return _instance;
  }

  DB._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
