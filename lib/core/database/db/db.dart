import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:locate_me/core/database/db/tables/map_settings.dart';
import 'package:path_provider/path_provider.dart';

import '../../helper/map/enums/map_enum.dart';
import '../type_converter/map_setting_converter.dart';
import 'tables/location_database_impl.dart';

import 'package:path/path.dart' as p;

part 'db.g.dart';

@DriftDatabase(tables: [LocationTB, MapSettingsTB])
class DB extends _$DB {
  DB() : super(_openConnection());

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
