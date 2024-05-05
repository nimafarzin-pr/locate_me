import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_me/core/widget/dialogs/permission.dart';

class DisabledLocationServiceView extends StatelessWidget {
  final Function onRecall;
  const DisabledLocationServiceView({
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
                  final status = await Geolocator.isLocationServiceEnabled();
                  if (!status) {
                    await showLocationServiceDialog(context);
                  } else {
                    onRecall();
                  }
                },
                child: const Text("Accept / Refresh"))
          ],
        )),
      ],
    );
  }
}
