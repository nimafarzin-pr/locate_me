import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// Custom enum for location service states
enum LocationServiceState { initial, disabled, enabled }

enum LocationPermissionState {
  initial,
  denied,
  granted,
  foreverDenied,
  whileInUse
}

final positionProvider =
    StreamProvider.family<Position?, StreamController<Position?>>(
        (ref, streamController) {
  _determinePosition(streamController);
  return streamController.stream;
});

void _determinePosition(StreamController<Position?> streamController) async {
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 0,
  );
  Geolocator.getServiceStatusStream().listen((event) {
    final status = event == ServiceStatus.enabled
        ? LocationServiceState.enabled
        : LocationServiceState.disabled;
    streamController.addError(status);
  });

  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
    streamController.add(position);
  });

  Position initialPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  streamController.add(initialPosition);
}
