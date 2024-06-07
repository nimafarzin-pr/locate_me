import 'package:locate_me/core/database/repository/location/location_repository_impl.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class HomeScreenRepository {
  final LocationRepositoryImpl _locationRepositoryImpl;

  HomeScreenRepository(this._locationRepositoryImpl);

  Future<List<PlaceItemModel>> getLocations() async {
    return await _locationRepositoryImpl.getLocations();
  }

  Future<Stream<List<PlaceItemModel>>> watchLocationList() async {
    return _locationRepositoryImpl.watchLocations();
  }

  Future<PlaceItemModel?> getLocation(int id) async {
    return await _locationRepositoryImpl.getLocation(id);
  }

  Future<void> deleteLocation(int id) async {
    await _locationRepositoryImpl.deleteLocation(id);
  }

  Future<void> updateFavoriteStatus(int id) async {
    return await _locationRepositoryImpl.updateFavoriteStatus(id);
  }
}
