import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:locate_me/core/navigation/router/router.dart';

import '../../../../../core/common_features/map/views/osm_map_view.dart';

import '../../../../../core/widget/custom_marker_add_info_box.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../generated/locale_keys.g.dart';
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
                showDialog(
                  context: context,
                  builder: (successModal) {
                    return Center(
                      child: SizedBox(
                        height: 300,
                        child: StatusWidget(
                            status: ActionStatus.success,
                            onConfirm: () async {
                              Navigator.pop(successModal);
                              Navigator.pop(context);
                              ref
                                  .read(selectedEditStateProviderForEditView
                                      .notifier)
                                  .clearEditItem();
                            },
                            showCancelButton: false,
                            iconColor: Colors.green,
                            title:
                                LocaleKeys.location_updated_successfully.tr()),
                      ),
                    );
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
