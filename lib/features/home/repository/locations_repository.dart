import 'package:locate_me/core/database/repository/location_repository_impl.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class HomeScreenRepository {
  final LocationRepositoryImpl _locationRepositoryImpl;

  HomeScreenRepository(this._locationRepositoryImpl);

  Future<List<PlaceItemModel>> getLocations() async {
    return await _locationRepositoryImpl.getLocations();
  }

  Future<PlaceItemModel?> getLocation(int id) async {
    return await _locationRepositoryImpl.getLocation(id);
  }
}
