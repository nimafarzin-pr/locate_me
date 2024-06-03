import 'package:drift/drift.dart';

import '../../type_converter/map_setting_converter.dart';

//* best practice for saving data like this is to use shared preferences or hive but for experience i used single row approach
@DataClassName('MapSettings')
class MapSettingsTB extends Table {
  IntColumn get id =>
      integer().autoIncrement().withDefault(const Constant(0))();
  IntColumn get mapLayer =>
      integer().nullable().map(const MapLayerConverter())();
  IntColumn get mapStyle =>
      integer().nullable().map(const MapStyleConverter())();
}
