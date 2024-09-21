import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/database/db/db.dart';

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

  group('AppSettingsTB tests', () {
    test('Insert default app settings and fetch', () async {
      // Insert a default row into the AppSettings table
      await db.into(db.appSettingsTB).insert(AppSettingsTBCompanion.insert(
            language: const Value("fa"),
            id: const Value(0),
            themeMode: const Value(2), // Auto theme mode
          ));

      // Fetch the inserted row
      final fetchedSettings = await db.select(db.appSettingsTB).getSingle();

      // Assertions to verify the inserted values
      expect(fetchedSettings.id, 0); // First inserted item will have id 0
      expect(fetchedSettings.language, "fa");
      expect(fetchedSettings.themeMode, 2); // Auto theme mode
    });

    test('Update app settings and fetch the updated row', () async {
      // Insert a row
      await db.into(db.appSettingsTB).insert(AppSettingsTBCompanion.insert(
            language: const Value("fa"),
            id: const Value(0),
            themeMode: const Value(2), // Auto theme mode
          ));

      // Update the inserted row
      await (db.update(db.appSettingsTB)..where((tbl) => tbl.id.equals(0)))
          .write(const AppSettingsTBCompanion(
        language: Value("en"),
        id: Value(0),
        themeMode: Value(1), // Dark mode
      ));

      // Fetch the updated row
      final updatedSettings = await db.select(db.appSettingsTB).getSingle();

      // Verify the updated values
      expect(updatedSettings.language, "en");
      expect(updatedSettings.themeMode, 1); // Dark mode
    });

    test('Ensure only one row exists and handle row updates correctly',
        () async {
      // Insert a row
      await db.into(db.appSettingsTB).insert(AppSettingsTBCompanion.insert(
          language: const Value("fa"),
          themeMode: const Value(2),
          id: const Value(0)));

      // Try inserting another row but use "insertOnConflictUpdate" to avoid duplicates
      await db.into(db.appSettingsTB).insertOnConflictUpdate(
            AppSettingsTBCompanion.insert(
                language: const Value("en"),
                themeMode: const Value(1),
                id: const Value(0)),
          );

      // Fetch all rows (there should be only one)
      final allRows = await db.select(db.appSettingsTB).get();

      // Ensure only one row still exists
      expect(allRows.length, 1);

      // Verify the updated row
      expect(allRows.first.language, "en");
      expect(allRows.first.themeMode, 1);
    });

    test('Check default values when inserting without specifying columns',
        () async {
      // Insert a row with default values
      await db
          .into(db.appSettingsTB)
          .insert(AppSettingsTBCompanion.insert(id: const Value(0)));

      // Fetch the inserted row
      final fetchedSettings = await db.select(db.appSettingsTB).getSingle();

      // Verify that default values are used
      expect(fetchedSettings.id, 0);
      expect(fetchedSettings.language, "fa"); // Default language
      expect(fetchedSettings.themeMode, 2); // Default theme mode (Auto)
    });
  });
}
