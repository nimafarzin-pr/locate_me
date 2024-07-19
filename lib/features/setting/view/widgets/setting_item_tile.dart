import 'package:flutter/material.dart';
import 'package:locate_me/core/sizing/app_sizing.dart';

import '../../../../core/widget/custom_text.dart';

class SettingItemTile extends StatelessWidget {
  const SettingItemTile({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelect,
  });

  final BuildContext context;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelect
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.mediumBorderRadius))),
      child: ListTile(
        leading: Icon(icon,
            color: isSelect
                ? Theme.of(context).colorScheme.onTertiary
                : Theme.of(context).colorScheme.onSurface),
        title: CustomText.bodyLarge(
          title,
          customStyle: TextStyle(
              color: isSelect
                  ? Theme.of(context).colorScheme.onTertiary
                  : Theme.of(context).colorScheme.onSurface),
        ),
        onTap: onTap,
      ),
    );
  }
}
