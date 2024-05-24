import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/provider/location_provider.dart';

import '../../../../../../core/widget/custom_add_info_box.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../provider/slider_location_provider.dart';

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
            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(data.first.latlng.latitude,
                        data.first.latlng.longitude),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                        rotate: true,
                        markers: data.map((e) {
                          return Marker(
                            height: 500,
                            width: 200,
                            alignment: Alignment.center,
                            point:
                                LatLng(e.latlng.latitude, e.latlng.longitude),
                            child: CustomMarkerAddInfoBox(
                                position: LatLng(
                                    e.latlng.latitude, e.latlng.longitude)),
                            rotate: true,
                          );
                        }).toList()),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 100.0,
                        onPageChanged: (index, reason) {
                          final newData = SliderNotifierDTO(
                              mapController: _mapController,
                              vsync: this,
                              position: data[index]);
                          ref
                              .read(sliderProvider(newData).notifier)
                              .animateToMyLocation(destZoom: 15, args: newData);
                        },
                      ),
                      items: data.map((place) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Text(
                                  'text ${place.latlng}',
                                  style: const TextStyle(fontSize: 16.0),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
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
