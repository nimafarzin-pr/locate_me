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
}
