import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_location_button.dart';

class GeneralMapWrapper extends StatelessWidget {
  final Widget map;
  final Function() settingOnTab;
  final Function() myLocationOnTab;
  final Function() addLocationOnTab;
  const GeneralMapWrapper({
    super.key,
    required this.settingOnTab,
    required this.myLocationOnTab,
    required this.addLocationOnTab,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        map,
        Positioned(
          bottom: 20,
          right: 20,
          child: CustomLocationButton(onPressed: myLocationOnTab),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: settingOnTab,
            child: FaIcon(
              FontAwesomeIcons.sliders,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: addLocationOnTab,
            child: FaIcon(
              FontAwesomeIcons.floppyDisk,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
