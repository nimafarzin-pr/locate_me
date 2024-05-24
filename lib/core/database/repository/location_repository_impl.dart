import 'package:locate_me/core/database/type_converter/place_model_converter.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../service/location_service_impl.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements ILocationRepository {
  final LocationServiceImpl _databaseService;

  LocationRepositoryImpl(this._databaseService);

  @override
  Future<void> deleteAllLocations() async {
    await _databaseService.deleteAllLocations();
  }

  @override
  Future<int> deleteLocation(int id) async {
    return await _databaseService.delete(id);
  }

  @override
  Future<PlaceItemModel?> getLocation(int id) async {
    final data = await _databaseService.getById(id);
    if (data == null) return null;
    final toModel = const DbPlaceModelConverter().fromSql(data);
    return toModel;
  }

  @override
  Future<List<PlaceItemModel>> getLocations() async {
    final data = await _databaseService.getAll();
    final toModel = data
        .map(
          (e) => const DbPlaceModelConverter().fromSql(e),
        )
        .toList();

    return toModel;
  }

  @override
  Future<int> insertLocation(PlaceItemModel location) async {
    final toDbModel =
        const DbPlaceModelConverter().toSql(location).toCompanion(true);
    return await _databaseService.insert(toDbModel);
  }

  @override
  Future<List<PlaceItemModel>> searchLocations(String query) async {
    final data = await _databaseService.searchLocations(query);
    final toModel = data
        .map(
          (e) => const DbPlaceModelConverter().fromSql(e),
        )
        .toList();
    return toModel;
  }

  @override
  Future<void> updateLocation(int id, PlaceItemModel location) async {
    final toDbModel =
        const DbPlaceModelConverter().toSql(location).toCompanion(true);
    return await _databaseService.update(id, toDbModel);
  }

  @override
  Stream<List<PlaceItemModel>> watchLocations() {
    final dataStream = _databaseService.watchAll();
    return dataStream.map<List<PlaceItemModel>>((dataList) {
      return dataList
          .map((data) => const DbPlaceModelConverter().fromSql(data))
          .toList();
    });
  }
}
