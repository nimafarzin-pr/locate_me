import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;
import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';

import '../../../../core/common_features/map/views/google_map_view.dart';

import '../../../../core/widget/dialogs/success_modal.dart';
import '../../../home/model/place_item_model.dart';
import '../../provider/add_screen_provider.dart';
import 'dialog/add_form.dart';

class GoogleView extends ConsumerStatefulWidget {
  const GoogleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMapState();
}

class _AddMapState extends ConsumerState<GoogleView> {
  late Completer<GoogleMapController> _mapController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _mapController = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMapView(
      onMapCreated: (controller) {
        _mapController.complete(controller);
      },
      myLocationOnTab: () async {
        final currentLocation = await ref
            .read(addLocationNotifierProvider.notifier)
            .currentLocation;

        await ref
            .read(addLocationNotifierProvider.notifier)
            .animateToMyLocationOnGoogleMap(
                mapController: _mapController,
                targetLatLng: LatLng(
                    currentLocation.latitude, currentLocation.longitude));
      },
      onCameraMove: (cameraPosition) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          final latlng2 = latLngTwo.LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude);
          ref
              .read(addLocationNotifierProvider.notifier)
              .updateLocation(latlng2);
        });
      },
      onUpdateLocation: (LatLng? currentPosition) async {
        if (currentPosition == null) return;
        await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (modalContext) {
            return AddLocationFormView<PlaceItemModel>(
              latLng: currentPosition,
              onAccept: (PlaceItemModel location) async {
                try {
                  await ref
                      .read(addLocationNotifierProvider.notifier)
                      .addLocationItem(location);
                  Navigator.pop(modalContext);
                  await showSuccessModal(context);
                } catch (e) {
                  log("ERR : $e");
                }
              },
            );
          },
        );
      },
    );
  }
}
