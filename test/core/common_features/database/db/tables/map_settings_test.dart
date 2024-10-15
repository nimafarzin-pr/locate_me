import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/database/local/db/db.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';

void main() {
  late DB db;

  setUp(() {
    // Initialize the in-memory test database using DB.test
    db = DB.test(NativeDatabase.memory());
  });

  tearDown(() async {
    // Close the database after each test
    await db.close();
  });

  group('MapSettingsTB tests', () {
    test('Insert default map settings and fetch', () async {
      // Insert a default row into the AppSettings table
      await db.into(db.mapSettingsTB).insert(MapSettingsTBCompanion.insert(
            id: const Value(0),
            mapLayer: const Value(MapLayer.osm),
            mapStyle: const Value(MapStyle.standard), // Auto theme mode
          ));

      // Fetch the inserted row
      final fetchedSettings = await db.select(db.mapSettingsTB).getSingle();

      // Assertions to verify the inserted values
      expect(fetchedSettings.id, 0); // First inserted item will have id 0
      expect(fetchedSettings.mapLayer, MapLayer.osm);
      expect(fetchedSettings.mapStyle, MapStyle.standard);
    });

    test('Update map settings and fetch the updated row', () async {
      // Insert a row
      await db.into(db.mapSettingsTB).insert(MapSettingsTBCompanion.insert(
            mapLayer: const Value(MapLayer.osm),
            id: const Value(0),
            mapStyle: const Value(MapStyle.standard), // Auto theme mode
          ));

      // Update the inserted row
      await (db.update(db.mapSettingsTB)..where((tbl) => tbl.id.equals(0)))
          .write(const MapSettingsTBCompanion(
        mapLayer: Value(MapLayer.google),
        id: Value(0),
        mapStyle: Value(MapStyle.dark), // Dark mode
      ));

      // Fetch the updated row
      final updatedSettings = await db.select(db.mapSettingsTB).getSingle();

      // Verify the updated values
      expect(updatedSettings.mapLayer, MapLayer.google);
      expect(updatedSettings.mapStyle, MapStyle.dark); // Dark mode
    });

    test('Ensure only one row exists and handle row updates correctly',
        () async {
      // Insert a row
      await db.into(db.mapSettingsTB).insert(MapSettingsTBCompanion.insert(
          mapLayer: const Value(MapLayer.google),
          mapStyle: const Value(MapStyle.silver),
          id: const Value(0)));

      // Try inserting another row but use "insertOnConflictUpdate" to avoid duplicates
      await db.into(db.mapSettingsTB).insertOnConflictUpdate(
            MapSettingsTBCompanion.insert(
                mapLayer: const Value(MapLayer.osm),
                mapStyle: const Value(MapStyle.standard),
                id: const Value(0)),
          );

      // Fetch all rows (there should be only one)
      final allRows = await db.select(db.mapSettingsTB).get();

      // Ensure only one row still exists
      expect(allRows.length, 1);

      // Verify the updated row
      expect(allRows.first.mapLayer, MapLayer.osm);
      expect(allRows.first.mapStyle, MapStyle.standard);
    });

    test('Check default values when inserting without specifying columns',
        () async {
      // Insert a row with default values
      await db
          .into(db.mapSettingsTB)
          .insert(MapSettingsTBCompanion.insert(id: const Value(0)));

      // Fetch the inserted row
      final fetchedSettings = await db.select(db.mapSettingsTB).getSingle();

      // Verify that default values are used
      expect(fetchedSettings.id, 0);
      expect(fetchedSettings.mapStyle, null);
      expect(fetchedSettings.mapLayer, null);
    });
  });
}
