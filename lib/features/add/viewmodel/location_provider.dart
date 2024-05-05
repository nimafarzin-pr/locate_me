import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/features/add/viewmodel/location_state.dart';

final positionProvider = StreamProvider.autoDispose<Position?>((ref) {
  final streamController = StreamController<Position?>();

  _determinePosition(streamController);

  return streamController.stream;
});

void _determinePosition(StreamController<Position?> streamController) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    streamController.addError(LocationServiceState.disabled);
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      streamController.addError(LocationPermissionState.denied);
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    streamController.addError(LocationPermission.deniedForever);
    return;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  Geolocator.getServiceStatusStream().listen((event) {
    final status = event == ServiceStatus.enabled
        ? LocationServiceState.enabled
        : LocationServiceState.disabled;
    streamController.addError(status);
  });

  // Geolocator.checkPermission().asStream().listen((event) {
  //   log('IN PROVIDER >> $event');
  //   final status = event == LocationPermission.always ||
  //           event == LocationPermission.whileInUse
  //       ? LocationPermissionState.granted
  //       : LocationPermissionState.denied;
  //   streamController.addError(status);
  // });
  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
    streamController.add(position);
  });

  Position initialPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  streamController.add(initialPosition);
}
