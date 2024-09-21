import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place_item_model.dart';

class SelectedItemNotifier extends Notifier<PlaceItemModel?> {
  @override
  PlaceItemModel? build() => null;

  void setEditItem(PlaceItemModel? editItem) => state = editItem;

  void clearEditItem() => state = null;
}
