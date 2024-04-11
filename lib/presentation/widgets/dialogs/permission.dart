import 'package:flutter/material.dart';

void showPermissionDialog(
    {required BuildContext context, required String text, Function? onPress}) {
  showDialog(
    barrierColor: Colors.white.withOpacity(0.8),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              text,
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );
    },
  );
}
