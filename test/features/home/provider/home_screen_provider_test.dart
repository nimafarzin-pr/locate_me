import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/repository/locations_repository.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';
import 'home_screen_provider_test.mocks.dart';

// Mock data
final mockPlaceItemModels = [
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
    isFavorite: true,
  ),
];

@GenerateNiceMocks([MockSpec<HomeScreenRepository>()])
void main() {
  late ProviderContainer container;
  late MockHomeScreenRepository mockHomeScreenRepository;

  setUp(() {
    mockHomeScreenRepository = MockHomeScreenRepository();
    container = createContainer(
      overrides: [
        homeScreenRepositoryProvider
            .overrideWithValue(mockHomeScreenRepository),
      ],
    );
  });

  test('locationProvider returns a stream of PlaceItemModel list', () async {
    when(mockHomeScreenRepository.watchLocationList())
        .thenAnswer((_) async => Stream.value(mockPlaceItemModels));

    final locationStream = await container.read(savedPlacesProvider.future);
    expect(locationStream, mockPlaceItemModels);
    verify(mockHomeScreenRepository.watchLocationList()).called(1);
  });

  test(
      'filteredItemsProvider filters items based on category, favorite, and search term',
      () async {
    when(mockHomeScreenRepository.watchLocationList())
        .thenAnswer((_) async => Stream.value(mockPlaceItemModels));

    const selectedCategory =
        CategoryModel(id: 1, name: 'Category 1', iconString: 'icon_1');
    container
        .read(categoryFilterProvider.notifier)
        .updateCategory(selectedCategory);

    container
        .read(favoriteFilterProvider.notifier)
        .updateFavoriteView(ItemViewState.favorites);

    container.read(searchInputProvider.notifier).setSearchQuery('Place 1');

    await container.read(savedPlacesProvider.future);

    final filteredItems = container.read(filteredItemsProvider);

    expect(filteredItems, mockPlaceItemModels);
  });

  test('categoryFilterProvider updates the selected category', () async {
    const category =
        CategoryModel(id: 1, name: 'Category 1', iconString: 'icon_1');
    container.read(categoryFilterProvider.notifier).updateCategory(category);
    expect(container.read(categoryFilterProvider), category);
  });

  test('favoriteFilterProvider updates the favorite filter state', () async {
    container
        .read(favoriteFilterProvider.notifier)
        .updateFavoriteView(ItemViewState.favorites);

    expect(container.read(favoriteFilterProvider), ItemViewState.favorites);
  });

  test('homeScreenRepositoryProvider returns HomeScreenRepository', () {
    final repository = container.read(homeScreenRepositoryProvider);
    expect(repository, isA<HomeScreenRepository>());
  });

  test('searchInputProvider updates the search term', () async {
    container
        .read(searchInputProvider.notifier)
        .setSearchQuery('New Search Term');
    await Future.delayed(const Duration(milliseconds: 300));
    expect(container.read(searchInputProvider), 'New Search Term');
  });

  test('homeViewModeProvider updates the home view mode', () {
    container
        .read(homeViewModeProvider.notifier)
        .updateViewMode(HomeViewMode.map);
    expect(container.read(homeViewModeProvider), HomeViewMode.map);
  });
}
