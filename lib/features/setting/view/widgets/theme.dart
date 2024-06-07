import 'package:flutter/material.dart';

import '../../../../core/widget/custom_text.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText.bodyLarge('Theme Settings')),
      body: Center(child: CustomText.bodyLarge('Theme Settings')),
    );
  }
}
