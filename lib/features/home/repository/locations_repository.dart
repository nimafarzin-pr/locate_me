import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:locate_me/core/dummydata/dummy_data.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

part 'locations_repository.g.dart';

@riverpod
LocationsRepository locationsRepository(LocationsRepositoryRef ref) =>
    LocationsRepository();

class LocationsRepository {
  Future<List<Place>> getLocations() async {
    return Future.delayed(const Duration(milliseconds: 300), () {
      final fakeData =
          (json.decode(jsonStr) as List).map((e) => Place.fromJson(e)).toList();
      return fakeData;
    });
  }

  Future<Place> getLocation(String locationId) async {
    final fakeData =
        (json.decode(jsonStr) as List).map((e) => Place.fromJson(e)).toList();

    final Place place =
        fakeData.where((element) => element.locationId == locationId).first;
    return place;
  }
}
