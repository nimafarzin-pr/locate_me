import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;
import 'package:locate_me/core/helper/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/theme/google_map_style.dart';

import 'package:locate_me/features/add/provider/osm_location_provider.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../core/widget/general_map_wrapper.dart';
import '../../../../core/widget/loading.dart';
import '../../provider/google_map_provider.dart';
import 'dialog/add_location_dialog.dart';

class GoogleMapAddView extends StatefulWidget {
  const GoogleMapAddView({super.key});

  @override
  State<GoogleMapAddView> createState() => _GoogleMapAddViewState();
}

class _GoogleMapAddViewState extends State<GoogleMapAddView> {
  late Completer<GoogleMapController> _mapController;

  @override
  void initState() {
    _mapController = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final pos = ref.watch(currentPositionProvider);
        if (pos.hasError) {
          return const Center(
            child: Text('Some error occurred!'),
          );
        }

        if (pos.value == null) {
          return const MyLoading();
        }

        final result = pos.value!.location;
        final position = LatLng(result.lat, result.lng);
        return GeneralMapWrapper(
          map: GoogleMap(
            style: GoogleMapStyle.mapStyles[
                ref.watch(mapSettingStyleNotifierProvider).value?.name],
            onCameraMove: (cameraPosition) {
              final latlng2 = latLngTwo.LatLng(cameraPosition.target.latitude,
                  cameraPosition.target.longitude);
              ref
                  .read(addScreenLocationProvider.notifier)
                  .updateLocation(latlng2);
            },
            markers: {
              Marker(
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  markerId: const MarkerId('newMarker'),
                  position: position)
            },
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              ref.refresh(addScreenLocationProvider);
              _mapController = Completer();
              _mapController.complete(controller);
            },
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 14.4746,
            ),
          ),
          settingOnTab: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return CustomMapOptionsDialog(
                  onOptionSelected: (p0) {},
                );
              },
            );
          },
          myLocationOnTab: () {
            ref
                .read(addScreenLocationProvider.notifier)
                .animateToMyLocationOnGoogleMap(mapController: _mapController);
          },
          addLocationOnTab: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AddLocationView<PlaceItemModel>(
                  latLng: position,
                  onAccept: (location) async {
                    await ref
                        .read(addScreenLocationProvider.notifier)
                        .addLocation(location);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
