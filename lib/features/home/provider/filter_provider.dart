import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/features/home/provider/category_filter_provider.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/search_input_provider.dart';

import '../model/place_item_model.dart';
import 'location_provider.dart';

final filteredItemsProvider = Provider<List<PlaceItemModel>>((ref) {
  final allItems = ref.watch(locationProvider).asData?.value ?? [];
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
