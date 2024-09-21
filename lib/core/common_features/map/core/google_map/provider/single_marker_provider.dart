// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:locate_me/core/common_features/map/core/google_map/model/dto/single_marker_dto.dart';

import '../../../../../../features/add/model/dto/google_map_dto.dart';

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
  // final markerIcon = await CustomMarkerAddInfoBox(
  //   showCard: true,
  //   position: latLang2.LatLng(data.lat, data.lng),
  // ).toBitmapDescriptor(
  //     logicalSize: const Size(250, 250), imageSize: const Size(500, 400));

  return SingleMarkerDto(
    marker: {
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(data.lat.toString()),
          position: LatLng(data.lat, data.lng))
    },
    customIcon: BitmapDescriptor.defaultMarker,
    location: data,
    placeMark: data.placeMark,
  );
}
