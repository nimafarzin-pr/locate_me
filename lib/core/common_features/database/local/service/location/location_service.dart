import '../../../../category/enums/category.dart';
import '../../db/idb_crud.dart';

// C for Companion of drift
// T for return value
abstract class ILocationService<T, C> extends IDBCrud<T, C> {
  Future<List<T>> searchLocations(String query);
  Future<void> deleteAllLocations();
  Future<void> updateFavoriteStatus(int id);
  Stream<List<T>> watchFavoriteLocations();
  Stream<List<T>> watchLocationsByCategory(CategoryEnums category);
  Future<void> importLocations(List<C> data);
}
