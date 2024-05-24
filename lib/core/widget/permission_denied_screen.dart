import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/widget/dialogs/permission.dart';

import '../helper/google_map/provider/permission_provider.dart';

class PermissionDeniedScreen extends StatelessWidget {
  const PermissionDeniedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(permissionProvider);
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
                      final permissionStatus =
                          await Geolocator.checkPermission();
                      if (permissionStatus ==
                              LocationPermission.deniedForever ||
                          permissionStatus == LocationPermission.denied) {
                        await showPermissionSettingsDialog(context,
                            onAcceptPressed: () async {
                          log('??????  $permissionStatus');
                          await AppSettings.openAppSettings(
                              type: AppSettingsType.location);
                        });
                      } else {
                        ref.refresh(permissionProvider);
                      }
                    },
                    child: const Text("Accept / Refresh"))
              ],
            )),
          ],
        );
      },
    );
  }
}
