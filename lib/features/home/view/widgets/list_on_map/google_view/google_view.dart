// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';

import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/core/widget/general_map_wrapper/general_map_wrapper.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../../core/common_features/map/core/theme/google_map_style.dart';
import '../../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../provider/filter_provider.dart';
import '../../../../provider/slider_location_provider.dart';
import '../../../../view_model/edit_item_notifier.dart';
import '../../custom_slider.dart';

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
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(selectedEditStateProviderForEditAndView) != null
            ? [ref.watch(selectedEditStateProviderForEditAndView)]
            : ref.watch(filteredItemsProvider);

        final currentColorStyle =
            ref.watch(mapSettingStyleNotifierProvider).value?.name;
        log(currentColorStyle.toString());
        return GeneralMapWrapper(
            map: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              buildingsEnabled: false,
              trafficEnabled: true,
              indoorViewEnabled: true,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              }.toSet(),
              style: currentColorStyle == MapStyle.standard.name
                  ? GoogleMapStyle.standardStyle
                  : currentColorStyle == MapStyle.dark.name
                      ? GoogleMapStyle.darkStyle
                      : GoogleMapStyle.silverStyle,
              polylines: widget.polyLineFromPoint
                  ? {
                      Polyline(
                        polylineId: const PolylineId('dsf'),
                        points: data
                            .map((e) =>
                                LatLng(e!.latlng.latitude, e.latlng.longitude))
                            .toList(),
                      )
                    }
                  : const <Polyline>{},
              markers: data.map(
                (e) {
                  final dex =
                      ref.read(filteredItemsProvider).toList().indexOf(e!);

                  log('${carouselIndex == dex}');
                  return Marker(
                      // onTap: () {},
                      zIndex: 999999,
                      // consumeTapEvents: true,
                      markerId: MarkerId(e.id.toString()),
                      icon: carouselIndex == dex
                          ? BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueCyan)
                          : BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen),
                      infoWindow:
                          InfoWindow(title: e.title, snippet: e.description),
                      position: LatLng(e.latlng.latitude, e.latlng.longitude));
                },
              ).toSet(),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    data.first!.latlng.latitude, data.first!.latlng.longitude),
                zoom: 14.4746,
              ),
              onMapCreated: (controller) {
                _mapController = Completer();
                _mapController.complete(controller);
              },
            ),
            widget.withCarouselSlider == false
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
                          data: data as List<PlaceItemModel>,
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
                                .read(sliderProvider(newData).notifier)
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
        ));
      },
    );
  }
}
