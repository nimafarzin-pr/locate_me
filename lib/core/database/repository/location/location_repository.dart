// location_repository.dart
import 'package:locate_me/features/home/model/place_item_model.dart';

abstract class ILocationRepository {
  Future<List<PlaceItemModel>> searchLocations(String query);
  Future<List<PlaceItemModel>> getLocations();
  Stream<List<PlaceItemModel>> watchLocations();
  Future<int> insertLocation(PlaceItemModel location);
  Future<void> updateLocation(int id, PlaceItemModel location);
  Future<int> deleteLocation(int id);
  Future<PlaceItemModel?> getLocation(int id);
  Future<void> deleteAllLocations();
}
