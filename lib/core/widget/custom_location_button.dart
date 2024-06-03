import 'package:flutter/material.dart';

class CustomLocationButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomLocationButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
      child: Icon(Icons.my_location,
          color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
