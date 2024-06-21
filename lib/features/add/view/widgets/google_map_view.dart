// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;

import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/common_features/map/core/theme/google_map_style.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/add/provider/osm_location_provider.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';

import '../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../core/widget/general_map_wrapper.dart';
import '../../../../core/widget/loading.dart';
import '../../provider/google_map_location_provider.dart';
import 'dialog/add_or_update_location_dialog.dart';

class GoogleMapAddView extends ConsumerStatefulWidget {
  const GoogleMapAddView({
    super.key,
  });

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
    final editItem = ref.watch(editStateProvider);
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
    final marker = {
      Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: const MarkerId('newMarker'),
          position: editItem != null
              ? LatLng(editItem.latlng.latitude, editItem.latlng.longitude)
              : position)
    };

    return SafeArea(
      child: BackButtonListener(
        onBackButtonPressed: () async {
          ref.read(editStateProvider.notifier).state = null;
          return false;
        },
        child: GeneralMapWrapper(
          isEditMode: editItem != null,
          map: GoogleMap(
            style: GoogleMapStyle.mapStyles[
                ref.watch(mapSettingStyleNotifierProvider).value?.name],
            onCameraMove: (cameraPosition) {
              if (editItem != null) {
                ref.read(editStateProvider.notifier).state = editItem.copyWith(
                    latlng: LatLong(
                        latitude: cameraPosition.target.latitude,
                        longitude: cameraPosition.target.longitude));
              } else {
                final latlng2 = latLngTwo.LatLng(cameraPosition.target.latitude,
                    cameraPosition.target.longitude);
                ref
                    .read(currentPositionProvider.notifier)
                    .updateLocation(latlng2);
              }
            },
            markers: marker,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _mapController = Completer();
              _mapController.complete(controller);
            },
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: marker.first.position,
              zoom: 20.4746,
            ),
          ),
          myLocationOnTab: () {
            ref
                .read(currentPositionProvider.notifier)
                .animateToMyLocationOnGoogleMap(mapController: _mapController);
          },
          addOrUpdateLocationOnTab: () async {
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AddOrUpdateLocationDialogView<PlaceItemModel>(
                  latLng: marker.first.position,
                  editItem: editItem,
                  onAccept: (PlaceItemModel location) async {
                    log('>>|| $location');
                    if (editItem == null) {
                      await ref
                          .read(currentPositionProvider.notifier)
                          .addLocationItem(location);
                    } else {
                      await ref
                          .read(currentPositionProvider.notifier)
                          .updateLocationItem(location);

                      ref.read(editStateProvider.notifier).state = null;
                      ref.invalidate(editStateProvider);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
