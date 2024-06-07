import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_text.dart';

class WarningWidget extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const WarningWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 20),
            CustomText.bodyLarge(
              title,
              customStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            CustomText.bodyLarge(
              content,
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  )),
                  onPressed: () {
                    context.pop();
                  },
                  child: CustomText.bodyLarge(
                    'Cancel',
                    customStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onConfirm();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: CustomText.bodyLarge(
                    'Ok',
                    customStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
