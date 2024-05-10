// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:locate_me/features/home/model/place_item_model.dart';

class MarkersModeData {
  final Set<Marker> markers;
  Set<Polyline>? polyline;
  final List<BitmapDescriptor> customIcons;
  final List<Place> locations;

  MarkersModeData({
    required this.locations,
    required this.customIcons,
    required this.markers,
    this.polyline,
  });

  MarkersModeData copyWith({
    Set<Marker>? markers,
    Set<Polyline>? polyline,
    List<BitmapDescriptor>? customIcons,
    List<Place>? locations,
  }) {
    return MarkersModeData(
      markers: markers ?? this.markers,
      polyline: polyline ?? this.polyline,
      customIcons: customIcons ?? this.customIcons,
      locations: locations ?? this.locations,
    );
  }
}
