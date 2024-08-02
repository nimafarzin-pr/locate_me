// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/widget/general_map_wrapper/my_location_button_notifier.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';

import '../custom_location_button.dart';
import '../dialogs/custom_map_options.dart';

class GeneralMapWrapper extends ConsumerWidget {
  final Widget map;
  final Function()? mapSettingOnTab;
  final bool isEditMode;
  final Future Function()? myLocationOnTab;
  final Function()? onBack;
  final Function()? addOrUpdateLocationOnTab;

  const GeneralMapWrapper({
    super.key,
    required this.map,
    this.mapSettingOnTab,
    this.isEditMode = false,
    this.myLocationOnTab,
    this.onBack,
    this.addOrUpdateLocationOnTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editItem = ref.watch(selectedEditStateProviderForEditAndView);
    final isLoading = ref.watch(myLocationButtonNotifierProvider);

    return Stack(
      children: [
        map,
        myLocationOnTab != null
            ? Positioned(
                bottom: 20,
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
                                if (myLocationOnTab == null) return;
                                if (isLoading) return;
                                ref
                                    .read(myLocationButtonNotifierProvider
                                        .notifier)
                                    .updateLoadingState(true);
                                try {
                                  await myLocationOnTab!();
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
            : Container(),
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
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        isEditMode || onBack != null
            ? Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: context.screenWidth / 8,
                  height: context.screenWidth / 8,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: () {
                      if (editItem != null) {
                        ref
                            .read(selectedEditStateProviderForEditAndView
                                .notifier)
                            .state = null;
                        Navigator.of(context).pop();
                      }
                      if (onBack != null) {
                        onBack!();
                      }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        addOrUpdateLocationOnTab != null
            ? Positioned(
                bottom: 90,
                right: 20,
                child: SizedBox(
                  width: context.screenWidth / 8,
                  height: context.screenWidth / 8,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: addOrUpdateLocationOnTab ?? () {},
                    child: FaIcon(
                      isEditMode
                          ? FontAwesomeIcons.penToSquare
                          : FontAwesomeIcons.plus,
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
