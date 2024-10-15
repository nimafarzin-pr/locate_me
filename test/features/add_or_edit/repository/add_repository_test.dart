import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/features/add/repository/add_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/core/common_features/database/local/repository/location/location_repository_impl.dart';

import 'add_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationRepositoryImpl>()])
void main() {
  late MockLocationRepositoryImpl mockLocationRepository;
  late AddRepository addRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepositoryImpl();
    addRepository = AddRepository(mockLocationRepository);
  });

  group('AddRepository', () {
    const testPlaceItemModel = PlaceItemModel(
      title: 'Test Place',
      address: 'Test Address',
      description: 'Test Description',
      distance: '10 miles',
      date: '2024-08-28',
      id: 1,
      categoryIcon: 'icon.png',
      categoryName: 'Test Category',
      latlng: LatLong(latitude: 37.7749, longitude: -122.4194),
      picture: 'test_image.png',
      rate: 4.5,
      isFavorite: false,
    );

    test('addLocation should call insertLocation on LocationRepositoryImpl',
        () async {
      // Use a more descriptive variable name instead of `_`
      const expectedId = 1;

      when(mockLocationRepository.insertLocation(testPlaceItemModel))
          .thenAnswer((_) async => expectedId);

      final result =
          await addRepository.addLocation(location: testPlaceItemModel);

      verify(mockLocationRepository.insertLocation(testPlaceItemModel));
    });
  });
}
