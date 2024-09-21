import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';
import 'package:locate_me/features/home/repository/locations_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';
import 'favorite_notifier_test.mocks.dart';

// Mock the repository that FavoriteNotifier depends on
@GenerateMocks([HomeScreenRepository])
void main() {
  late ProviderContainer container;
  late MockHomeScreenRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeScreenRepository();
    container = createContainer(overrides: [
      homeScreenRepositoryProvider.overrideWithValue(mockRepository),
    ]);
  });

  test('FavoriteNotifier initial state is ItemViewState.all', () {
    final favoriteNotifier = container.read(favoriteFilterProvider);

    expect(
      favoriteNotifier,
      equals(ItemViewState.all),
    );
  });

  test('FavoriteNotifier updates the state with a new ItemViewState', () {
    final favoriteNotifier = container.read(favoriteFilterProvider.notifier);

    favoriteNotifier.updateFavoriteView(ItemViewState.favorites);

    final updatedState = container.read(favoriteFilterProvider);
    expect(
      updatedState,
      equals(ItemViewState.favorites),
    );
  });

  test('FavoriteNotifier calls updateFavoriteStatus on the repository',
      () async {
    final favoriteNotifier = container.read(favoriteFilterProvider.notifier);

    // Arrange: Set up the mock repository to return a Future<void>
    when(mockRepository.updateFavoriteStatus(123)).thenAnswer((_) async {
      return;
    });

    // Act: Call the updateFavoriteStatus method
    await favoriteNotifier.updateFavoriteStatus(id: 123);

    // Assert: Verify that the repository's updateFavoriteStatus method was called with the correct ID
    verify(mockRepository.updateFavoriteStatus(123)).called(1);
  });
}
