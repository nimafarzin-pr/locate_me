import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:locate_me/core/widget/animation/color_animation.dart';
import 'package:locate_me/core/widget/custom_text.dart';

class CustomSwitch extends StatelessWidget {
  final String labelOne;
  final String labelTwo;
  final Function() onTapOne;
  final Function() onTapTwo;
  final bool isActiveOne;
  final bool isActiveTwo;
  final IconData? iconOne;
  final IconData? iconTwo;

  const CustomSwitch({
    super.key,
    required this.labelOne,
    required this.labelTwo,
    required this.onTapOne,
    required this.onTapTwo,
    required this.isActiveOne,
    required this.isActiveTwo,
    this.iconOne,
    this.iconTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.transparent),
        // color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchButton(
              context: context,
              label: labelOne,
              isActive: isActiveOne,
              onTap: onTapOne,
              icon: iconOne,
            ),
            _buildSwitchButton(
              context: context,
              label: labelTwo,
              isActive: isActiveTwo,
              onTap: onTapTwo,
              icon: iconTwo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchButton({
    required BuildContext context,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return SwitchItem(
      label: label,
      isActive: isActive,
      onTap: onTap,
      icon: icon,
    );
  }
}

class SwitchItem extends HookWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final IconData? icon;

  const SwitchItem({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColorAnimationWidget(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        trigger: isActive,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: isActive
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                    ],
                  )
                : const SizedBox(),
            CustomText.bodySmall(
              label,
              customStyle: TextStyle(
                color: isActive
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
