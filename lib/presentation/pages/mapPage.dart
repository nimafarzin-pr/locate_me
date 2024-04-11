// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/presentation/widgets/dialogs/permission.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    _handleLocationPermission();
    super.initState();
  }

  CameraPosition _cameraLocation = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Location location = Location();

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<void> _handleLocationPermission() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        showPermissionDialog(
            context: context,
            text: 'Location services are disabled. Please enable the services');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        showPermissionDialog(
            context: context, text: 'Location permissions are denied');
        return;
      }
    }
    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      _setLocationData(currentLocation);
    });
    locationData = await location.getLocation();
  }

  Future<void> _goToTheLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_cameraLocation));
  }

  _setLocationData(LocationData? position) {
    if (position == null ||
        position.latitude == null ||
        position.longitude == null) return;
    setState(() {
      _cameraLocation = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!),
        zoom: 14.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Locate Me"),
        ),
        body: GoogleMap(
          myLocationButtonEnabled: true,
          // myLocationEnabled: true,
          // polylines: ,
          markers: {
            Marker(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      log("${_cameraLocation.target}");
                      return Text("${_cameraLocation.target}");
                    },
                  );
                },
                markerId: const MarkerId("_currentLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _cameraLocation.target)
          },
          mapType: MapType.normal,

          initialCameraPosition: _cameraLocation,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ));
  }
}
