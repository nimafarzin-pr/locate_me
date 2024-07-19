import 'package:flutter/material.dart';

class SettingItemDto {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  SettingItemDto({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
