// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/widget/custom_add_info_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'package:locate_me/core/helper/google_map/model/dto/single_marker_dto.dart';
import 'package:locate_me/features/add/model/dto/google_map_dto.dart';
import 'package:latlong2/latlong.dart' as latLang2;

final getMarker = FutureProvider.autoDispose
    .family<SingleMarkerDto, GoogleMapDto>((ref, data) async {
  return await _setSingleMarker(data);
});

Future<SingleMarkerDto> _setSingleMarker(GoogleMapDto data) async {
  // final Uint8List markerIcon =
  //     await AssetsUtils.getBytesFromAsset(data.customIcon, 80);

  // final markerIcon2 = await MarkerUtils.getMarkerIcon(
  //     data.customIcon, '${data.lat} \n ${data.lng}');

  // final x = await placeToMarker(data, duration: 1);
  final markerIcon = await CustomMarkerAddInfoBox(
    position: latLang2.LatLng(data.lat, data.lng),
  ).toBitmapDescriptor(
      logicalSize: const Size(250, 250), imageSize: const Size(500, 500));

  return SingleMarkerDto(
    marker: {
      Marker(
          icon: markerIcon,
          markerId: MarkerId(data.lat.toString()),
          position: LatLng(data.lat, data.lng))
    },
    customIcon: markerIcon,
    location: data,
    placeMark: data.placeMark,
  );
}
