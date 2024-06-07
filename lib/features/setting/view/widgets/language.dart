import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/custom_text.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText.bodyLarge('Language Settings')),
      body: Center(child: CustomText.bodyLarge('Language Settings')),
    );
  }
}
