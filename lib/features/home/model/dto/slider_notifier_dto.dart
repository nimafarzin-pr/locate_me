import 'package:flutter/material.dart';

import '../place_item_model.dart';

class SliderNotifierDTO<T> {
  final T mapController;
  final TickerProvider vsync;
  final PlaceItemModel position;

  SliderNotifierDTO({
    required this.mapController,
    required this.vsync,
    required this.position,
  });
}
