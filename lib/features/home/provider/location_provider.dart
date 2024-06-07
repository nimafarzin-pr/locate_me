import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/locations_repository.dart';
import 'home_screen_repository_provider.dart';

final locationProvider = StreamProvider<List<PlaceItemModel>>((ref) async* {
  final HomeScreenRepository locationRepository =
      ref.watch(homeScreenRepositoryProvider);
  yield* await locationRepository.watchLocationList();
});
