// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';
import 'package:locate_me/features/home/view/widgets/edit/edit_on_google_map.dart';
import 'package:locate_me/features/home/view/widgets/edit/edit_on_osm.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/common_features/map/core/google_map/provider/permission_provider.dart';
import '../../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../../core/navigation/router/router.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/widget/ads_widget.dart';
import '../../../../../core/widget/dialogs/permission.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../add/provider/add_screen_provider.dart';
import '../../../model/place_item_model.dart';
import 'dialog/edit_form.dart';

class EditView extends ConsumerStatefulWidget {
  const EditView({
    super.key,
  });

  @override
  ConsumerState<EditView> createState() => _EditViewState();
}

class _EditViewState extends ConsumerState<EditView> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        final edit = ref.watch(selectedEditStateProviderForEditView);
        if (edit != null &&
            (router.routerDelegate.currentConfiguration.fullPath
                .contains(Routes.editLocationRouteForNavigator))) {
          await showDialog(
            barrierDismissible: true,
            useRootNavigator: false,
            context: context,
            builder: (modalContext) {
              return BackButtonListener(
                onBackButtonPressed: () async {
                  if (mounted) {
                    Navigator.pop(modalContext);
                  }
                  return true;
                },
                child: EditLocationFormView<PlaceItemModel>(
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
                                },
                                showCancelButton: false,
                                iconColor: Colors.green,
                                title: LocaleKeys.location_saved_successfully
                                    .tr()),
                          ),
                        );
                      },
                    );
                  },
                  editItem: edit,
                ),
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
    return BackButtonListener(
      onBackButtonPressed: () async {
        context.pop();
        return true;
      },
      child: Builder(builder: (context) {
        return switch (permission) {
          AsyncValue(:final SystemAndPermissionStatus error?) => Builder(
              builder: (_) {
                if (error == SystemAndPermissionStatus.systemLocationDisable) {
                  return errorWidget(
                    buttonTitle: LocaleKeys.enable.tr(),
                    context: context,
                    onConfirm: () async {
                      final status =
                          await Geolocator.isLocationServiceEnabled();
                      if (!status) {
                        await showLocationServiceDialog(context);
                      }
                    },
                  );
                } else if (error ==
                        SystemAndPermissionStatus.permissionDenied ||
                    error ==
                        SystemAndPermissionStatus.permissionDeniedForEver) {
                  return errorWidget(
                    buttonTitle: LocaleKeys.refresh_accept.tr(),
                    context: context,
                    onConfirm: () async {
                      final permissionStatus =
                          await Geolocator.checkPermission();
                      if (permissionStatus ==
                              LocationPermission.deniedForever ||
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
                              MapLayer.google => const EditOnGoogleMap(),
                              MapLayer.osm => const EditOnOsm(),
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
      }),
    );
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
