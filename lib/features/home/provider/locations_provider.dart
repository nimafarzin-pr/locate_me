import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/repository/locations_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locations_provider.g.dart';

@riverpod
Future<List<Place>> locationsProvider(LocationsProviderRef ref) async {
  final LocationsRepository locationsRepository =
      ref.watch(locationsRepositoryProvider);
  return locationsRepository.getLocations();
}
