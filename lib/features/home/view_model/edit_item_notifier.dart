import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/provider/edit_item_provider.dart';

import '../../../core/navigation/router/router.dart';
import '../../../core/navigation/routes.dart';
import '../model/place_item_model.dart';

class EditItemNotifier extends Notifier<PlaceItemModel?> {
  void updatePlaceItem(PlaceItemModel? placeItem) {
    state = placeItem;
  }

  @override
  PlaceItemModel? build() {
    return null;
  }
}
