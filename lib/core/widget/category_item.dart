import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryBox({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: MediaQuery.sizeOf(context).width * 0.16,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              item.icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onSurface,
            )
                //      FaIcon(
                //   item.icon.icon,
                //   color: isSelected
                //       ? Theme.of(context).colorScheme.onSecondary
                //       : Theme.of(context).colorScheme.onSurface,
                // ),
                ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                item.name,
                maxLines: 1,
                style: TextStyle(
                    // fontSize: 12,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.onSurface),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
