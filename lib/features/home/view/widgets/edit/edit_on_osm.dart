import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/common_features/map/views/osm_map_view.dart';

import '../../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../../core/widget/dialogs/success_modal.dart';
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

  @override
  Widget build(BuildContext context) {
    final editItem = ref.watch(selectedEditStateProviderForEditView);

    return OsmMapView(
      onBack: () => context.pop(),
      markers: [
        Marker(
          width: 200.0,
          height: 200,
          alignment: Alignment.center,
          point: LatLng(editItem!.latlng.latitude, editItem.latlng.longitude),
          child: CustomMarkerAddInfoBox(
              position:
                  LatLng(editItem.latlng.latitude, editItem.latlng.longitude)),
          rotate: true,
        )
      ],
      mapController: _mapController,
      onPositionChanged: (position, hasGesture) {
        if (!mounted) return;
        ref.read(selectedEditStateProviderForEditView.notifier).setEditItem(
            editItem.copyWith(
                latlng: LatLong(
                    latitude: position.center.latitude,
                    longitude: position.center.longitude)));
      },
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
                    .updateLocationItem(location);
                Navigator.pop(modalContext);

                await showSuccessModal(
                  context,
                  onConfirm: () async {
                    ref
                        .read(selectedEditStateProviderForEditView.notifier)
                        .clearEditItem();
                    Navigator.pop(context);
                  },
                );
              },
              editItem: ref.watch(selectedEditStateProviderForEditView),
            );
          },
        );
      },
    );
  }
}
