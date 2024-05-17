import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/utils/marker_utility.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../map/model/marker_data_model.dart';
import '../../../map/provider/multiple_marker_provider.dart';

class MapList extends ConsumerStatefulWidget {
  final List<Place> places;
  final bool polyLineFromPoint;
  const MapList({
    super.key,
    required this.places,
    required this.polyLineFromPoint,
  });

  @override
  ConsumerState<MapList> createState() => _MapListState();
}

class _MapListState extends ConsumerState<MapList>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addCustomMarker();
    });
  }

  Future<void> _addCustomMarker() async {
    final customMarker =
        ref.read(getMultipleMarkerProvider(widget.places).future);
    customMarker.then(
      (markerIcon) {
        for (Marker element in markerIcon.markers.toList()) {
          final dex = markerIcon.markers.toList().indexOf(element);
          final cus = markerIcon.customIcons[dex];
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId('${element.position.latitude}'),
                position: element.position,
                icon: element.icon,
              ),
            );
            // _markers.add(
            //   Marker(
            //     markerId: MarkerId('${cus.hashCode}'),
            //     position: element.position,
            //     icon: cus,
            //   ),
            // );
          });
        }
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading custom marker: $error')),
      );
    });
  }

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
    return Stack(children: [
      GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        onTap: _onTab,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.places.first.latlng.latitude,
              widget.places.first.latlng.longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (controller) {
          if (_mapController.isCompleted) return;
          _mapController.complete(controller);
        },
      ),
      Consumer(
        builder: (context, watch, child) {
          final customMarker =
              ref.watch(getMultipleMarkerProvider(widget.places));

          return customMarker.when(
            data: (markerIcon) {
              // Marker is successfully created
              return Container(); // Return empty container
            },
            loading: () {
              // Show loading indicator if needed
              return const Center(child: CircularProgressIndicator());
            },
            error: (err, stack) {
              // Show error message
              return Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.white,
                child: Center(child: Text('Error loading custom marker: $err')),
              );
            },
          );
        },
      ),
    ]);
  }
}
