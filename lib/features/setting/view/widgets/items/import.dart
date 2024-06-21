import 'package:flutter/material.dart';

import '../../../../../core/widget/custom_text.dart';

void showImportModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText.headlineMedium('Export/Import Data'),
        content: const SizedBox(
          width: 400,
          height: 200,
          child: Column(
            children: [
              // Add your export/import options here
            ],
          ),
        ),
      );
    },
  );
}
