// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:locate_me/core/widget/dialogs/permission.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// abstract class LocationPermissionHandler {
//   static Future<void> showLocationPermissionDialogBasedOnState(
//       {required BuildContext context}) async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await showLocationServiceDialog(context);
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         await showPermissionSettingsDialog(context);
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       await showPermissionSettingsDialog(context);
//     }
//   }

//   static Future<bool> isLocationServiceOn() async =>
//       await Geolocator.isLocationServiceEnabled();

//   static Future<bool?> isLocationPermissionGranted(
//       {required BuildContext context}) async {
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return null;
//     }
//     return true;
//   }

//   static Future<Position?> getCurrentPosition(
//       {required BuildContext context}) async {
//     try {
//       final hasPermission = await isLocationPermissionGranted(context: context);
//       if (hasPermission == null) return null;
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<String?> getAddressFromLatLng(Position position) async {
//     try {
//       List<Placemark> placeMarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       Placemark place = placeMarks[0];
//       return "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
//     } catch (e) {
//       return null;
//     }
//   }
// }
