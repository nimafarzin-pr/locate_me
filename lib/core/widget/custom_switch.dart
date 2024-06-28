// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';

import '../common_features/map/core/enums/map_enum.dart';
import 'custom_text.dart';

class CustomSwitch extends ConsumerWidget {
  final String labelOne;
  final String labelTwo;
  final Function() onTapOne;
  final Function() onTapTwo;

  const CustomSwitch({
    super.key,
    required this.labelOne,
    required this.labelTwo,
    required this.onTapOne,
    required this.onTapTwo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemViewState = ref.watch(favoriteFilterProvider);

    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSwitchButton(
              context: context,
              label: labelOne,
              isActive: itemViewState == ItemViewState.all,
              onTap: onTapOne),
          _buildSwitchButton(
              context: context,
              label: labelTwo,
              isActive: itemViewState == ItemViewState.favorites,
              onTap: onTapTwo),
        ],
      ),
    );
  }

  Widget _buildSwitchButton({
    required BuildContext context,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: CustomText.bodySmall(
          label,
          customStyle: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
