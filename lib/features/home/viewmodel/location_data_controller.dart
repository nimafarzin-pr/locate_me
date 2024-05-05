// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:locate_me/features/add/viewmodel/location_state.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'location_data_controller.g.dart';

// @riverpod
// LocationChangeNotifier locationChangeNotifier(LocationChangeNotifierRef ref) =>
//     LocationChangeNotifier();

// class LocationChangeNotifier extends StateNotifier<Position?> {
//   LocationChangeNotifier() : super(null) {
//     _getLocationUpdates();
//   }

//   Future<void> _getLocationUpdates() async {
//     try {
//       Geolocator.getPositionStream().listen((Position position) {
//         log('&&&&&  $position');
//         state = position;
//       });
//     } catch (e) {
//       log('Error getting location updates: $e');
//     }
//   }
// }

// class LocationPermissionNotifier
//     extends StateNotifier<LocationPermissionState> {
//   LocationPermissionNotifier() : super(LocationPermissionState.initial) {
//     _checkLocationPermission();
//   }

//   Future<void> _checkLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       state = LocationPermissionState.denied;
//     } else if (permission == LocationPermission.deniedForever) {
//       state = LocationPermissionState.foreverDenied;
//     } else if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       state = LocationPermissionState.granted;
//     }
//   }
// }

// class LocationServiceNotifier extends StateNotifier<LocationServiceState> {
//   LocationServiceNotifier() : super(LocationServiceState.initial) {
//     _checkLocationService();
//   }

//   Future<void> _checkLocationService() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (serviceEnabled) {
//       state = LocationServiceState.enabled;
//     } else {
//       state = LocationServiceState.disabled;
//     }
//   }
// }
