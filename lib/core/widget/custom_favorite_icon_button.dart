// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomFavoriteIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;
  final double? iconSize;

  const CustomFavoriteIconButton({
    super.key,
    required this.isFavorite,
    this.onPressed,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        size: iconSize,
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
