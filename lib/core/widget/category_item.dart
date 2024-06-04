import 'package:flutter/material.dart';
import 'package:locate_me/core/extension/screen_size.dart';

import '../dto/category_dto.dart';

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        // color: isSelected
        //     ? Theme.of(context).colorScheme.primary
        //     : Theme.of(context).colorScheme.surface,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 1,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            width: context.screenWidth * 0.16,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
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
        ),
      ),
    );
  }
}
