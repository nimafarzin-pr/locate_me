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
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        size: 30,
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color:
            isFavorite ? Theme.of(context).colorScheme.tertiary : Colors.grey,
      ),
    );
  }
}
