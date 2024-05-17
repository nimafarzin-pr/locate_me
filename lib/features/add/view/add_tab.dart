// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/widget/disabled_location_service_view.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/core/widget/permission_denied_screen.dart';
import 'package:locate_me/features/add/view/widgets/location_button.dart';

import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/map/model/marker_data_model.dart';
import 'package:locate_me/features/map/provider/single_marker_provider.dart';

import '../../home/view/widgets/marker_test2.dart';
import '../../map/provider/permission_provider.dart';

class AddTab extends ConsumerStatefulWidget {
  const AddTab({super.key});

  @override
  ConsumerState<AddTab> createState() => _AddTabState();
}

class _AddTabState extends ConsumerState<AddTab> {
  Completer<GoogleMapController> _mapController = Completer();

  Future<void> _goToMyLocation(LatLng location) async {
    final GoogleMapController controller = await _mapController.future;
    // controller.showMarkerInfoWindow(const MarkerId('dsf'));
    await controller.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps, Place place) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      markersList.add(Marker(
          markerId: MarkerId(place.title),
          position: LatLng(place.latlng.latitude, place.latlng.longitude),
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return markersList;
  }

  List<Marker> customMarker = [];
  @override
  Widget build(BuildContext context) {
    final permission = ref.watch(permissionProvider);
    return switch (permission) {
      AsyncValue(:final SystemAndPermissionStatus error?) => Builder(
          builder: (_) {
            if (error == SystemAndPermissionStatus.systemLocationDisable) {
              return const DisabledLocationServiceView();
            } else if (error == SystemAndPermissionStatus.permissionDenied ||
                error == SystemAndPermissionStatus.permissionDeniedForEver) {
              return const PermissionDeniedScreen();
            } else {
              return const MyLoading();
            }
          },
        ),
      AsyncValue(:final valueOrNull?) => Builder(
          builder: (_) {
            final marker = ref.watch(currentPositionProvider);
            return marker.when(
              error: (error, stackTrace) {
                return const Center(
                  child: Text('Some error occurred!'),
                );
              },
              loading: () => const MyLoading(),
              data: (data) {
                final result = data;
                final latLong = result.locations.first;
                final position = LatLng(
                    ref.watch(listenablePositionProvider).value != null
                        ? ref.watch(listenablePositionProvider).value!.latitude
                        : latLong.latlng.latitude,
                    ref.watch(listenablePositionProvider).value != null
                        ? ref.watch(listenablePositionProvider).value!.longitude
                        : latLong.latlng.longitude);

                // MarkerGenerator(
                //   [Icon(Icons.pin_drop)],
                //   (bitmaps) {
                //     setState(() {
                //       customMarker =
                //           mapBitmapsToMarkers(bitmaps, result.locations.first);
                //     });
                //   },
                // ).generate(context);
                // log(' ******* ${customMarker}');

                return Stack(children: [
                  buildGoogleMap(result, latLong, position, customMarker),
                  LocationButton(onPressed: () async {
                    await _goToMyLocation(position);
                  })
                ]);
              },
            );
          },
        ),
      _ => const MyLoading(),
    };
  }

  GoogleMap buildGoogleMap(
      MarkersData result, Place latLong, position, List<Marker> marker) {
    return GoogleMap(
      markers: {
        Marker(
            icon: result.markers.first.icon,
            markerId: MarkerId(latLong.latlng.toString()),
            onTap: () {},
            infoWindow: InfoWindow(
                title: latLong.date.toString(),
                snippet: latLong.address.toString()),
            position: position)
      },
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        _mapController = Completer();
        _mapController.complete(controller);
        // TODO
        // check below code if worked use that
        // if (!mapsCompleter.isCompleted) {
        //   mapsCompleter.complete(controller);
        //   mapsController = await mapsCompleter.future;
        // } else {
        //   mapsController = controller;
        // }
        _goToMyLocation(position);
      },
      initialCameraPosition: CameraPosition(
        target: position,
        zoom: 14.4746,
      ),
    );
  }
}
