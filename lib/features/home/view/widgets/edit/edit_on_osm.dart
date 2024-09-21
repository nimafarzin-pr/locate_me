import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/common_features/map/views/osm_map_view.dart';

import '../../../../add/provider/add_screen_provider.dart';
import '../../../model/place_item_model.dart';
import '../../../provider/home_screen_provider.dart';

import 'dialog/edit_form.dart';

class EditOnOsm extends ConsumerStatefulWidget {
  const EditOnOsm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditOnOsmState();
}

class _EditOnOsmState extends ConsumerState<EditOnOsm>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  late LatLong latLong;

  @override
  Widget build(BuildContext context) {
    return OsmMapView(
      mapController: _mapController,
      // onPositionChanged: (position, hasGesture) {
      //   latLong = LatLong(
      //       latitude: position.center.latitude,
      //       longitude: position.center.longitude);
      // },
      myLocationOnTab: () async {
        final currentLocation = await ref
            .read(addLocationNotifierProvider.notifier)
            .currentLocation;
        await ref
            .read(addLocationNotifierProvider.notifier)
            .animateToMyLocationOnOsm(
                targetLatLng: currentLocation,
                destinationZoom: 20,
                mapController: _mapController,
                vsync: this);
      },
      onUpdateLocation: (LatLng? currentPositions) async {
        await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (modalContext) {
            return EditLocationFormView<PlaceItemModel>(
              onAccept: (PlaceItemModel location) async {
                await ref
                    .read(addLocationNotifierProvider.notifier)
                    .addLocationItem(location);
              },
              editItem: ref.watch(selectedEditStateProviderForEditView),
            );
          },
        );
      },
    );
  }
}
