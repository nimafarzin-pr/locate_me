import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PermissionManager {
  static Future<bool> handleLocationPermission({
    required Location locationGetterModel,
    required BuildContext context,
  }) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await locationGetterModel.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationGetterModel.requestService();
      return serviceEnabled;
    }
    permissionGranted = await locationGetterModel.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationGetterModel.requestPermission();
      return permissionGranted != PermissionStatus.granted;
    }
    return true;
  }
}
