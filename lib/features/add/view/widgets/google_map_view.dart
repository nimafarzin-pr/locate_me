import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;
import 'package:locate_me/core/helper/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/theme/google_map_style.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import 'package:locate_me/features/add/provider/osm_location_provider.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../core/widget/general_map_wrapper.dart';
import '../../../../core/widget/loading.dart';
import '../../../home/provider/edit_item_provider.dart';
import '../../provider/google_map_location_provider.dart';
import 'dialog/add_location_dialog.dart';

class GoogleMapAddView extends ConsumerStatefulWidget {
  const GoogleMapAddView({super.key});

  @override
  ConsumerState<GoogleMapAddView> createState() => _GoogleMapAddViewState();
}

class _GoogleMapAddViewState extends ConsumerState<GoogleMapAddView> {
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
        final pos = ref.watch(googleMapCurrentPositionProvider);
        if (pos.hasError) {
          return Center(
            child: CustomText.bodyLarge('Some error occurred!'),
          );
        }

        if (pos.value == null) {
          return const MyLoading();
        }

        final result = pos.value!.location;
        final position = LatLng(result.lat, result.lng);
        Set<Marker> marker = {};
        final edit = ref.read(editItemProvider);
        final isEditMode = ref.watch(isEditModeProvider);

        marker = {
          Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              markerId: const MarkerId('newMarker'),
              position: position)
        };
        log('_+_+_$edit');
        if (isEditMode) {
          marker = {
            Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                markerId: const MarkerId('newMarker'),
                position: LatLng(edit!.latlng.latitude, edit.latlng.longitude))
          };
        }

        return GeneralMapWrapper(
          map: GoogleMap(
            style: GoogleMapStyle.mapStyles[
                ref.watch(mapSettingStyleNotifierProvider).value?.name],
            onCameraMove: (cameraPosition) {
              if (isEditMode) {
                ref.read(editItemProvider.notifier).updatePlaceItem(
                    edit?.copyWith(
                        latlng: LatLong(
                            latitude: cameraPosition.target.latitude,
                            longitude: cameraPosition.target.longitude)));
              }
              final latlng2 = latLngTwo.LatLng(cameraPosition.target.latitude,
                  cameraPosition.target.longitude);
              ref
                  .read(osmCurrentPositionProvider.notifier)
                  .updateLocation(latlng2);
            },
            markers: marker,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
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
                .read(osmCurrentPositionProvider.notifier)
                .animateToMyLocationOnGoogleMap(mapController: _mapController);
          },
          addOrUpdateLocationOnTab: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AddOrUpdateLocationDialogView<PlaceItemModel>(
                  latLng: position,
                  onAccept: (PlaceItemModel location) async {
                    log('>>|| $location');
                    !isEditMode
                        ? await ref
                            .read(osmCurrentPositionProvider.notifier)
                            .addLocationItem(location)
                        : await ref
                            .read(osmCurrentPositionProvider.notifier)
                            .updateLocationItem(location);
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
