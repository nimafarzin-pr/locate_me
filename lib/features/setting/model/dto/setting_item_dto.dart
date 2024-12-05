import 'package:flutter/material.dart';

class SettingItemDto {
  final String title;
  final IconData? icon;
  final Widget? customWidget;
  final Function(BuildContext)? onTap;

  SettingItemDto({
    this.customWidget,
    required this.title,
    this.icon,
    this.onTap,
  });
}
