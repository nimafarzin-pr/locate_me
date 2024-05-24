import 'dart:async';

import 'package:drift/drift.dart';

import '../location/location_database_impl.dart';
import 'location_service.dart';

class LocationServiceImpl
    implements ILocationService<Location, LocationDBCompanion> {
  final LocationDatabaseImpl _database;

  LocationServiceImpl(this._database);

  @override
  Future<int> delete(int id) async {
    return await (_database.delete(_database.locationDB)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> deleteAllLocations() async {
    await _database.delete(_database.locationDB).go();
  }

  @override
  Future<Location?> getById(int id) async {
    final entry = await (_database.select(_database.locationDB)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (entry == null) return null;

    return entry;
  }

  @override
  Future<List<Location>> getAll() async {
    final entries = await _database.select(_database.locationDB).get();
    return entries;
  }

  @override
  Future<int> insert(LocationDBCompanion location) async {
    return await _database.into(_database.locationDB).insert(location);
  }

  @override
  Future<void> update(int id, LocationDBCompanion location) async {
    await (_database.update(_database.locationDB)
          ..where((tbl) => tbl.id.equals(id)))
        .write(location);
  }

  @override
  Stream<List<Location>> watchAll() {
    return _database.select(_database.locationDB).watch();
  }

  @override
  Future<List<Location>> searchLocations(String query) async {
    return await (_database.select(_database.locationDB)
          ..where((tbl) => tbl.title.like('%$query%')))
        .get();
  }

  // PlaceModel _entryToModel(LocationDBData entry) {
  //   return PlaceModel(
  //     id: entry.id,
  //     title: entry.title,
  //     address: entry.vicinity ?? '',
  //     description: entry.vicinity ?? '',
  //     category: entry.vicinity ?? '',
  //     position: LatLng(entry.latitude, entry.longitude),
  //   );
  // }
}
