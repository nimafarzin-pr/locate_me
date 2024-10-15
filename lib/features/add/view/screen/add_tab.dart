import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/add/view/widgets/osm.dart';

import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/common_features/map/core/google_map/provider/permission_provider.dart';
import '../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../core/widget/ads_widget.dart';
import '../../../../core/widget/dialogs/permission.dart';
import '../../../../core/widget/dialogs/status_widget.dart';

import 'package:app_settings/app_settings.dart';

import '../../../../core/widget/error_widget_box.dart';
import '../widgets/google.dart';

class AddTab extends ConsumerStatefulWidget {
  const AddTab({super.key});

  @override
  ConsumerState<AddTab> createState() => _AddTabState();
}

class _AddTabState extends ConsumerState<AddTab> {
  @override
  Widget build(BuildContext context) {
    final permission = ref.watch(permissionProvider);
    return switch (permission) {
      AsyncValue(:final SystemAndPermissionStatus error?) => Builder(
          builder: (_) {
            if (error == SystemAndPermissionStatus.systemLocationDisable) {
              return ErrorWidgetBox(
                content: LocaleKeys.disabled_location_and_permission_error.tr(),
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
              return ErrorWidgetBox(
                content: LocaleKeys.disabled_location_and_permission_error.tr(),
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
                return Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        return switch (data) {
                          MapLayer.google => const GoogleView(),
                          MapLayer.osm => const OsmView(),
                        };
                      },
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AdsWidget(),
                    )
                  ],
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
          },
        ),
      _ => const MyLoading(),
    };
  }
}
