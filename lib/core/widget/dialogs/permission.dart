import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/custom_text.dart';

Future<void> showLocationServiceDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: CustomText.bodyLarge('Location Services Disabled'),
      content: CustomText.bodyLarge(
        'This app needs location services to function properly. '
        'Would you like to enable them?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: CustomText.bodyLarge('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await AppSettings.openAppSettings(type: AppSettingsType.location);
            Navigator.pop(context);
          },
          child: CustomText.bodyLarge('Enable'),
        ),
      ],
    ),
  );
}

Future<void> showPermissionSettingsDialog(BuildContext context,
    {required void Function()? onAcceptPressed}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: CustomText.bodyLarge('Location Permission Denied'),
      content: CustomText.bodyLarge(
        'This app needs location permission to function properly. '
        'You can grant permission in app settings.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: CustomText.bodyLarge('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (onAcceptPressed == null) return;
            onAcceptPressed();
          },
          child: CustomText.bodyLarge('Settings'),
        ),
      ],
    ),
  );
}
