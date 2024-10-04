// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:locate_me/core/common_features/map/core/theme/osm_map_style.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../features/add/provider/add_screen_provider.dart';
import '../../../../generated/locale_keys.g.dart';

import '../../../widget/custom_marker_add_info_box.dart';
import '../../../widget/dialogs/status_widget.dart';
import 'widgets/general_map_wrapper/general_map_wrapper.dart';
import '../provider/map_setting_notifier_provider.dart';

class OsmMapView extends ConsumerStatefulWidget {
  final Future<dynamic> Function()? myLocationOnTab;
  final Function(LatLng? currentPositions)? onUpdateLocation;
  final Function(MapCamera, bool)? onPositionChanged;
  final MapController mapController;
  final List<Marker>? markers;
  final Function()? onBack;

  const OsmMapView(
      {super.key,
      this.myLocationOnTab,
      this.onUpdateLocation,
      this.onPositionChanged,
      required this.mapController,
      this.onBack,
      this.markers});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OsmMapView> {
  @override
  @override
  Widget build(BuildContext context) {
    final isShowingList = widget.markers != null;

    return ref.watch(mapSettingStyleNotifierProvider).when(
      data: (style) {
        if (isShowingList) {
          return showMap(widget.markers!, style);
        }
        return ref.watch(addLocationNotifierProvider).when(
          data: (position) {
            final currentPositions = position;
            final marker = widget.markers ??
                [
                  Marker(
                    width: 200.0,
                    height: 200,
                    alignment: Alignment.center,
                    point: currentPositions,
                    child: CustomMarkerAddInfoBox(position: currentPositions),
                    rotate: true,
                  )
                ];
            return showMap(marker, style, currentPositions: currentPositions);
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
    );
  }

  SafeArea showMap(List<Marker> markers, MapStyle style,
      {LatLng? currentPositions}) {
    return SafeArea(
      child: GeneralMapWrapper(
        onBack: widget.onBack,
        map: FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            onPositionChanged: widget.onPositionChanged,
            initialCenter: markers.first.point,
            initialZoom: 20.0,
          ),
          children: [
            TileLayer(
              tileProvider: NetworkTileProvider(),
              urlTemplate: OsmMapStyle.mapStyles[style.name],
              fallbackUrl: OsmMapStyle.mapStyles[style.name],
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.locate_me',
              // tileProvider: AssetTileProvider(),
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
            MarkerLayer(
              rotate: true,
              markers: markers,
            ),
          ],
        ),
        onGoToMyLocation: widget.myLocationOnTab,
        onAddOrEditLocation: (widget.onUpdateLocation == null)
            ? null
            : () {
                widget.onUpdateLocation!(currentPositions);
              },
      ),
    );
  }
}
