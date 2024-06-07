import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/custom_text.dart';

class MapSettingsPage extends StatelessWidget {
  const MapSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText.bodyLarge('Map Settings')),
      body: Center(child: CustomText.bodyLarge('Map Settings')),
    );
  }
}
