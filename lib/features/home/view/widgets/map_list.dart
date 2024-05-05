import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../map/provider/multiple_marker_provider.dart';

class MapList extends StatefulWidget {
  final List<Place> places;
  final bool polyLineFromPoint;
  const MapList({
    super.key,
    required this.places,
    required this.polyLineFromPoint,
  });

  @override
  State<MapList> createState() => _MapListState();
}

class _MapListState extends State<MapList> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  bool get wantKeepAlive => false;

  _onTab(LatLng argument) async {
    log('INSIDE>> $argument');
    final data = LatLng(argument.latitude, argument.longitude);
    setState(() {});
    final markerData = Place(
        title: 'Current Location',
        address: "",
        distance: "",
        date: "",
        latlng:
            LatLong(latitude: argument.latitude, longitude: argument.longitude),
        icon: MyIcons.location,
        rate: 0.0,
        isSaved: false);
    // await _setSingleMarker(markerData);
    setState(() {});
    // _goToMyLocation(widget.locations);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (context, ref, child) {
        final markers = ref.watch(getMultipleMarkerProvider(widget.places));
        return markers.when(
            data: (data) {
              return Stack(children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  onTap: _onTab,
                  polylines: widget.polyLineFromPoint ? data.polyline! : {},
                  markers: data.markers.map((e) {
                    return Marker(
                      icon: e.icon,
                      markerId: MarkerId(e.markerId.toString()),
                      onTap: () {},
                      infoWindow: InfoWindow(
                          title: e.infoWindow.title,
                          snippet: e.infoWindow.snippet),
                      position:
                          LatLng(e.position.latitude, e.position.longitude),
                    );
                  }).toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(data.locations.first.latlng.latitude,
                        data.locations.first.latlng.longitude),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (controller) {
                    if (_mapController.isCompleted) return;
                    _mapController.complete(controller);
                  },
                ),
              ]);
            },
            error: (error, stackTrace) {
              return Center(child: Text('$error'));
            },
            loading: () => const MyLoading());
      },
    );
  }
}
