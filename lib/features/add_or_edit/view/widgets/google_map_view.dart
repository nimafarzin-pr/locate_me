import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLngTwo;
import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/common_features/map/core/theme/google_map_style.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/common_features/map/core/enums/map_enum.dart';
import '../../../../core/widget/general_map_wrapper/general_map_wrapper.dart';
import '../../../../core/widget/loading.dart';
import '../../provider/google_map_location_provider.dart';
import '../../provider/osm_location_provider.dart';
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
  Timer? _debounce;

  @override
  void initState() {
    _mapController = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editItem = ref.watch(selectedEditStateProviderForEditAndView);
    final pos = ref.watch(googleMapCurrentPositionProvider);

    if (pos.hasError) {
      return Center(
        child: CustomText.bodyLarge(LocaleKeys.error_occurred.tr()),
      );
    }

    if (pos.value == null) {
      return const MyLoading();
    }

    final result = pos.value!.location;
    final position = LatLng(result.lat, result.lng);
    final marker = {
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: const MarkerId('newMarker'),
        position: editItem != null
            ? LatLng(editItem.latlng.latitude, editItem.latlng.longitude)
            : position,
      ),
    };
    final currentColorStyle =
        ref.watch(mapSettingStyleNotifierProvider).value?.name;
    return SafeArea(
      child: BackButtonListener(
        onBackButtonPressed: () async {
          ref.read(selectedEditStateProviderForEditAndView.notifier).state =
              null;
          return false;
        },
        child: GeneralMapWrapper(
          isEditMode: editItem != null,
          map: GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            buildingsEnabled: false,
            trafficEnabled: true,
            indoorViewEnabled: true,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            }.toSet(),
            style: currentColorStyle == MapStyle.standard.name
                ? GoogleMapStyle.standardStyle
                : currentColorStyle == MapStyle.dark.name
                    ? GoogleMapStyle.darkStyle
                    : GoogleMapStyle.silverStyle,
            onCameraMove: (cameraPosition) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                if (editItem != null) {
                  ref
                          .read(selectedEditStateProviderForEditAndView.notifier)
                          .state =
                      editItem.copyWith(
                          latlng: LatLong(
                              latitude: cameraPosition.target.latitude,
                              longitude: cameraPosition.target.longitude));
                } else {
                  final latlng2 = latLngTwo.LatLng(
                      cameraPosition.target.latitude,
                      cameraPosition.target.longitude);
                  ref
                      .read(currentPositionProvider.notifier)
                      .updateLocation(latlng2);
                }
              });
            },
            markers: marker,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: marker.first.position,
              zoom: 20.4746,
            ),
          ),
          myLocationOnTab: () async {
            await ref
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
                    if (editItem == null) {
                      await ref
                          .read(currentPositionProvider.notifier)
                          .addLocationItem(location);
                    } else {
                      await ref
                          .read(currentPositionProvider.notifier)
                          .updateLocationItem(location);

                      ref
                          .read(
                              selectedEditStateProviderForEditAndView.notifier)
                          .state = null;
                      ref.invalidate(selectedEditStateProviderForEditAndView);
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
