import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/features/home/repository/locations_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import 'locations_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeScreenRepository>()])
void main() {
  // late MockLocationRepositoryImpl mockLocationRepositoryImpl;
  late MockHomeScreenRepository homeScreenRepository;

  setUp(() {
    // mockLocationRepositoryImpl = MockLocationRepositoryImpl();
    homeScreenRepository = MockHomeScreenRepository();
  });

  test('getLocations returns a list of PlaceItemModel', () async {
    // Arrange
    final mockLocations = [
      const PlaceItemModel(
        title: 'Place 1',
        address: 'Address 1',
        description: 'Description 1',
        distance: '1 km',
        date: '2024-08-28',
        id: 1,
        categoryIcon: 'icon_1',
        categoryName: 'Category 1',
        latlng: LatLong(latitude: 0.0, longitude: 0.0),
        picture: 'picture_1',
        imageByte: null,
        rate: 4.5,
        isFavorite: false,
      ),
    ];

    when(homeScreenRepository.getLocations())
        .thenAnswer((_) async => mockLocations);

    // Act
    final result = await homeScreenRepository.getLocations();

    // Assert
    expect(result, mockLocations);
    verify(homeScreenRepository.getLocations()).called(1);
  });

  test('watchLocationList returns a Stream of PlaceItemModel list', () async {
    // Arrange
    final mockLocationsStream = Stream<List<PlaceItemModel>>.fromIterable([
      [
        const PlaceItemModel(
          title: 'Place 1',
          address: 'Address 1',
          description: 'Description 1',
          distance: '1 km',
          date: '2024-08-28',
          id: 1,
          categoryIcon: 'icon_1',
          categoryName: 'Category 1',
          latlng: LatLong(latitude: 0.0, longitude: 0.0),
          picture: 'picture_1',
          imageByte: null,
          rate: 4.5,
          isFavorite: false,
        ),
      ],
    ]);

    when(homeScreenRepository.watchLocationList())
        .thenAnswer((_) async => mockLocationsStream);

    // Act
    final resultStream = await homeScreenRepository.watchLocationList();

    // Assert
    await expectLater(
        resultStream,
        emitsInOrder([
          [
            const PlaceItemModel(
              title: 'Place 1',
              address: 'Address 1',
              description: 'Description 1',
              distance: '1 km',
              date: '2024-08-28',
              id: 1,
              categoryIcon: 'icon_1',
              categoryName: 'Category 1',
              latlng: LatLong(latitude: 0.0, longitude: 0.0),
              picture: 'picture_1',
              imageByte: null,
              rate: 4.5,
              isFavorite: false,
            ),
          ]
        ]));
    verify(homeScreenRepository.watchLocationList()).called(1);
  });

  test('getLocation returns a PlaceItemModel for a given id', () async {
    // Arrange
    const mockLocation = PlaceItemModel(
      title: 'Place 1',
      address: 'Address 1',
      description: 'Description 1',
      distance: '1 km',
      date: '2024-08-28',
      id: 1,
      categoryIcon: 'icon_1',
      categoryName: 'Category 1',
      latlng: LatLong(latitude: 0.0, longitude: 0.0),
      picture: 'picture_1',
      imageByte: null,
      rate: 4.5,
      isFavorite: false,
    );

    when(homeScreenRepository.getLocation(1))
        .thenAnswer((_) async => mockLocation);

    // Act
    final result = await homeScreenRepository.getLocation(1);

    // Assert
    expect(result, mockLocation);
    verify(homeScreenRepository.getLocation(1)).called(1);
  });

  test('deleteLocation calls deleteLocation on LocationRepositoryImpl',
      () async {
    // Act
    await homeScreenRepository.deleteLocation(1);

    // Assert
    verify(homeScreenRepository.deleteLocation(1)).called(1);
  });

  test(
      'updateFavoriteStatus calls updateFavoriteStatus on LocationRepositoryImpl',
      () async {
    // Act
    await homeScreenRepository.updateFavoriteStatus(1);

    // Assert
    verify(homeScreenRepository.updateFavoriteStatus(1)).called(1);
  });
}
