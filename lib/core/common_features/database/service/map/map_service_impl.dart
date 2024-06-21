import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/db/db.dart';

import 'map_service.dart';

class MapServiceImpl extends IMapService<MapSettings, MapSettingsTBCompanion> {
  final DB _database;

  MapServiceImpl(this._database);

  @override
  Future<MapSettings?> getSetting() async {
    return (_database.select(_database.mapSettingsTB)
          ..where((tbl) => tbl.id.equals(0)))
        .getSingleOrNull();
  }

  @override
  Future<void> updateSetting(MapSettings mapSettings) async {
    if (mapSettings.mapLayer != null) {
      updateLayer(mapSettings);
    }

    if (mapSettings.mapStyle != null) {
      updateStyle(mapSettings);
    }
  }

  Future<void> updateLayer(MapSettings mapSettings) async {
    final existingSetting = await getSetting();
    if (existingSetting == null) {
      // If there is no existing setting, insert a new row
      await _database.into(_database.mapSettingsTB).insert(
            const MapSettingsTBCompanion().copyWith(
              id: const Value(0),
              mapLayer: Value(mapSettings.mapLayer),
            ),
          );
    } else {
      // If there is an existing setting, update the row
      await _database
          .update(_database.mapSettingsTB)
          .replace(const MapSettingsTBCompanion().copyWith(
            id: const Value(0),
            mapLayer: Value(mapSettings.mapLayer),
          ));
    }
  }

  Future<void> updateStyle(MapSettings mapSettings) async {
    final existingSetting = await getSetting();
    if (existingSetting == null) {
      // If there is no existing setting, insert a new row
      await _database.into(_database.mapSettingsTB).insert(
            const MapSettingsTBCompanion().copyWith(
              id: const Value(0),
              mapStyle: Value(mapSettings.mapStyle),
            ),
          );
    } else {
      // If there is an existing setting, update the row
      await _database
          .update(_database.mapSettingsTB)
          .replace(const MapSettingsTBCompanion().copyWith(
            id: const Value(0),
            mapStyle: Value(mapSettings.mapStyle),
          ));
    }
  }

  @override
  Stream<MapSettings?> watchSettings() {
    final data = _database.select(_database.mapSettingsTB).watchSingleOrNull();
    data.listen(
      (event) {
        log('****** ${event?.toJson()}');
      },
    );
    return data;
  }
}
