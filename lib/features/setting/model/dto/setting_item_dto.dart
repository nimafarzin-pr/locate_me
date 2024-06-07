import 'package:flutter/material.dart';

class SettingItemDto {
  final String title;
  final IconData icon;
  final Widget page;

  SettingItemDto({
    required this.title,
    required this.icon,
    required this.page,
  });
}
