// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/features/map/view/map_view.dart';
import 'package:location/location.dart';

import 'package:locate_me/core/utils/permissions.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class AddTab extends StatefulWidget {
  const AddTab({super.key});

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  Location location = Location();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isLoading = true;

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  late Set<Marker> markers = {};
  late List<Place> placesData = [];

  Future _checkPermission() async {
    final isLocationPermission =
        await PermissionManager.handleLocationPermission(
      locationGetterModel: location,
      context: context,
    );
    if (!isLocationPermission) return;
    _processLocation();
  }

  _processLocation() async {
    final data = await _getCurrentLocation();
    setState(() {
      placesData.addAll(data);
    });
    _goToMyLocation(data);
  }

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

  _listenToChangeLocation(LatLng latlng) {
    placesData = [
      Place(
          title: 'Current Location',
          address: "",
          distance: "",
          date: "",
          latlng:
              LatLong(latitude: latlng.latitude, longitude: latlng.longitude),
          icon: './assets/category/location.png',
          rate: 0.0,
          isSaved: false)
    ];
    setState(() {});
  }

  Future<void> _goToMyLocation(List<Place> locations) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(LatLng(
        locations.first.latlng.latitude, locations.first.latlng.longitude)));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          )
        : Stack(children: [
            MapView(
              enableLocationIcon: true,
              onMapTap: (latlng) {
                setState(() {
                  placesData = [
                    Place(
                        title: 'title',
                        address: '',
                        distance: '',
                        date: '',
                        latlng: LatLong(
                            latitude: latlng.latitude,
                            longitude: latlng.longitude),
                        icon: './assets/category/location.png',
                        rate: 0.0,
                        isSaved: false)
                  ];
                });
              },
              onGoToPosition: (latlng) {
                placesData.add(Place(
                    title: 'title',
                    address: '',
                    distance: '',
                    date: '',
                    latlng: LatLong(
                        latitude: latlng.latitude, longitude: latlng.longitude),
                    icon: './assets/category/location.png',
                    rate: 0.0,
                    isSaved: false));
              },
              locations: placesData,
              onLocationChange: (location) {
                _listenToChangeLocation(location);
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)),
                child: InkWell(
                  onTap: _checkPermission,
                  child: FaIcon(
                    size: 34,
                    FontAwesomeIcons.crosshairs,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          ]);
  }
}
