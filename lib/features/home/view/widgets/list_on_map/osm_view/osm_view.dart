import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../../../core/common_features/map/core/theme/osm_map_style.dart';
import '../../../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../../core/widget/general_map_wrapper.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../provider/filter_provider.dart';
import '../../../../provider/slider_location_provider.dart';
import '../../custom_slider.dart';

class OsmView extends StatefulWidget {
  const OsmView({
    super.key,
  });

  @override
  State<OsmView> createState() => _OsmViewState();
}

class _OsmViewState extends State<OsmView> with TickerProviderStateMixin {
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

  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(filteredItemsProvider);

        return GeneralMapWrapper(
          map: Stack(
            children: [
              ref.watch(mapSettingStyleNotifierProvider).when(
                data: (style) {
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialZoom: 18,
                      initialCenter: LatLng(data.first.latlng.latitude,
                          data.first.latlng.longitude),
                    ),
                    children: [
                      // PolylineLayer(
                      //   polylines: [
                      //     Polyline(
                      //       points: data
                      //           .map((e) => LatLng(
                      //               e.latlng.latitude, e.latlng.longitude))
                      //           .toList(),
                      //       strokeWidth: 4.0,
                      //       color: Colors.purple,
                      //     ),
                      //   ],
                      // ),
                      TileLayer(
                          urlTemplate: OsmMapStyle.mapStyles[style.name],
                          subdomains: const ['a', 'b', 'c'],
                          retinaMode: true

                          // userAgentPackageName: 'com.example.app',
                          ),
                      MarkerLayer(
                          rotate: true,
                          alignment: Alignment.topCenter,
                          markers: data.map((e) {
                            final dex = data.indexOf(e);
                            return Marker(
                              height: context.screenWidth / 3,
                              width: context.screenWidth / 2,
                              alignment: Alignment.topCenter,
                              point:
                                  LatLng(e.latlng.latitude, e.latlng.longitude),
                              child: CustomMarkerAddInfoBox(
                                  markerColor: dex == carouselIndex
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                  placeItemModel: e,
                                  showCard: dex == carouselIndex,
                                  position: LatLng(
                                      e.latlng.latitude, e.latlng.longitude)),
                              rotate: true,
                            );
                          }).toList()),
                    ],
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
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeInScaleAnimation(
                    child: CustomCarouselSlider(
                      data: data,
                      onPageChanged: (index, reason) async {
                        log('$reason');

                        setState(() {
                          carouselIndex = index;
                        });
                        final newData = SliderNotifierDTO<MapController>(
                            mapController: _mapController,
                            vsync: this,
                            position: data[index]);
                        ref
                            .read(sliderProvider(newData).notifier)
                            .animateToLocationOnOsm(
                                destZoom: 15, args: newData);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
