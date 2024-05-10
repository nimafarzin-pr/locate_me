import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationButton extends StatelessWidget {
  final void Function()? onPressed;
  const LocationButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: FaIcon(
            size: 34,
            FontAwesomeIcons.crosshairs,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
