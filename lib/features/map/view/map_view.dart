// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:locate_me/core/utils/permissions.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class MapView extends StatefulWidget {
  final List<Place> locations;
  final bool polyLineFromPoint;
  final bool enableLocationIcon;
  final Function()? onMarkerTap;
  final void Function(LatLng)? onMapTap;
  final void Function(LatLng)? onGoToPosition;
  final Function(GoogleMapController)? onMapCreated;
  final Function(LatLng location)? onLocationChange;

  const MapView({
    super.key,
    required this.locations,
    this.polyLineFromPoint = false,
    this.onMarkerTap,
    this.onMapTap,
    this.onMapCreated,
    this.onLocationChange,
    this.onGoToPosition,
    this.enableLocationIcon = false,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Location location = Location();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    _processLocation();
    super.initState();
  }

  late Set<Marker> markers = {};
  late Set<Polyline> polylineData = {};

  _processLocation() async {
    final data = await _getData();
    _setMarkers(data);
    _listenToChangeLocation();
    _goToMyLocation(data);
    setState(() {});
  }

  Future<List<Place>> _getData() async =>
      widget.locations.isEmpty ? await _getCurrentLocation() : widget.locations;

  Future<List<Place>> _getCurrentLocation() async {
    final position = await location.getLocation();
    return [
      Place(
          title: 'Current Location',
          address: "",
          distance: "",
          date: "",
          latlng: LatLong(
              latitude: position.latitude ?? 0.0,
              longitude: position.longitude ?? 0.0),
          icon: './assets/category/location.png',
          rate: 0.0,
          isSaved: false)
    ];
  }

  _listenToChangeLocation() {
    if (widget.onLocationChange != null) {
      location.enableBackgroundMode(enable: true);
      location.onLocationChanged.listen((LocationData currentLocation) {
        final data =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        widget.onLocationChange!(data);
      });
    }
  }

  Future<void> _setMarkers(List<Place> locations) async {
    final List<LatLng> positions = [];
    locations.map((e) async {
      final Uint8List markerIcon = await getBytesFromAsset(e.icon, 80);
      positions.add(LatLng(e.latlng.latitude, e.latlng.longitude));
      markers.add(Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId(e.latlng.toString()),
          infoWindow: InfoWindow(title: e.title, snippet: e.address),
          onTap: widget.onMarkerTap,
          position: LatLng(e.latlng.latitude, e.latlng.longitude)));
    }).toSet();

    if (widget.polyLineFromPoint) {
      polylineData.addAll({
        Polyline(
          polylineId: const PolylineId("_test"),
          visible: true,
          points: positions,
          color: Colors.blue,
        ),
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _goToMyLocation(List<Place> locations) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(LatLng(
        locations.first.latlng.latitude, locations.first.latlng.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onTap: (argument) async {
          if (widget.onMapTap == null) return;
          final permission = await PermissionManager.handleLocationPermission(
              locationGetterModel: location, context: context);
          if (permission) {
            final data = LatLng(argument.latitude, argument.longitude);
            widget.onMapTap!(data);
          }
        },
        polylines: widget.polyLineFromPoint ? polylineData : {},
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.locations.first.latlng.latitude,
              widget.locations.first.latlng.longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (controller) {
          _controller.complete(controller);
          if (widget.onMapCreated == null) return;
          widget.onMapCreated!(controller);
        },
      ),
      widget.enableLocationIcon
          ? Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)),
                child: InkWell(
                  onTap: () async {
                    if (widget.onGoToPosition == null) return;
                    final permission =
                        await PermissionManager.handleLocationPermission(
                            locationGetterModel: location, context: context);
                    if (permission) {
                      final currentLocation = await location.getLocation();
                      final data = LatLng(currentLocation.latitude!,
                          currentLocation.longitude!);
                      widget.onGoToPosition!(data);
                    }
                  },
                  child: FaIcon(
                    size: 34,
                    FontAwesomeIcons.crosshairs,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          : Container()
    ]);
  }
}
