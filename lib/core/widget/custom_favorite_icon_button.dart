import 'package:flutter/material.dart';

class CustomFavoriteIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const CustomFavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
