// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;
import 'package:latlong2/latlong.dart';

import 'package:locate_me/core/common_features/map/core/theme/osm_map_style.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';

import '../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../core/widget/dialogs/status_widget.dart';
import '../../../../core/widget/general_map_wrapper.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../home/model/place_item_model.dart';
import '../../provider/osm_location_provider.dart';
import 'dialog/add_or_update_location_dialog.dart';

class OsmMapView extends ConsumerStatefulWidget {
  const OsmMapView({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OsmMapView>
    with TickerProviderStateMixin {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editItem = ref.watch(editStateProvider);
    return ref.watch(currentPositionProvider).when(
      data: (position) {
        final currentPositions = editItem != null
            ? LatLng(editItem.latlng.latitude, editItem.latlng.longitude)
            : position;
        return ref.watch(mapSettingStyleNotifierProvider).when(
          data: (data) {
            return SafeArea(
              child: BackButtonListener(
                onBackButtonPressed: () async {
                  ref.read(editStateProvider.notifier).state = null;
                  return false;
                },
                child: GeneralMapWrapper(
                  isEditMode: editItem != null,
                  map: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      onPositionChanged: (position, hasGesture) {
                        if (editItem != null) {
                          ref.read(editStateProvider.notifier).state = ref
                              .watch(editStateProvider)
                              ?.copyWith(
                                  latlng: LatLong(
                                      latitude: position.center!.latitude,
                                      longitude: position.center!.longitude));
                        } else {
                          ref
                              .read(currentPositionProvider.notifier)
                              .updateLocation(position.center);
                        }
                      },
                      initialCenter: currentPositions,
                      initialZoom: 20.0,
                    ),
                    children: [
                      TileLayer(
                          urlTemplate: OsmMapStyle.mapStyles[data.name],
                          subdomains: const ['a', 'b', 'c'],
                          retinaMode: true

                          // userAgentPackageName: 'com.example.app',
                          ),
                      // RichAttributionWidget(
                      //   attributions: [
                      //     TextSourceAttribution(
                      //       'OpenStreetMap contributors',
                      //       onTap: () => launchUrl(
                      //           Uri.parse('https://openstreetmap.org/copyright')),
                      //     ),
                      //   ],
                      // ),
                      MarkerLayer(
                        rotate: true,
                        markers: [
                          Marker(
                            width: 200.0,
                            height: 200,
                            alignment: Alignment.center,
                            point: currentPositions,
                            child: CustomMarkerAddInfoBox(
                                position: currentPositions),
                            rotate: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  myLocationOnTab: () {
                    ref
                        .read(currentPositionProvider.notifier)
                        .animateToMyLocationOnOsm(
                            destZoom: 20,
                            mapController: _mapController,
                            vsync: this);
                  },
                  addOrUpdateLocationOnTab: () async {
                    await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddOrUpdateLocationDialogView<PlaceItemModel>(
                          editItem: editItem,
                          latLng: googleMap.LatLng(currentPositions.latitude,
                              currentPositions.longitude),
                          onAccept: (PlaceItemModel location) async {
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
          },
          error: (error, stackTrace) {
            return StatusWidget(
              title: LocaleKeys.error.tr(),
              content: "$error",
              iconColor: Theme.of(context).colorScheme.error,
            );
          },
          loading: () {
            return const MyLoading();
          },
        );
      },
      error: (error, stackTrace) {
        return StatusWidget(
          title: LocaleKeys.error.tr(),
          content: "$error",
          iconColor: Theme.of(context).colorScheme.error,
        );
      },
      loading: () {
        return const MyLoading();
      },
    );
  }
}
