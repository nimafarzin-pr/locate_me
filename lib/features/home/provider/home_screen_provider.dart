import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/view/view_model/category_notifier.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../../../core/common_features/database/provider/db_provider.dart';
import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../../../core/common_features/search_debouncing/search_debouncing_notifier.dart';
import '../model/dto/slider_notifier_dto.dart';
import '../model/place_item_model.dart';
import '../repository/locations_repository.dart';
import '../view/view_model/edit_item_notifier.dart';
import '../view/view_model/favorite_notifier.dart';
import '../view/view_model/home_view_mode_notifier.dart';
import '../view/view_model/slider_notifier.dart';

final categoryFilterProvider =
    NotifierProvider<HomeCategoryNotifier, CategoryModel>(
        HomeCategoryNotifier.new);

final favoriteFilterProvider =
    NotifierProvider<FavoriteNotifier, ItemViewState>(FavoriteNotifier.new);

final filteredItemsProvider = Provider<List<PlaceItemModel>>((ref) {
  final allItems = ref.watch(savedPlacesProvider).asData?.value ?? [];
  final selectedCategory = ref.watch(categoryFilterProvider);
  final showFavorites = ref.watch(favoriteFilterProvider);
  final searchTerm = ref.watch(searchInputProvider);

  final data = allItems.where((item) {
    final matchesCategory = selectedCategory.name == 'all' ||
        item.categoryIcon.trim() == selectedCategory.iconString.trim();
    final matchesFavorite =
        showFavorites != ItemViewState.favorites || item.isFavorite;
    final matchesSearchTerm = searchTerm.isEmpty ||
        item.title.toLowerCase().contains(searchTerm.toLowerCase());

    return matchesCategory && matchesFavorite && matchesSearchTerm;
  }).toList();

  return data;
});

final homeScreenRepositoryProvider = Provider<HomeScreenRepository>((ref) {
  final repo = ref.watch(locationDBRepositoryProvider);
  return HomeScreenRepository(repo);
});

final homeViewModeProvider =
    NotifierProvider<HomeViewModeNotifier, HomeViewMode>(
        HomeViewModeNotifier.new);

final savedPlacesProvider = StreamProvider<List<PlaceItemModel>>((ref) async* {
  final HomeScreenRepository locationRepository =
      ref.watch(homeScreenRepositoryProvider);
  yield* await locationRepository.watchLocationList();
});

final searchInputProvider =
    StateNotifierProvider<DebouncedSearchNotifier, String>(
  (ref) => DebouncedSearchNotifier(),
);

// Again, for notifier we use the ".family" modifier, and specify the argument as type "String".
final sliderNotifierProvider = NotifierProvider.autoDispose
    .family<SliderNotifier, PlaceItemModel, SliderNotifierDTO>(
  SliderNotifier.new,
);

final selectedEditStateProviderForEditView =
    NotifierProvider<SelectedItemNotifier, PlaceItemModel?>(
        SelectedItemNotifier.new);
