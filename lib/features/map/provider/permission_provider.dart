import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum SystemAndPermissionStatus {
  permissionGrant,
  systemLocationEnable,
  permissionDenied,
  permissionDeniedForEver,
  systemLocationDisable,
  allGood,
}

final permissionProvider = StreamProvider<SystemAndPermissionStatus?>(
  (ref) {
    final streamController =
        StreamController<SystemAndPermissionStatus>.broadcast();
    ref.watch(listenProvider(streamController));
    return streamController.stream;
  },
);

final listenProvider =
    StreamProvider.family<SystemAndPermissionStatus, StreamController>(
        (ref, streamController) async* {
  LocationPermission permission;
  final bool? initLocationServiceStatusValue =
      await ref.watch(_initialGpsStatusProvider.future);

  final ServiceStatus status = ref.watch(_gpsServiceListenableProvider).value ??
      (initLocationServiceStatusValue != null && initLocationServiceStatusValue
          ? ServiceStatus.enabled
          : ServiceStatus.disabled);

  if (status == ServiceStatus.disabled) {
    streamController.addError(SystemAndPermissionStatus.systemLocationDisable);
    return;
  } else {
    final bool? initPermissionStatusValue =
        await ref.watch(_initialPermissionStatusProvider.future);

    permission = ref.watch(_permissionListenableProvider).value ??
        (initPermissionStatusValue != null && initPermissionStatusValue
            ? await Geolocator.checkPermission()
            : LocationPermission.deniedForever);

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        streamController.addError(SystemAndPermissionStatus.permissionDenied);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      streamController
          .addError(SystemAndPermissionStatus.permissionDeniedForEver);
      return;
    }

    streamController.add(SystemAndPermissionStatus.allGood);
    return;
  }
});

//*****************************************
//* listen
final _gpsServiceListenableProvider = StreamProvider<ServiceStatus>((ref) {
  return Geolocator.getServiceStatusStream();
});

//* listen
final _permissionListenableProvider =
    StreamProvider<LocationPermission>((ref) async* {
  yield* Geolocator.checkPermission().asStream().asBroadcastStream();
});

//* initial
final _initialGpsStatusProvider = FutureProvider<bool>(
    (ref) async => await Geolocator.isLocationServiceEnabled());

//* initial
final _initialPermissionStatusProvider = FutureProvider<bool>((ref) async {
  final status = await Geolocator.checkPermission();

  return status == LocationPermission.always ||
      status == LocationPermission.whileInUse;
});
