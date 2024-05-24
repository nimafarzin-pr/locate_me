// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class MultipleMarkerDto {
  final Set<Marker> markers;
  Set<Polyline>? polyline;
  final List<BitmapDescriptor> customIcons;
  final List<PlaceItemModel> locations;

  MultipleMarkerDto({
    required this.locations,
    required this.customIcons,
    required this.markers,
    this.polyline,
  });

  MultipleMarkerDto copyWith({
    Set<Marker>? markers,
    Set<Polyline>? polyline,
    List<BitmapDescriptor>? customIcons,
    List<PlaceItemModel>? locations,
  }) {
    return MultipleMarkerDto(
      markers: markers ?? this.markers,
      polyline: polyline ?? this.polyline,
      customIcons: customIcons ?? this.customIcons,
      locations: locations ?? this.locations,
    );
  }
}
