import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/features/home/view/widgets/location_item.dart';

import '../../../../provider/home_screen_provider.dart';

class DefaultList extends HookConsumerWidget {
  const DefaultList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredItemsProvider);
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: items.length,
                    (context, index) {
                  final item = items[index];
                  return FadeInScaleAnimation(
                      key: Key(item.id.toString()),
                      duration: const Duration(milliseconds: 600),
                      child: LocationItem(item: item, index: index));
                }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
