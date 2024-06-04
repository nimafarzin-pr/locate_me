import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/provider/location_provider.dart';

import '../../../../../../core/helper/map/provider/map_setting_notifier_provider.dart';
import '../../../../../../core/theme/osm_map_style.dart';
import '../../../../../../core/widget/custom_add_info_box.dart';
import '../../../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../../../core/widget/general_map_wrapper.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../provider/slider_location_provider.dart';
import '../../location_item.dart';

class OsmView extends StatefulWidget {
  const OsmView({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final places = ref.watch(locationProvider);
        return places.when(
          data: (data) {
            return GeneralMapWrapper(
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
              map: Stack(
                children: [
                  ref.watch(mapSettingStyleNotifierProvider).when(
                    data: (style) {
                      return FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: LatLng(data.first.latlng.latitude,
                              data.first.latlng.longitude),
                        ),
                        children: [
                          TileLayer(
                              urlTemplate: OsmMapStyle.mapStyles[style.name],
                              subdomains: const ['a', 'b', 'c'],
                              retinaMode: true

                              // userAgentPackageName: 'com.example.app',
                              ),
                          MarkerLayer(
                              rotate: true,
                              markers: data.map((e) {
                                return Marker(
                                  height: 40,
                                  // width: 200,
                                  alignment: Alignment.center,
                                  point: LatLng(
                                      e.latlng.latitude, e.latlng.longitude),
                                  child: CustomMarkerAddInfoBox(
                                      placeItemModel: e,
                                      position: LatLng(e.latlng.latitude,
                                          e.latlng.longitude)),
                                  rotate: true,
                                );
                              }).toList()),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorWidget(error);
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
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: context.screenHeight / 5,
                          onPageChanged: (index, reason) {
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
                        items: data.map((place) {
                          return Builder(
                            builder: (BuildContext context) {
                              return LocationItem(
                                item: place,
                                isCarouselItem: true,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
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
    );
  }
}
