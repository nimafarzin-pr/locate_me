import 'package:flutter/material.dart';

import '../../../../core/widget/custom_text.dart';

class ExportImportDataPage extends StatelessWidget {
  const ExportImportDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText.bodyLarge('Export/Import Data')),
      body: Center(child: CustomText.bodyLarge('Export/Import Data')),
    );
  }
}
