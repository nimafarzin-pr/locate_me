// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../features/add_or_edit/model/dto/google_map_dto.dart';

class SingleMarkerDto {
  final Set<Marker> marker;
  Set<Polyline>? polyline;
  final BitmapDescriptor customIcon;
  final GoogleMapDto location;
  final String? placeMark;

  SingleMarkerDto({
    required this.location,
    required this.customIcon,
    required this.marker,
    this.polyline,
    this.placeMark,
  });

  SingleMarkerDto copyWith({
    Set<Marker>? marker,
    Set<Polyline>? polyline,
    BitmapDescriptor? customIcon,
    GoogleMapDto? location,
    String? placeMark,
  }) {
    return SingleMarkerDto(
      placeMark: placeMark,
      marker: marker ?? this.marker,
      polyline: polyline ?? this.polyline,
      customIcon: customIcon ?? this.customIcon,
      location: location ?? this.location,
    );
  }
}
