import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/extension/theme_extension.dart';
import 'package:locate_me/core/widget/category_item.dart';
import 'package:locate_me/core/widget/custom_textfeild.dart';
import 'package:locate_me/core/widget/empty_box.dart';
import 'package:locate_me/core/widget/loading.dart';

import 'package:locate_me/features/home/view/widgets/list_of_locations/list_on_map/osm_view/osm_view.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../core/widget/ads_widget.dart';
import '../../../core/widget/custom_switch.dart';
import '../../../core/widget/dialogs/diolog_wrapper.dart';
import '../../../core/widget/dialogs/status_widget.dart';
import '../../setting/provider/category_notifier_provider.dart';
import '../provider/home_screen_provider.dart';
import 'widgets/list_of_locations/list_on_map/google_view/google_view.dart';
import 'widgets/list_of_locations/normal_list/default_list.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab>
    with AutomaticKeepAliveClientMixin {
  int categoryIndex = 0;

  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BackButtonListener(
      onBackButtonPressed: () async {
        showDialog(
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                Navigator.pop(context);
                return true;
              },
              child: SizedBox(
                height: context.screenWidth / 2,
                child: Center(
                  child: DialogWrapper(
                    child: StatusWidget(
                      onConfirm: () {
                        exit(0);
                      },
                      title: LocaleKeys.warning.tr(),
                      content: LocaleKeys.exist_dialog_message.tr(),
                      iconColor: Theme.of(context).colorScheme.warning,
                    ),
                  ),
                ),
              ),
            );
          },
        );

        return true;
      },
      child: Consumer(
        builder: (context, ref, child) {
          final locations = ref.watch(savedPlacesProvider);
          return locations.when(
            data: (_) {
              // final itemViewState = ref.watch(favoriteFilterProvider);
              final categoryProvider = ref.watch(categoryNotifierProvider);

              return categoryProvider.when(
                data: (category) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CustomTextField(
                                  suffixIcon:
                                      const Icon(Icons.manage_search_sharp),
                                  onChanged: (value) {
                                    ref
                                        .read(searchInputProvider.notifier)
                                        .setSearchQuery(value);
                                  },
                                  hintText: LocaleKeys.search.tr(),
                                  controller: _searchController,
                                ),
                                Container(
                                  height: context.screenWidth * 0.18,
                                  alignment: Alignment.bottomCenter,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        category.isEmpty
                                            ? Container()
                                            : Expanded(
                                                child: ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item =
                                                        category[index];
                                                    final selectedCategory = ref
                                                        .watch(
                                                            categoryFilterProvider)
                                                        .name;

                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 4.0,
                                                                horizontal: 2),
                                                        child: CategoryBox(
                                                          isSelected:
                                                              selectedCategory ==
                                                                  item.name
                                                                      .toLowerCase(),
                                                          item: item,
                                                          onTap: () {
                                                            final CategoryModel
                                                                newCategory =
                                                                category
                                                                    .firstWhere(
                                                              (e) =>
                                                                  e.name
                                                                      .toLowerCase() ==
                                                                  item.name
                                                                      .toLowerCase(),
                                                            );

                                                            ref
                                                                .read(categoryFilterProvider
                                                                    .notifier)
                                                                .updateCategory(
                                                                    newCategory);
                                                          },
                                                        ));
                                                  },
                                                  itemCount: category.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomSwitch(
                                        isActiveOne:
                                            ref.watch(homeViewModeProvider) ==
                                                HomeViewMode.list,
                                        isActiveTwo:
                                            ref.watch(homeViewModeProvider) ==
                                                HomeViewMode.map,
                                        iconOne: FontAwesomeIcons.listUl,
                                        iconTwo: Icons.map_rounded,
                                        labelOne: LocaleKeys.list.tr(),
                                        labelTwo: LocaleKeys.map.tr(),
                                        onTapOne: () => ref
                                            .read(homeViewModeProvider.notifier)
                                            .updateViewMode(HomeViewMode.list),
                                        onTapTwo: () => ref
                                            .read(homeViewModeProvider.notifier)
                                            .updateViewMode(HomeViewMode.map),
                                      ),
                                      Expanded(child: Container()),
                                      CustomSwitch(
                                        iconOne: Icons.all_inclusive_rounded,
                                        iconTwo: Icons.favorite_rounded,
                                        isActiveOne:
                                            ref.watch(favoriteFilterProvider) ==
                                                ItemViewState.all,
                                        isActiveTwo:
                                            ref.watch(favoriteFilterProvider) ==
                                                ItemViewState.favorites,
                                        labelOne: LocaleKeys.allItems.tr(),
                                        labelTwo: LocaleKeys.favorites.tr(),
                                        onTapOne: () => ref
                                            .read(
                                                favoriteFilterProvider.notifier)
                                            .updateFavoriteView(
                                                ItemViewState.all),
                                        onTapTwo: () => ref
                                            .read(
                                                favoriteFilterProvider.notifier)
                                            .updateFavoriteView(
                                                ItemViewState.favorites),
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
                                  child: ref
                                          .watch(filteredItemsProvider)
                                          .isEmpty
                                      ? const EmptyBox()
                                      : ref.watch(homeViewModeProvider) ==
                                              HomeViewMode.list
                                          ? const DefaultList()
                                          : ref
                                              .watch(
                                                  mapSettingLayerNotifierProvider)
                                              .when(
                                              data: (value) {
                                                return switch (value) {
                                                  MapLayer.google =>
                                                    const GoogleView(),
                                                  MapLayer.osm =>
                                                    const OsmView(),
                                                };
                                              },
                                              error: (error, stackTrace) {
                                                return StatusWidget(
                                                  title: LocaleKeys.error.tr(),
                                                  content: "$error",
                                                  iconColor: Theme.of(context)
                                                      .colorScheme
                                                      .error,
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
                      ),
                      const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AdsWidget(),
                      )
                    ],
                  );
                },
                error: (error, stackTrace) {
                  log('$stackTrace');

                  return StatusWidget(
                    title: LocaleKeys.error.tr(),
                    content: "$error",
                    iconColor: Theme.of(context).colorScheme.error,
                  );
                },
                loading: () {
                  return Center(
                      child: MyLoading(
                          color: Theme.of(context).colorScheme.primary));
                },
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
              return Center(
                  child:
                      MyLoading(color: Theme.of(context).colorScheme.primary));
            },
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
