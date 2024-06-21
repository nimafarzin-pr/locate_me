import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
