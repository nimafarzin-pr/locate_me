import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/widget/dialogs/permission.dart';

import 'custom_text.dart';

class DisabledLocationServiceView extends StatelessWidget {
  const DisabledLocationServiceView({super.key});

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
            CustomText.bodyLarge(
                'Please enable location and grant location permission to continue!'),
            TextButton(
                onPressed: () async {
                  final status = await Geolocator.isLocationServiceEnabled();
                  if (!status) {
                    await showLocationServiceDialog(context);
                  }
                },
                child: CustomText.bodyLarge("Enable"))
          ],
        )),
      ],
    );
  }
}
