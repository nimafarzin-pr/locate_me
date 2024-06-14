import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/home/provider/edit_item_provider.dart';
import 'custom_location_button.dart';

class GeneralMapWrapper extends ConsumerWidget {
  final Widget map;
  final Function() settingOnTab;
  final Function()? myLocationOnTab;
  final Function()? addOrUpdateLocationOnTab;

  const GeneralMapWrapper({
    super.key,
    required this.settingOnTab,
    this.myLocationOnTab,
    this.addOrUpdateLocationOnTab,
    required this.map,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        map,
        myLocationOnTab != null
            ? Positioned(
                bottom: 20,
                right: 20,
                child:
                    CustomLocationButton(onPressed: myLocationOnTab ?? () {}),
              )
            : Container(),
        Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surface,
            onPressed: settingOnTab,
            child: FaIcon(
              FontAwesomeIcons.sliders,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        addOrUpdateLocationOnTab != null
            ? Positioned(
                bottom: 90,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  onPressed: addOrUpdateLocationOnTab ?? () {},
                  child: FaIcon(
                    ref.watch(isEditModeProvider)
                        ? FontAwesomeIcons.edit
                        : FontAwesomeIcons.plus,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
