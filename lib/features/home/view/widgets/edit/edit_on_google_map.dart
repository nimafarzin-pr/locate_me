// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/common_features/map/views/google_map_view.dart';
import '../../../../../core/widget/dialogs/success_modal.dart';
import '../../../../add/provider/add_screen_provider.dart';
import '../../../model/place_item_model.dart';
import '../../../provider/home_screen_provider.dart';
import 'dialog/edit_form.dart';

class EditOnGoogleMap extends ConsumerStatefulWidget {
  const EditOnGoogleMap({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditOnGoogleMapState();
}

class _EditOnGoogleMapState extends ConsumerState<EditOnGoogleMap> {
  late Completer<GoogleMapController> _mapController;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _mapController = Completer();
  }

  @override
  Widget build(BuildContext context) {
    final editItem = ref.watch(selectedEditStateProviderForEditView);

    return GoogleMapView(
      onBack: () => context.pop(),
      markers: {
        Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: const MarkerId('newMarker'),
          position:
              LatLng(editItem!.latlng.latitude, editItem.latlng.longitude),
        ),
      },
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
          ref.read(selectedEditStateProviderForEditView.notifier).setEditItem(
              editItem.copyWith(
                  latlng: LatLong(
                      latitude: cameraPosition.target.latitude,
                      longitude: cameraPosition.target.longitude)));
        });
      },
      onUpdateLocation: (currentPosition) async {
        if (currentPosition == null) return;
        await showDialog(
          barrierDismissible: true,
          context: context,
          useRootNavigator: false,
          builder: (modalContext) {
            return EditLocationFormView<PlaceItemModel>(
              onAccept: (PlaceItemModel location) async {
                await ref
                    .read(addLocationNotifierProvider.notifier)
                    .updateLocationItem(location);
                Navigator.pop(modalContext);
                await showSuccessModal(
                  context,
                  onConfirm: () async {
                    Navigator.pop(context);
                    ref
                        .read(selectedEditStateProviderForEditView.notifier)
                        .clearEditItem();
                  },
                );
              },
              editItem: editItem,
            );
          },
        );
      },
    );
  }
}
