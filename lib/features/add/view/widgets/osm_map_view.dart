import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;
import 'package:locate_me/core/theme/osm_map_style.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../core/helper/map/provider/map_setting_notifier_provider.dart';
import '../../../../core/widget/custom_add_info_box.dart';
import '../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../core/widget/general_map_wrapper.dart';
import '../../../home/model/place_item_model.dart';
import '../../provider/osm_location_provider.dart';
import 'dialog/add_location_dialog.dart';

class OsmMapView extends ConsumerStatefulWidget {
  const OsmMapView({super.key});
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
    return SafeArea(child: Consumer(
      builder: (context, ref, child) {
        return ref.watch(addScreenLocationProvider).when(
          data: (position) {
            return ref.watch(mapSettingStyleNotifierProvider).when(
              data: (data) {
                return GeneralMapWrapper(
                  map: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      onPositionChanged: (position, hasGesture) {
                        ref
                            .read(addScreenLocationProvider.notifier)
                            .updateLocation(position.center);
                      },
                      initialCenter: position,
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
                            point: position,
                            child: CustomMarkerAddInfoBox(position: position),
                            rotate: true,
                          ),
                        ],
                      ),
                    ],
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
                        .animateToMyLocationOnOsm(
                            destZoom: 20,
                            mapController: _mapController,
                            vsync: this);
                  },
                  addLocationOnTab: () async {
                    await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AddLocationView<PlaceItemModel>(
                          latLng: googleMap.LatLng(
                              position.latitude, position.longitude),
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
              error: (error, stackTrace) {
                return ErrorWidget(error);
              },
              loading: () {
                return const MyLoading();
              },
            );
          },
          error: (error, stackTrace) {
            return ErrorWidget(error);
          },
          loading: () {
            return const MyLoading();
          },
        );
      },
    ));
  }
}
