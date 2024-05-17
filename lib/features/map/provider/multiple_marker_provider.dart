import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/utils/assets_utils.dart';
import 'package:locate_me/features/map/model/marker_data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/marker_utility.dart';
import '../../home/model/place_item_model.dart';

part 'multiple_marker_provider.g.dart';

@riverpod
Future<MarkersData> getMultipleMarker(
    GetMultipleMarkerRef ref, List<Place> data) async {
  final values = await _setMultipleMarkers(data);

  return values;
}

Future<MarkersData> _setMultipleMarkers(List<Place> data) async {
  final List<LatLng> positions = [];
  final List<BitmapDescriptor> customIcons = [];
  final Set<Marker> markers = {};
  // final markerIcon = await MarkerUtils.createCustomMarkerBitmap();

  Set<Polyline> polyline;
  for (var e in data) {
    final markerIcon =
        await MarkerUtils.getMarkerIcon(e.icon, e.latlng.latitude.toString());
    final Uint8List markerIcon1 =
        await AssetsUtils.getBytesFromAsset(e.icon, 60);
    positions.add(LatLng(e.latlng.latitude, e.latlng.longitude));
    customIcons.add(BitmapDescriptor.fromBytes(markerIcon1));
    markers.add(
      Marker(
        visible: true,
        flat: true,
        icon: markerIcon,
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

  return MarkersData(
      markers: markers,
      polyline: polyline,
      customIcons: customIcons,
      locations: data);
}
