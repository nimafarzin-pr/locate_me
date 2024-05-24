import '../data_base.dart';

abstract class ILocationService<T, C> extends ICrudService<T, C> {
  Future<List<T>> searchLocations(String query);
  Future<void> deleteAllLocations();
}
