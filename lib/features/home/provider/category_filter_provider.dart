import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/enums/enums.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/view_model/category_notifier.dart';

import '../../../core/common_features/category/enums/category.dart';
import '../../../core/common_features/database/provider/db_provider.dart';

final categoryFilterProvider =
    NotifierProvider<CategoryNotifier, CategoryEnums>(CategoryNotifier.new);

final filteredItemsBasedOnCategoryProvider =
    StreamProvider<List<PlaceItemModel>>((ref) {
  final repository = ref.watch(locationDBRepositoryProvider);
  final category = ref.watch(categoryFilterProvider);
  return repository.watchLocationsByCategory(category);
});
