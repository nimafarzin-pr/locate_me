
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/common_features/map/core/google_map/model/dto/multiple_marker_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../features/home/model/place_item_model.dart';

part 'multiple_marker_provider.g.dart';

@riverpod
Future<MultipleMarkerDto> getMultipleMarker(
    GetMultipleMarkerRef ref, List<PlaceItemModel> data) async {
  final values = await _setMultipleMarkers(data);

  return values;
}

Future<MultipleMarkerDto> _setMultipleMarkers(List<PlaceItemModel> data) async {
  final List<LatLng> positions = [];
  final List<BitmapDescriptor> customIcons = [];
  final Set<Marker> markers = {};
  // final markerIcon = await MarkerUtils.createCustomMarkerBitmap();

  Set<Polyline> polyline;
  for (var e in data) {
    // final markerIcon =
    //     await MarkerUtils.getMarkerIcon(e.icon, e.latlng.latitude.toString());
    // final Uint8List markerIcon1 = await AssetsUtils.getBytesFromAsset(
    //     categoryMap[e.category] != null
    //         ? categoryMap[e.category]!.icon
    //         : e.icon,
    //     70);
    positions.add(LatLng(e.latlng.latitude, e.latlng.longitude));
    // customIcons.add(BitmapDescriptor.fromBytes(markerIcon1));
    markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: MarkerId(e.latlng.latitude.toString()),
        infoWindow: InfoWindow(title: e.title),
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

  return MultipleMarkerDto(
      markers: markers,
      polyline: polyline,
      customIcons: customIcons,
      locations: data);
}
