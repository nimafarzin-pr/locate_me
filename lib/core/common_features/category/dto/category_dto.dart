// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final String translationKey;
  final String icon;
  final Color color;

  CategoryItem({
    required this.name,
    required this.translationKey,
    required this.icon,
    this.color = Colors.white,
  });
}
