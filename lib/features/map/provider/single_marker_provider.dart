import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/utils/assets_utils.dart';
import 'package:locate_me/features/map/model/manipulate_marker_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/model/place_item_model.dart';

part 'single_marker_provider.g.dart';

@riverpod
Future<MarkersModeData> getSingleMarker(
    GetSingleMarkerRef ref, List<Place> data) async {
  final values = _setMultipleMarkers(data);
  return values;
}

Future<MarkersModeData> _setMultipleMarkers(data) async {
  final List<LatLng> positions = [];
  final List<BitmapDescriptor> customIcons = [];
  final Set<Marker> markers = {};
  Set<Polyline> polyline;
  for (var e in data) {
    final Uint8List markerIcon =
        await AssetsUtils.getBytesFromAsset(e.icon, 80);
    positions.add(LatLng(e.latlng.latitude, e.latlng.longitude));
    customIcons.add(BitmapDescriptor.fromBytes(markerIcon));
    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId(e.latlng.latitude.toString()),
        infoWindow: InfoWindow(title: e.title, snippet: e.address),
        position: LatLng(e.latlng.latitude, e.latlng.longitude),
      ),
    );
  }
  polyline = {
    Polyline(
      polylineId: const PolylineId("_test"),
      visible: true,
      points: positions,
      color: Colors.blue,
    ),
  };

  return MarkersModeData(
      markers: markers,
      polyline: polyline,
      customIcons: customIcons,
      locations: data);
}


// Future<Set<Marker>> _setSingleMarker(Place data) async {
//   final Set<Marker> customMarker = {};
//   final Uint8List markerIcon =
//       await AssetsUtils.getBytesFromAsset(data.icon, 80);

//   customMarker.add(Marker(
//       icon: BitmapDescriptor.fromBytes(markerIcon),
//       markerId: MarkerId(data.latlng.toString()),
//       infoWindow: InfoWindow(title: data.title, snippet: data.address),
//       position: LatLng(data.latlng.latitude, data.latlng.longitude)));
//   return customMarker;
// }
