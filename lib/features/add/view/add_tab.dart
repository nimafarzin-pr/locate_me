import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/helper/map/enums/map_enum.dart';
import 'package:locate_me/core/navigation/router/router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/disabled_location_service_view.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/core/widget/permission_denied_screen.dart';
import 'package:locate_me/features/add/view/widgets/google_map_view.dart';
import 'package:locate_me/features/add/view/widgets/osm_map_view.dart';

import '../../../core/helper/google_map/provider/permission_provider.dart';
import '../../../core/helper/map/provider/map_setting_notifier_provider.dart';
import '../../home/model/place_item_model.dart';
import '../../home/provider/edit_item_provider.dart';
import '../provider/osm_location_provider.dart';
import 'widgets/dialog/add_location_dialog.dart';

class AddTab extends ConsumerStatefulWidget {
  const AddTab({super.key});

  @override
  ConsumerState<AddTab> createState() => _AddTabState();
}

class _AddTabState extends ConsumerState<AddTab> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        final edit = ref.read(editItemProvider);
        if (edit != null &&
            !(router.routerDelegate.currentConfiguration.fullPath
                .contains(Routes.add))) {
          await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AddOrUpdateLocationDialogView<PlaceItemModel>(
                latLng: LatLng(edit.latlng.latitude, edit.latlng.longitude),
                onAccept: (location) async {
                  final editItem = ref.read(editItemProvider);
                  final isEditMode = editItem != null;
                  !isEditMode
                      ? await ref
                          .read(osmCurrentPositionProvider.notifier)
                          .addLocationItem(location)
                      : await ref
                          .read(osmCurrentPositionProvider.notifier)
                          .updateLocationItem(location);
                },
              );
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final permission = ref.watch(permissionProvider);
    return switch (permission) {
      AsyncValue(:final SystemAndPermissionStatus error?) => Builder(
          builder: (_) {
            if (error == SystemAndPermissionStatus.systemLocationDisable) {
              return const DisabledLocationServiceView();
            } else if (error == SystemAndPermissionStatus.permissionDenied ||
                error == SystemAndPermissionStatus.permissionDeniedForEver) {
              return const PermissionDeniedScreen();
            } else {
              return const MyLoading();
            }
          },
        ),
      AsyncValue(:final valueOrNull?) => Builder(
          builder: (_) {
            return ref.watch(mapSettingLayerNotifierProvider).when(
              data: (data) {
                return switch (data) {
                  MapLayer.google => const GoogleMapAddView(),
                  MapLayer.osm => const OsmMapView(),
                };
              },
              error: (error, stackTrace) {
                return ErrorWidget(error);
              },
              loading: () {
                return const MyLoading();
              },
            );
          },
        ),
      _ => const MyLoading(),
    };
  }
}
