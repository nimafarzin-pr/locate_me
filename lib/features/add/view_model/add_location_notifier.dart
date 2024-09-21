import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flMap;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLang2;
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../provider/add_screen_provider.dart';

class AddLocationNotifier extends AsyncNotifier<latLang2.LatLng> {
  @override
  Future<latLang2.LatLng> build() async {
    return await _getCurrentLocation();
  }

  Future<latLang2.LatLng> get currentLocation async =>
      await _getCurrentLocation();

  Future<latLang2.LatLng> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = AsyncError('Location services are disabled.', StackTrace.current);
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state =
            AsyncError('Location permissions are denied.', StackTrace.current);
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = AsyncError(
          'Location permissions are permanently denied.', StackTrace.current);
      throw Exception('Location permissions are permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final location = latLang2.LatLng(position.latitude, position.longitude);
    state = AsyncData(location);
    return location;
  }

  void updateLocation(latLang2.LatLng? position) {
    if (position == null) return;
    state = AsyncData(position);
  }

  // Future<bool> animateToMyLocationOnOsm({
  //   required double destZoom,
  //   required flMap.MapController mapController,
  //   required TickerProvider vsync,
  //   required latLang2.LatLng latlng,
  // }) async {
  //   bool isMoved = false;
  //   final latTween = Tween<double>(
  //     begin: mapController.camera.center.latitude,
  //     end: latlng.latitude,
  //   );
  //   final lngTween = Tween<double>(
  //     begin: mapController.camera.center.longitude,
  //     end: latlng.longitude,
  //   );
  //   final zoomTween = Tween<double>(
  //     begin: mapController.camera.zoom,
  //     end: destZoom,
  //   );

  //   var controller = AnimationController(
  //     duration: const Duration(milliseconds: 500),
  //     vsync: vsync,
  //   );

  //   Animation<double> animation = CurvedAnimation(
  //     parent: controller,
  //     curve: Curves.easeInOut,
  //   );

  //   controller.addListener(() {
  //     mapController.move(
  //       latLang2.LatLng(
  //         latTween.evaluate(animation),
  //         lngTween.evaluate(animation),
  //       ),
  //       zoomTween.evaluate(animation),
  //     );
  //   });

  //   animation.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       controller.dispose();
  //       isMoved = true;
  //     }
  //   });

  //   await controller.forward();
  //   return isMoved;
  // }

  Future<bool> animateToMyLocationOnOsm({
    required double destinationZoom,
    required flMap.MapController mapController,
    required TickerProvider vsync,
    required latLang2.LatLng targetLatLng,
  }) async {
    final latitudeTween = Tween<double>(
      begin: mapController.camera.center.latitude,
      end: targetLatLng.latitude,
    );
    final longitudeTween = Tween<double>(
      begin: mapController.camera.center.longitude,
      end: targetLatLng.longitude,
    );
    final zoomTween = Tween<double>(
      begin: mapController.camera.zoom,
      end: destinationZoom,
    );

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );

    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.addListener(() {
      mapController.move(
        latLang2.LatLng(
          latitudeTween.evaluate(animation),
          longitudeTween.evaluate(animation),
        ),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
      }
    });

    animationController.forward();
    return true;
  }

  Future<void> animateToMyLocationOnGoogleMap(
      {required Completer mapController, required LatLng targetLatLng}) async {
    final GoogleMapController controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newLatLng(targetLatLng));
  }

  Future<void> addLocationItem(PlaceItemModel location) async {
    final repo = await ref.watch(addRepositoryProvider.future);
    await repo.addLocation(location: location);
  }

  Future<void> updateLocationItem(PlaceItemModel location) async {
    final repo = await ref.watch(addRepositoryProvider.future);
    await repo.updateLocation(location: location);
  }

  void editLocation() {}
}
