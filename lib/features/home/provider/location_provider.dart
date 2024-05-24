import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/locations_repository.dart';
import 'location_repository_provider.dart';

final locationProvider = FutureProvider<List<PlaceItemModel>>((ref) async {
  final HomeScreenRepository locationRepository =
      ref.watch(homeScreenRepositoryProvider);
  return await locationRepository.getLocations();
});
