// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/common_features/map/views/osm_map_view.dart';

import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../../../../core/navigation/router/router.dart';
import '../../../../../../../core/navigation/routes.dart';
import '../../../../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../model/dto/slider_notifier_dto.dart';

import '../../../../../model/place_item_model.dart';
import '../../../../../provider/home_screen_provider.dart';
import '../../../custom_slider.dart';

class OsmView extends StatefulWidget {
  final bool withCarouselSlider;

  const OsmView({
    super.key,
    this.withCarouselSlider = true,
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
        final isHomeListOnMap =
            router.routerDelegate.currentConfiguration.uri.toString() ==
                Routes.root;
        final List<PlaceItemModel> data = ref.watch(filteredItemsProvider);

        return Stack(
          children: [
            ref.watch(mapSettingStyleNotifierProvider).when(
              data: (style) {
                return OsmMapView(
                  mapController: _mapController,
                  markers: data.map((e) {
                    final dex = data.indexOf(e);
                    return Marker(
                      height: context.screenWidth / 3,
                      width: context.screenWidth / 2,
                      alignment: Alignment.topCenter,
                      point: LatLng(e.latlng.latitude, e.latlng.longitude),
                      child: CustomMarkerAddInfoBox(
                          markerColor:
                              dex == carouselIndex && widget.withCarouselSlider
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                          placeItemModel: e,
                          showCard: dex == carouselIndex,
                          position:
                              LatLng(e.latlng.latitude, e.latlng.longitude)),
                      rotate: true,
                    );
                  }).toList(),
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
            widget.withCarouselSlider == false
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInScaleAnimation(
                        child: CustomCarouselSlider(
                          data: data,
                          onPageChanged: (index) async {
                            setState(() {
                              carouselIndex = index;
                            });
                            final newData = SliderNotifierDTO<MapController>(
                                mapController: _mapController,
                                vsync: this,
                                position: data[index]);
                            ref
                                .read(sliderNotifierProvider(newData).notifier)
                                .animateToLocationOnOsm(
                                    destZoom: 15, args: newData);
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
