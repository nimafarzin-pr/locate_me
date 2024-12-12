// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/common_features/map/view_model/my_location_button_notifier.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../../../features/home/provider/home_screen_provider.dart';
import '../../../../../navigation/router/router.dart';
import '../../../../../navigation/routes.dart';
import '../custom_location_button.dart';
import '../dialog/custom_map_options.dart';

class GeneralMapWrapper extends ConsumerWidget {
  final Widget map;
  final Function()? mapSettingOnTab;
  final bool isEditMode;
  final Future Function()? onGoToMyLocation;
  final Function()? onBack;
  final Function()? onAddOrEditLocation;

  const GeneralMapWrapper({
    super.key,
    required this.map,
    this.mapSettingOnTab,
    this.isEditMode = false,
    this.onGoToMyLocation,
    this.onBack,
    this.onAddOrEditLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(myLocationButtonNotifierProvider);

    return Stack(
      children: [
        map,
        onGoToMyLocation != null
            ? Positioned(
                bottom: 70,
                right: 20,
                child: SizedBox(
                    width: context.screenWidth / 8,
                    height: context.screenWidth / 8,
                    child: Center(
                        child: isLoading
                            ? CustomLocationButton(
                                onPressed: () {},
                                child: MyLoading(
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16,
                                ))
                            : CustomLocationButton(onPressed: () async {
                                if (onGoToMyLocation == null) return;
                                if (isLoading) return;
                                ref
                                    .read(myLocationButtonNotifierProvider
                                        .notifier)
                                    .updateLoadingState(true);
                                try {
                                  await onGoToMyLocation!();
                                  ref
                                      .read(myLocationButtonNotifierProvider
                                          .notifier)
                                      .updateLoadingState(false);
                                } catch (e) {
                                  ref
                                      .read(myLocationButtonNotifierProvider
                                          .notifier)
                                      .updateLoadingState(false);
                                } finally {
                                  ref
                                      .read(myLocationButtonNotifierProvider
                                          .notifier)
                                      .updateLoadingState(false);
                                }
                              }))),
              )
            : const SizedBox(),
        Positioned(
          top: 20,
          right: 20,
          child: SizedBox(
            width: context.screenWidth / 8,
            height: context.screenWidth / 8,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              onPressed: () async {
                await showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return CustomMapOptionsDialog(
                      onOptionSelected: (p0) {},
                    );
                  },
                );
                if (mapSettingOnTab != null) {
                  mapSettingOnTab!();
                }
              },
              child: FaIcon(
                FontAwesomeIcons.sliders,
                size: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        onBack != null
            ? Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: context.screenWidth / 8,
                  height: context.screenWidth / 8,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: () {
                      if (onBack != null) {
                        onBack!();
                      }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        onAddOrEditLocation != null
            ? Positioned(
                bottom: 140,
                right: 20,
                child: SizedBox(
                  width: context.screenWidth / 8,
                  height: context.screenWidth / 8,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: onAddOrEditLocation ?? () {},
                    child: FaIcon(
                      size: 20,
                      ref.watch(selectedEditStateProviderForEditView) == null ||
                              router.routerDelegate.currentConfiguration.uri
                                      .toString() ==
                                  '/${Routes.addLocationRouteForNavigator}'
                          ? FontAwesomeIcons.plus
                          : FontAwesomeIcons.penToSquare,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
