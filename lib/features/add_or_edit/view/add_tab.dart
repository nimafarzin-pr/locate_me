import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/core/navigation/router/router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/loading.dart';

import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../core/common_features/map/core/google_map/provider/permission_provider.dart';
import '../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../core/widget/dialogs/permission.dart';
import '../../../core/widget/dialogs/status_widget.dart';
import '../../home/model/place_item_model.dart';
import '../provider/osm_location_provider.dart';
import 'widgets/dialog/add_or_update_location_dialog.dart';
import 'package:app_settings/app_settings.dart';

import 'widgets/google_map_view.dart';
import 'widgets/osm_map_view.dart';

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
        final edit = ref.watch(selectedEditStateProviderForEditAndView);
        if (edit != null &&
            (router.routerDelegate.currentConfiguration.fullPath
                .contains(Routes.editLocation))) {
          await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AddOrUpdateLocationDialogView<PlaceItemModel>(
                editItem: edit,
                latLng: LatLng(edit.latlng.latitude, edit.latlng.longitude),
                onAccept: (location) async {
                  await ref
                      .read(currentPositionProvider.notifier)
                      .updateLocationItem(location);
                  ref
                      .read(selectedEditStateProviderForEditAndView.notifier)
                      .state = null;
                  ref.invalidate(selectedEditStateProviderForEditAndView);
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
              return errorWidget(
                buttonTitle: LocaleKeys.enable.tr(),
                context: context,
                onConfirm: () async {
                  final status = await Geolocator.isLocationServiceEnabled();
                  if (!status) {
                    await showLocationServiceDialog(context);
                  }
                },
              );
            } else if (error == SystemAndPermissionStatus.permissionDenied ||
                error == SystemAndPermissionStatus.permissionDeniedForEver) {
              return errorWidget(
                buttonTitle: LocaleKeys.refresh_accept.tr(),
                context: context,
                onConfirm: () async {
                  final permissionStatus = await Geolocator.checkPermission();
                  if (permissionStatus == LocationPermission.deniedForever ||
                      permissionStatus == LocationPermission.denied) {
                    await showPermissionSettingsDialog(context,
                        onAcceptPressed: () async {
                      await AppSettings.openAppSettings(
                          type: AppSettingsType.location);
                    });
                  } else {
                    ref.refresh(permissionProvider);
                  }
                },
              );
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
        ),
      _ => const MyLoading(),
    };
  }

  Center errorWidget({
    required Future<void> Function()? onConfirm,
    required BuildContext context,
    required String buttonTitle,
  }) {
    return Center(
      child: IntrinsicHeight(
        child: Center(
          child: StatusWidget(
              onConfirm: onConfirm,
              acceptButtonTitle: buttonTitle,
              showCancelButton: false,
              title: LocaleKeys.error.tr(),
              content: LocaleKeys.disabled_location_and_permission_error.tr(),
              iconColor: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
