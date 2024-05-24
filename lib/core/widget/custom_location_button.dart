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
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      splashColor: Colors.black.withOpacity(0.4),
      child: const Icon(Icons.my_location, color: Colors.black),
    );
  }
}
