import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/general_map_wrapper.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../../../../../core/common_features/map/core/google_map/provider/multiple_marker_provider.dart';
import '../../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../../../core/common_features/map/core/theme/google_map_style.dart';
import '../../../../model/dto/slider_notifier_dto.dart';
import '../../../../provider/slider_location_provider.dart';
import '../../custom_slider.dart';

class GoogleView extends ConsumerStatefulWidget {
  final List<PlaceItemModel> places;
  final bool polyLineFromPoint;
  const GoogleView({
    super.key,
    required this.places,
    this.polyLineFromPoint = false,
  });

  @override
  ConsumerState<GoogleView> createState() => _MapListState();
}

class _MapListState extends ConsumerState<GoogleView>
    with TickerProviderStateMixin {
  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  int carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final customMarker =
            ref.watch(getMultipleMarkerProvider(widget.places));
        return customMarker.when(
          data: (locationData) {
            return GeneralMapWrapper(
                map: Stack(
              children: [
                GoogleMap(
                  style: GoogleMapStyle.mapStyles[
                      ref.watch(mapSettingStyleNotifierProvider).value?.name],
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  markers: locationData.markers.map(
                    (e) {
                      final dex = locationData.markers.toList().indexOf(e);
                      return Marker(
                          markerId: e.mapsId,
                          icon: carouselIndex == dex
                              ? BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueCyan)
                              : e.icon,
                          infoWindow: e.infoWindow,
                          onTap: () {},
                          position: LatLng(
                              e.position.latitude, e.position.longitude));
                    },
                  ).toSet(),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.places.first.latlng.latitude,
                        widget.places.first.latlng.longitude),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (controller) {
                    _mapController = Completer();
                    _mapController.complete(controller);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCarouselSlider(
                      data: locationData.locations,
                      onPageChanged: (index, reason) async {
                        setState(() {
                          carouselIndex = index;
                        });
                        final newData = SliderNotifierDTO<GoogleMapController>(
                            mapController: await _mapController.future,
                            vsync: this,
                            position: locationData.locations[index]);
                        ref
                            .read(sliderProvider(newData).notifier)
                            .animateToMyLocationOnGoogleMap(
                                mapController: _mapController,
                                position: locationData.locations[index].latlng);
                      },
                    ),
                  ),
                )
              ],
            ));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (err, stack) {
            return Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.white,
              child: Center(child: CustomText.bodyLarge('Error : $err')),
            );
          },
        );
      },
    );
  }
}
