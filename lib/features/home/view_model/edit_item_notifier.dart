import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place_item_model.dart';
import '../provider/favorite_filter_provider.dart';
import '../provider/filter_provider.dart';

final selectedEditStateProviderForEditAndView =
    StateProvider<PlaceItemModel?>((ref) {
  return null;
});
