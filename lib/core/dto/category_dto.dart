import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final String icon;
  final Color color;

  CategoryItem({
    required this.name,
    required this.icon,
    this.color = Colors.white,
  });
}
