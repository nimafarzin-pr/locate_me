import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../model/dto/slider_notifier_dto.dart';
import '../view_model/slider_notifier.dart';

// Again, for notifier we use the ".family" modifier, and specify the argument as type "String".
final sliderProvider = NotifierProvider.autoDispose
    .family<SliderNotifier, PlaceItemModel, SliderNotifierDTO>(
  SliderNotifier.new,
);
