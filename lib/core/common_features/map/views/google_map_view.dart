// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:locate_me/core/common_features/map/core/theme/google_map_style.dart';
import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../features/add/provider/add_screen_provider.dart';

import 'widgets/general_map_wrapper/general_map_wrapper.dart';
import '../../../widget/loading.dart';
import '../core/enums/map_enum.dart';

class GoogleMapView extends ConsumerWidget {
  final Function(CameraPosition)? onCameraMove;
  final Future<dynamic> Function()? myLocationOnTab;
  final Future<dynamic> Function(LatLng? currentPosition)? onUpdateLocation;
  final Function(GoogleMapController googleMapController)? onMapCreated;
  final Set<Marker>? markers;

  const GoogleMapView({
    super.key,
    this.onCameraMove,
    this.myLocationOnTab,
    this.onUpdateLocation,
    required this.onMapCreated,
    this.markers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowingList = markers != null;

    Set<Marker> actualMarkers = markers ?? {};
    if (!isShowingList) {
      final pos = ref.watch(googleMapCurrentPositionProvider);
      if (pos.hasValue) {
        final result = pos.value!.location;
        final position = LatLng(result.lat, result.lng);
        actualMarkers = {
          Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            markerId: const MarkerId('newMarker'),
            position: position,
          ),
        };
      } else if (pos.hasError) {
        return Center(
          child: CustomText.bodyLarge(LocaleKeys.error_occurred.tr()),
        );
      } else {
        return const MyLoading();
      }
    }

    final currentColorStyle =
        ref.watch(mapSettingStyleNotifierProvider).value?.name;
    return SafeArea(
      child: GeneralMapWrapper(
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
          onCameraMove: onCameraMove,
          markers: actualMarkers,
          onMapCreated: onMapCreated,
          compassEnabled: false,
          initialCameraPosition: CameraPosition(
            target: actualMarkers.first.position,
            zoom: 20.4746,
          ),
        ),
        myLocationOnTab: myLocationOnTab,
        onUpdateLocation: () async {
          if (onUpdateLocation == null) return;
          onUpdateLocation!(actualMarkers.first.position);
        },
      ),
    );
  }
}
