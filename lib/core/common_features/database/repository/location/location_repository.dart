// location_repository.dart
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../category/enums/category.dart';
import '../../../../enums/enums.dart';

abstract class ILocationRepository {
  Future<List<PlaceItemModel>> searchLocations(String query);
  Future<List<PlaceItemModel>> getLocations();
  Stream<List<PlaceItemModel>> watchLocations();
  Stream<List<PlaceItemModel>> watchLocationsWithLanguageProvider();
  Future<int> insertLocation(PlaceItemModel location);
  Future<void> updateLocation(int id, PlaceItemModel location);
  Future<int> deleteLocation(int id);
  Future<PlaceItemModel?> getLocation(int id);
  Future<void> deleteAllLocations();
  Future<void> updateFavoriteStatus(int id);
  Stream<List<PlaceItemModel>> watchFavoriteLocations();
  Stream<List<PlaceItemModel>> watchLocationsByCategory(CategoryEnums category);
}
