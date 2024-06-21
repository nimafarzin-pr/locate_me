import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/database/provider/db_provider.dart';
import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../model/place_item_model.dart';
import '../view_model/favorite_notifier.dart';

final favoriteFilterProvider =
    NotifierProvider<FavoriteNotifier, ItemViewState>(FavoriteNotifier.new);

final filteredItemsBasedOnCategoryProvider =
    StreamProvider<List<PlaceItemModel>>((ref) {
  final repository = ref.watch(locationDBRepositoryProvider);
  return repository.watchFavoriteLocations();
});
