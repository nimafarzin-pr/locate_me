import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/custom_add_info_box.dart';
import '../../../../core/widget/custom_location_button.dart';
import '../../provider/osm_location_provider.dart';

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
        return ref.watch(addLocationProvider).when(
          data: (position) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    onPositionChanged: (position, hasGesture) {
                      ref
                          .read(addLocationProvider.notifier)
                          .updateLocation(position.center);
                    },
                    initialCenter: position,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],

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
                          height: 500,
                          width: 200,
                          alignment: Alignment.center,
                          point: position,
                          child: CustomMarkerAddInfoBox(position: position),
                          rotate: true,
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: CustomLocationButton(
                    onPressed: () {
                      ref
                          .read(addLocationProvider.notifier)
                          .animateToMyLocationOnOsm(
                              destZoom: 20,
                              mapController: _mapController,
                              vsync: this);
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('$error'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    ));
  }
}
