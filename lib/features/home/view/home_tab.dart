import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/category/constant/category.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/category_item.dart';
import 'package:locate_me/core/widget/custom_segmented_button.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/custom_textfeild.dart';
import 'package:locate_me/core/widget/empty_box.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/provider/category_filter_provider.dart';
import 'package:locate_me/features/home/provider/filter_provider.dart';
import 'package:locate_me/features/home/provider/home_view_mode_provider.dart';
import 'package:locate_me/features/home/provider/search_input_provider.dart';
import 'package:locate_me/features/home/view/widgets/list_on_map/osm_view/osm_view.dart';
import 'package:locate_me/features/home/view/widgets/normal_list/paging_list.dart';
import 'package:locate_me/features/home/view_model/pagination_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../core/common_features/category/enums/category.dart';
import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../core/widget/custom_switch.dart';
import '../../../core/widget/dialogs/status_widget.dart';
import '../provider/favorite_filter_provider.dart';
import '../provider/location_provider.dart';
import 'widgets/list_on_map/google_view/google_view.dart';
import 'widgets/normal_list/default_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int categoryIndex = 0;

  HomeViewMode homeListShowMode = HomeViewMode.list;

  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final locations = ref.watch(locationProvider);
        return locations.when(
          data: (_) {
            final data = ref.watch(filteredItemsProvider);
            final itemViewState = ref.watch(favoriteFilterProvider);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomTextField(
                        suffixIcon: const Icon(Icons.manage_search_sharp),
                        onChanged: (value) {
                          ref.read(searchInputProvider.notifier).state = value;
                        },
                        hintText: LocaleKeys.search.tr(),
                        controller: _searchController,
                      ),
                      Container(
                        height: context.screenWidth * 0.18,
                        alignment: Alignment.bottomCenter,
                        // color: Colors.blue,
                        child: Center(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final item = category[index];
                              final selectedCategory =
                                  ref.watch(categoryFilterProvider).name;

                              return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CategoryBox(
                                    isSelected: selectedCategory ==
                                        item.name.toLowerCase(),
                                    item: item,
                                    onTap: () {
                                      final CategoryEnums newCategory =
                                          CategoryEnums.values.firstWhere(
                                        (e) =>
                                            e.name.toLowerCase() ==
                                            item.name.toLowerCase(),
                                        orElse: () => CategoryEnums.all,
                                      );

                                      ref
                                          .read(categoryFilterProvider.notifier)
                                          .updateCategory(newCategory);
                                    },
                                  ));
                            },
                            itemCount: category.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSegmentedButton(
                              onSelectionChanged: (state) {
                                ref
                                    .read(homeViewModeProvider.notifier)
                                    .updateViewMode(state.first);
                              },
                              homeViewMode: ref.watch(homeViewModeProvider),
                            ),
                            Expanded(child: Container()),
                            CustomSwitch(
                              labelOne: LocaleKeys.allItems.tr(),
                              labelTwo: LocaleKeys.favorites.tr(),
                              onTapOne: () => ref
                                  .read(favoriteFilterProvider.notifier)
                                  .updateFavoriteView(ItemViewState.all),
                              onTapTwo: () => ref
                                  .read(favoriteFilterProvider.notifier)
                                  .updateFavoriteView(ItemViewState.favorites),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: data.isEmpty
                            ? const EmptyBox()
                            : ref.watch(homeViewModeProvider) ==
                                    HomeViewMode.list
                                // ? const CustomScrollView(
                                //     slivers: [NormalListView()])
                                ? const DefaultList()
                                : ref
                                    .watch(mapSettingLayerNotifierProvider)
                                    .when(
                                    data: (value) {
                                      return switch (value) {
                                        MapLayer.google =>
                                          GoogleView(places: data),
                                        MapLayer.osm => OsmView(places: data),
                                      };
                                    },
                                    error: (error, stackTrace) {
                                      return StatusWidget(
                                        title: LocaleKeys.error.tr(),
                                        content: "$error",
                                        iconColor:
                                            Theme.of(context).colorScheme.error,
                                      );
                                    },
                                    loading: () {
                                      return MyLoading(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary);
                                    },
                                  )),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return StatusWidget(
              title: LocaleKeys.error.tr(),
              content: "$error",
              iconColor: Theme.of(context).colorScheme.error,
            );
          },
          loading: () {
            return MyLoading(color: Theme.of(context).colorScheme.primary);
          },
        );
      },
    );
  }
}
