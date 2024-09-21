// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/common_features/map/views/google_map_view.dart';

import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../../../core/navigation/router/router.dart';
import '../../../../../../../core/navigation/routes.dart';
import '../../../../../model/dto/slider_notifier_dto.dart';

import '../../../../../provider/home_screen_provider.dart';
import '../../../custom_slider.dart';

class GoogleView extends StatefulWidget {
  final bool polyLineFromPoint;
  final bool withCarouselSlider;
  const GoogleView({
    super.key,
    this.polyLineFromPoint = false,
    this.withCarouselSlider = true,
  });

  @override
  State<GoogleView> createState() => _MapListState();
}

class _MapListState extends State<GoogleView> with TickerProviderStateMixin {
  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  int carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    final isHomeListOnMap =
        router.routerDelegate.currentConfiguration.uri.toString() ==
            Routes.root;
    return Consumer(
      builder: (context, ref, child) {
        final editItem = ref.watch(selectedEditStateProviderForEditView);
        final List<PlaceItemModel> data = editItem != null && !isHomeListOnMap
            ? [editItem]
            : ref.watch(filteredItemsProvider);

        return Stack(
          children: [
            GoogleMapView(
              onMapCreated: (controller) {
                _mapController = Completer();
                _mapController.complete(controller);
              },
              markers: data.map(
                (e) {
                  final dex =
                      ref.read(filteredItemsProvider).toList().indexOf(e);

                  log('${carouselIndex == dex}');
                  return Marker(
                      // onTap: () {},
                      zIndex: 999999,
                      // consumeTapEvents: true,
                      markerId: MarkerId(e.id.toString()),
                      icon: carouselIndex == dex && widget.withCarouselSlider
                          ? BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueCyan)
                          : BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen),
                      infoWindow:
                          InfoWindow(title: e.title, snippet: e.description),
                      position: LatLng(e.latlng.latitude, e.latlng.longitude));
                },
              ).toSet(),
            ),
            widget.withCarouselSlider == false && data.isEmpty
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInScaleAnimation(
                        duration: const Duration(milliseconds: 800),
                        child: CustomCarouselSlider(
                          data: data,
                          onPageChanged: (index) async {
                            setState(() {
                              carouselIndex = index;
                            });
                            final newData =
                                SliderNotifierDTO<GoogleMapController>(
                                    mapController: await _mapController.future,
                                    vsync: this,
                                    position:
                                        ref.read(filteredItemsProvider)[index]);
                            ref
                                .read(sliderNotifierProvider(newData).notifier)
                                .animateToMyLocationOnGoogleMap(
                                    mapController: _mapController,
                                    position: ref
                                        .read(filteredItemsProvider)[index]
                                        .latlng);
                          },
                        ),
                      ),
                    ),
                  )
          ],
        );
      },
    );
  }
}
