import '../../db/idb_crud.dart';

abstract class ILocationService<T, C> extends IDBCrud<T, C> {
  Future<List<T>> searchLocations(String query);
  Future<void> deleteAllLocations();
}
