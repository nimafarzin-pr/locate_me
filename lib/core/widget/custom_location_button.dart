// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomLocationButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  const CustomLocationButton({
    super.key,
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      splashColor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
      child: child ??
          Icon(Icons.my_location,
              color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
