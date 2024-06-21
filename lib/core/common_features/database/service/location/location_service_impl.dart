import 'dart:async';
import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/db/db.dart';
import 'package:locate_me/core/enums/enums.dart';

import '../../../category/enums/category.dart';
import 'location_service.dart';

class LocationServiceImpl
    implements ILocationService<Location, LocationTBCompanion> {
  final DB _database;

  LocationServiceImpl(this._database);

  @override
  Future<int> delete(int id) async {
    return await (_database.delete(_database.locationTB)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> deleteAllLocations() async {
    await _database.delete(_database.locationTB).go();
  }

  @override
  Future<Location?> getById(int id) async {
    final entry = await (_database.select(_database.locationTB)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (entry == null) return null;

    return entry;
  }

  @override
  Future<List<Location>> getAll() async {
    final entries = await _database.select(_database.locationTB).get();
    return entries;
  }

  @override
  Future<int> insert(LocationTBCompanion location) async {
    return await _database.into(_database.locationTB).insert(location);
  }

  @override
  Future<void> update(int id, LocationTBCompanion location) async {
    await (_database.update(_database.locationTB)
          ..where((tbl) => tbl.id.equals(id)))
        .write(location);
  }

  @override
  Stream<List<Location>> watchAll() {
    return _database.select(_database.locationTB).watch();
  }

  @override
  Future<List<Location>> searchLocations(String query) async {
    return await (_database.select(_database.locationTB)
          ..where((tbl) => tbl.title.like('%$query%')))
        .get();
  }

  @override
  Future<void> updateFavoriteStatus(int id) async {
    final location = await getById(id);
    log('***** >>> ${location?.toJson()}');
    if (location != null) {
      final updatedLocation = location
          .copyWith(isFavorite: !(location.isFavorite))
          .toCompanion(true);
      await update(id, updatedLocation);
    }
  }

  @override
  Stream<List<Location>> watchFavoriteLocations() {
    return (_database.select(_database.locationTB)
          ..where((tbl) => tbl.isFavorite.equals(true)))
        .watch();
  }

  @override
  Stream<List<Location>> watchLocationsByCategory(CategoryEnums category) {
    return _database.select(_database.locationTB).watch().map((locations) {
      return locations
          .where((location) => location.category == category.name)
          .toList();
    });
  }
}
