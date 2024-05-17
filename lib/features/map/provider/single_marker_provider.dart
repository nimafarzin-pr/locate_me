import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/utils/assets_utils.dart';
import 'package:locate_me/features/map/provider/location_provider.dart';
import 'package:locate_me/features/map/model/marker_data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/model/place_item_model.dart';
import '../../home/view/widgets/marker_test.dart';

final listenablePositionProvider = FutureProvider.autoDispose((ref) async {
  final streamController = StreamController<Position?>();
  final currentPosition =
      await ref.watch(positionProvider(streamController).future);
  return currentPosition;
});

final currentPositionProvider = FutureProvider.autoDispose((ref) async {
  final location = await Geolocator.getCurrentPosition();
  final places = [
    Place(
        title: '${location.latitude}',
        address: '${location.latitude}',
        distance: '${location.latitude}',
        date: '${location.timestamp}',
        latlng:
            LatLong(latitude: location.latitude, longitude: location.longitude),
        icon: MyIcons.location,
        rate: 0,
        isSaved: false)
  ];
  final getMarker = await ref.read(getMarkers(places.first).future);
  return getMarker;
});

final getMarkers =
    FutureProvider.autoDispose.family<MarkersData, Place>((ref, data) async {
  return await _setSingleMarker(data);
});

Future<MarkersData> _setSingleMarker(Place data) async {
  final Set<Marker> customMarker = {};
  final Uint8List markerIcon =
      await AssetsUtils.getBytesFromAsset(data.icon, 80);

  final x = await placeToMarker(data, duration: 1);

  customMarker.add(Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId: MarkerId(data.latlng.toString()),
      infoWindow: InfoWindow(title: data.title, snippet: data.address),
      position: LatLng(data.latlng.latitude, data.latlng.longitude)));

  return MarkersData(
      markers: customMarker,
      customIcons: [BitmapDescriptor.fromBytes(x)],
      locations: [data]);
}
