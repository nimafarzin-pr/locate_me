import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/provider/home_screen_repository_provider.dart';

import '../../../core/common_features/map/core/enums/map_enum.dart';

class FavoriteNotifier extends Notifier<ItemViewState> {
  @override
  ItemViewState build() => ItemViewState.all;

  void updateFavoriteView(ItemViewState newValue) => state = newValue;

  Future<void> updateFavoriteStatus({required int id}) async {
    final repo = ref.read(homeScreenRepositoryProvider);
    await repo.updateFavoriteStatus(id);
  }
}
