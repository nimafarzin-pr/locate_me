import 'dart:developer';

import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../core/database/repository/location/location_repository_impl.dart';

class AddRepository {
  final LocationRepositoryImpl _locationRepositoryImpl;

  AddRepository(this._locationRepositoryImpl);

  Future<int> addLocation({required PlaceItemModel location}) async {
    return await _locationRepositoryImpl.insertLocation(location);
  }

  Future<void> updateLocation({required PlaceItemModel location}) async {
    log('UP ${location.id}');
    await _locationRepositoryImpl.updateLocation(location.id!, location);
  }
}
