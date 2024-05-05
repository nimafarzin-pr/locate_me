import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> showLocationServiceDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Location Services Disabled'),
      content: const Text(
        'This app needs location services to function properly. '
        'Would you like to enable them?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await AppSettings.openAppSettings(type: AppSettingsType.location);
            Navigator.pop(context);
          },
          child: const Text('Enable'),
        ),
      ],
    ),
  );
}

Future<void> showPermissionSettingsDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Location Permission Denied'),
      content: const Text(
        'This app needs location permission to function properly. '
        'You can grant permission in app settings.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final status = await Geolocator.requestPermission();
            if (status == LocationPermission.deniedForever) {
              await AppSettings.openAppSettings(type: AppSettingsType.location);
              Navigator.pop(context);
            }
          },
          child: const Text('Settings'),
        ),
      ],
    ),
  );
}
