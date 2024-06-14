// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'custom_text.dart';

class WarningWidget extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final bool showCancelButton;

  const WarningWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.showCancelButton = true,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showCancelButton
                    ? Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: CustomText.bodyLarge(
                              'Cancel',
                              customStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
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
