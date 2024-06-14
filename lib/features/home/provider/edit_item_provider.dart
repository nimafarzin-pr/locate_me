import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../core/navigation/router/router.dart';
import '../../../core/navigation/routes.dart';
import '../view_model/edit_item_notifier.dart';

final editItemProvider =
    NotifierProvider<EditItemNotifier, PlaceItemModel?>(EditItemNotifier.new);

final isEditModeProvider = StateProvider<bool>((ref) {
  return ref.watch(editItemProvider) != null &&
      !(router.routerDelegate.currentConfiguration.fullPath
          .contains(Routes.add));
});
