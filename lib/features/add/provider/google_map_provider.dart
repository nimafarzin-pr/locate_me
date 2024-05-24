import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/helper/google_map/provider/single_marker_provider.dart';
import 'package:locate_me/features/add/provider/osm_location_provider.dart';

import '../../../core/helper/google_map/provider/location_provider.dart';
import '../../../core/resources/icons.dart';
import '../model/dto/google_map_dto.dart';

final listenablePositionProvider = FutureProvider.autoDispose((ref) async {
  final streamController = StreamController<Position?>();
  final currentPosition =
      await ref.watch(positionProvider(streamController).future);
  return currentPosition;
});

final currentPositionProvider = FutureProvider.autoDispose((ref) async {
  // final location = await Geolocator.getCurrentPosition();
  final location = await ref.watch(addLocationProvider.future);

  final places = [
    GoogleMapDto(
        lat: location.latitude,
        lng: location.longitude,
        customIcon: MyIcons.location)
  ];
  final marker = await ref.watch(getMarker(places.first).future);
  return marker;
});
