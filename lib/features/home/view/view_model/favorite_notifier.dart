import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common_features/map/core/enums/map_enum.dart';
import '../../provider/home_screen_provider.dart';

class FavoriteNotifier extends Notifier<ItemViewState> {
  @override
  ItemViewState build() => ItemViewState.all;

  void updateFavoriteView(ItemViewState newValue) => state = newValue;

  Future<void> updateFavoriteStatus({required int id}) async {
    final repo = ref.read(homeScreenRepositoryProvider);
    await repo.updateFavoriteStatus(id);
  }
}
