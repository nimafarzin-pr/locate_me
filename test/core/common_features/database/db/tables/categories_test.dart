import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/database/db/db.dart'; // Your DB class location
import 'package:drift/native.dart';

void main() {
  late DB db;

  setUp(() {
    // In-memory database for testing
    db = DB.test(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('CategoriesTB Tests', () {
    test('Insert and retrieve a category', () async {
      // Insert a category
      final categoryId = await db.into(db.categoriesTB).insert(
            CategoriesTBCompanion.insert(
              color: const Value(0xFFFFFF), // example color value
              name: const Value('Test Category'),
              emoji: const Value('😀'),
            ),
          );

      // Retrieve the inserted category
      final category = await (db.select(db.categoriesTB)
            ..where((tbl) => tbl.id.equals(categoryId)))
          .getSingle();

      // Assertions to verify the data is correctly inserted
      expect(category.id, categoryId);
      expect(category.color, 0xFFFFFF);
      expect(category.name, 'Test Category');
      expect(category.emoji, '😀');
    });
  });
}
