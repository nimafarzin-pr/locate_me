// Combined provider to filter items based on category and favorite

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/features/home/provider/category_filter_provider.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/search_input_provider.dart';

import '../../../core/common_features/caching/image_caching.dart';
import '../model/place_item_model.dart';
import 'location_provider.dart';

final filteredItemsProvider = Provider<List<PlaceItemModel>>((ref) {
  final allItems = ref.watch(locationProvider).asData?.value ?? [];
  final selectedCategory = ref.watch(categoryFilterProvider);
  final showFavorites = ref.watch(favoriteFilterProvider);
  final searchTerm = ref.watch(searchInputProvider);
  final imageCacheNotifier = ref.read(imageCacheProvider);
  final imageCacheNotifierN = ref.read(imageCacheProvider.notifier);

  return allItems.where((item) {
    final matchesCategory = selectedCategory.name == 'all' ||
        item.categoryIcon.trim() == selectedCategory.iconString.trim();
    final matchesFavorite =
        showFavorites != ItemViewState.favorites || item.isFavorite;
    final matchesSearchTerm = searchTerm.isEmpty ||
        item.title.toLowerCase().contains(searchTerm.toLowerCase());

    // Cache the image if not already cached
    if (!imageCacheNotifier.containsKey(item.id.toString())) {
      imageCacheNotifierN.cacheImage(item.id.toString(), item.picture);
    }

    return matchesCategory && matchesFavorite && matchesSearchTerm;
  }).toList();
});
