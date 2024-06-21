import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../../../core/common_features/map/core/theme/osm_map_style.dart';
import '../../../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../../../core/widget/dialogs/custom_map_options.dart';
import '../../../../../../core/widget/general_map_wrapper.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../model/place_item_model.dart';
import '../../../../provider/slider_location_provider.dart';
import '../../custom_slider.dart';
import '../../location_item.dart';

class OsmView extends StatefulWidget {
  final List<PlaceItemModel> places;

  const OsmView({super.key, required this.places});

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
        return GeneralMapWrapper(
          map: Stack(
            children: [
              ref.watch(mapSettingStyleNotifierProvider).when(
                data: (style) {
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(widget.places.first.latlng.latitude,
                          widget.places.first.latlng.longitude),
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
                          alignment: Alignment.topCenter,
                          markers: widget.places.map((e) {
                            final dex = widget.places.indexOf(e);
                            return Marker(
                              height: context.screenWidth / 3,
                              width: context.screenWidth / 2,
                              alignment: Alignment.topCenter,
                              point:
                                  LatLng(e.latlng.latitude, e.latlng.longitude),
                              child: CustomMarkerAddInfoBox(
                                  markerColor: dex == carouselIndex
                                      ? Theme.of(context).colorScheme.secondary
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
                  child: CustomCarouselSlider(
                    data: widget.places,
                    onPageChanged: (index, reason) async {
                      log('$reason');

                      setState(() {
                        carouselIndex = index;
                      });
                      final newData = SliderNotifierDTO<MapController>(
                          mapController: _mapController,
                          vsync: this,
                          position: widget.places[index]);
                      ref
                          .read(sliderProvider(newData).notifier)
                          .animateToLocationOnOsm(destZoom: 15, args: newData);
                    },
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
