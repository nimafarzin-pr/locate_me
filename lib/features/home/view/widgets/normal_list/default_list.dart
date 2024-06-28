import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locate_me/core/widget/fade_in_scale_animation.dart';
import 'package:locate_me/features/home/provider/filter_provider.dart';
import 'package:locate_me/features/home/view/widgets/location_item.dart';

class DefaultList extends HookConsumerWidget {
  const DefaultList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredItemsProvider);
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemBuilder: (context, index) {
            final item = items[index];
            return FadeInScaleAnimation(
                child: LocationItem(item: item, index: index));
          },
          itemCount: items.length,
        )
      ],
    );
  }
}
