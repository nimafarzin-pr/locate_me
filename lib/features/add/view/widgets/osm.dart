import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;

import '../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../core/common_features/map/views/osm_map_view.dart';
import '../../../../core/widget/dialogs/success_modal.dart';
import '../../../home/model/place_item_model.dart';
import '../../provider/add_screen_provider.dart';
import 'dialog/add_form.dart';

class OsmView extends ConsumerStatefulWidget {
  const OsmView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OsmViewState();
}

class _OsmViewState extends ConsumerState<OsmView>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OsmMapView(
      mapController: _mapController,
      onPositionChanged: (position, hasGesture) {
        ref
            .read(addLocationNotifierProvider.notifier)
            .updateLocation(position.center);
      },
      myLocationOnTab: () async {
        final currentLocation = await ref
            .read(addLocationNotifierProvider.notifier)
            .currentLocation;
        await ref
            .read(addLocationNotifierProvider.notifier)
            .animateToMyLocationOnOsm(
                targetLatLng: currentLocation,
                destinationZoom: 20,
                mapController: _mapController,
                vsync: this);
      },
      onUpdateLocation: (dynamic currentPositions) async {
        await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (modalContext) {
            return AddLocationFormView<PlaceItemModel>(
              latLng: googleMap.LatLng(
                  currentPositions.latitude, currentPositions.longitude),
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
