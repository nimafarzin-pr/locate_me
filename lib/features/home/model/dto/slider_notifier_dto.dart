import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../place_item_model.dart';

class SliderNotifierDTO {
  final MapController mapController;
  final TickerProvider vsync;
  final PlaceItemModel position;

  SliderNotifierDTO({
    required this.mapController,
    required this.vsync,
    required this.position,
  });
}
