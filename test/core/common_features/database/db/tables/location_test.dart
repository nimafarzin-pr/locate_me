import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/database/local/db/db.dart'; // Your DB class location
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

  group('LocationTB Tests', () {
    test('Insert and retrieve a location', () async {
      // Insert a location
      final locationId = await db.into(db.locationTB).insert(
            LocationTBCompanion.insert(
              title: 'Test Location',
              vicinity: const Value('Test Vicinity'),
              picture: 'test_picture.png',
              latitude: 37.7749,
              rate: 4.5,
              longitude: -122.4194,
              address: const Value('Test Address'),
              categoryIcon: 'test_icon',
              categoryName: 'Test Category',
              description: const Value('Test Description'),
              isFavorite: const Value(true),
            ),
          );

      // Retrieve the inserted location
      final location = await (db.select(db.locationTB)
            ..where((tbl) => tbl.id.equals(locationId)))
          .getSingle();

      // Assertions to verify the data is correctly inserted
      expect(location.id, locationId);
      expect(location.title, 'Test Location');
      expect(location.vicinity, 'Test Vicinity');
      expect(location.picture, 'test_picture.png');
      expect(location.latitude, 37.7749);
      expect(location.rate, 4.5);
      expect(location.longitude, -122.4194);
      expect(location.address, 'Test Address');
      expect(location.categoryIcon, 'test_icon');
      expect(location.categoryName, 'Test Category');
      expect(location.description, 'Test Description');
      expect(location.isFavorite, true);
    });
  });
}
