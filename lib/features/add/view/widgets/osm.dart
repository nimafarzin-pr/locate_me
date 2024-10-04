import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;

import '../../../../core/common_features/map/views/osm_map_view.dart';
import '../../../../core/widget/dialogs/status_widget.dart';
import '../../../../generated/locale_keys.g.dart';
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
                  await showDialog(
                    context: context,
                    builder: (successModal) {
                      return Center(
                        child: SizedBox(
                          height: 300,
                          child: StatusWidget(
                              status: ActionStatus.success,
                              onConfirm: () async {
                                await Navigator.maybePop(successModal);
                              },
                              showCancelButton: false,
                              iconColor: Colors.green,
                              title:
                                  LocaleKeys.location_saved_successfully.tr()),
                        ),
                      );
                    },
                  );
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
