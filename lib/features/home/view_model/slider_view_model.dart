import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;
import 'package:latlong2/latlong.dart';
import 'package:locate_me/features/home/model/dto/slider_notifier_dto.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class SliderNotifier
    extends AutoDisposeFamilyNotifier<PlaceItemModel, SliderNotifierDTO> {
  @override
  PlaceItemModel build(SliderNotifierDTO arg) {
    return animateToLocationOnOsm(destZoom: 15, args: arg);
  }

  PlaceItemModel animateToLocationOnOsm({
    required double destZoom,
    required SliderNotifierDTO args,
  }) {
    final latTween = Tween<double>(
      begin: args.mapController.camera.center.latitude,
      end: args.position.latlng.latitude,
    );
    final lngTween = Tween<double>(
      begin: args.mapController.camera.center.longitude,
      end: args.position.latlng.longitude,
    );
    final zoomTween = Tween<double>(
      begin: args.mapController.camera.zoom,
      end: args.mapController.camera.zoom,
    );

    var controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: args.vsync,
    );

    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    controller.addListener(() {
      args.mapController.move(
        LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        ),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      }
    });

    controller.forward();
    state = args.position;
    return args.position;
  }

  void animateToMyLocationOnGoogleMap({
    required Completer mapController,
    required LatLong position,
  }) async {
    final googleMap.GoogleMapController controller = await mapController.future;
    final toGoogleCoordinate =
        googleMap.LatLng(position.latitude, position.longitude);
    await controller
        .animateCamera(googleMap.CameraUpdate.newLatLng(toGoogleCoordinate));
  }
}
