import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';

import '../helper/map/enums/map_enum.dart';
import 'custom_text.dart';

class CustomSwitch extends ConsumerWidget {
  const CustomSwitch({super.key});

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
            label: 'All Items',
            isActive: itemViewState == ItemViewState.all,
            onTap: () => ref
                .read(favoriteFilterProvider.notifier)
                .updateFavoriteView(ItemViewState.all),
          ),
          _buildSwitchButton(
            context: context,
            label: 'Favorites',
            isActive: itemViewState == ItemViewState.favorites,
            onTap: () => ref
                .read(favoriteFilterProvider.notifier)
                .updateFavoriteView(ItemViewState.favorites),
          ),
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
        child: CustomText.bodyLarge(
          label,
          customStyle: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
