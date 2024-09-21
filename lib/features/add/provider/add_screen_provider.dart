import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/database/provider/db_provider.dart';
import '../repository/add_repository.dart';
import '../view_model/add_location_notifier.dart';
import 'dart:async';
import 'package:latlong2/latlong.dart' as latLang2;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/common_features/map/core/google_map/model/dto/single_marker_dto.dart';
import '../../../core/common_features/map/core/google_map/provider/location_provider.dart';
import '../../../core/resources/icons.dart';
import '../model/dto/google_map_dto.dart';

final addLocationNotifierProvider =
    AsyncNotifierProvider<AddLocationNotifier, latLang2.LatLng>(
        AddLocationNotifier.new);

final addRepositoryProvider = FutureProvider<AddRepository>((ref) async {
  final repo = ref.watch(locationDBRepositoryProvider);
  return AddRepository(repo);
});

final listenablePositionProvider = FutureProvider.autoDispose((ref) async {
  final streamController = StreamController<Position?>();
  final currentPosition =
      await ref.watch(positionProvider(streamController).future);
  return currentPosition;
});

final googleMapCurrentPositionProvider =
    FutureProvider.autoDispose((ref) async {
  // final location = await Geolocator.getCurrentPosition();
  final location = await ref.watch(addLocationNotifierProvider.future);

  final places = [
    GoogleMapDto(
        lat: location.latitude,
        lng: location.longitude,
        customIcon: MyIcons.location)
  ];
  // final marker = await ref.watch(getMarker(places.first).future);
  // return marker;
  return SingleMarkerDto(
    marker: {},
    customIcon: BitmapDescriptor.defaultMarker,
    location: places.first,
  );
});
