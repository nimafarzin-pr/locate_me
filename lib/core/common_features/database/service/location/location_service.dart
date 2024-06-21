import 'package:locate_me/core/enums/enums.dart';

import '../../../category/enums/category.dart';
import '../../db/idb_crud.dart';

abstract class ILocationService<T, C> extends IDBCrud<T, C> {
  Future<List<T>> searchLocations(String query);
  Future<void> deleteAllLocations();
  Future<void> updateFavoriteStatus(int id);
  Stream<List<T>> watchFavoriteLocations();
  Stream<List<T>> watchLocationsByCategory(CategoryEnums category);
}
