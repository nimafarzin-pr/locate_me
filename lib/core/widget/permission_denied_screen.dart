import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/widget/dialogs/permission.dart';

class PermissionDeniedScreen extends StatelessWidget {
  final Function onRecall;
  const PermissionDeniedScreen({
    super.key,
    required this.onRecall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Column(
          children: [
            const Text(
                'Please enable location and grant location permission to continue!'),
            TextButton(
                onPressed: () async {
                  final result = await Geolocator.checkPermission();
                  if (result == LocationPermission.always ||
                      result == LocationPermission.whileInUse) {
                    onRecall();
                  } else {
                    await showPermissionSettingsDialog(context);
                  }
                },
                child: const Text("Accept"))
          ],
        )),
      ],
    );
  }
}
