import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locate_me/core/constant/category.dart';
import 'package:locate_me/core/dto/category_dto.dart';
import 'package:locate_me/core/enums/enums.dart';
import 'package:locate_me/core/widget/category_item.dart';
import 'package:locate_me/core/widget/custom_segmented_button.dart';
import 'package:locate_me/core/widget/empty_box.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/provider/category_filter_provider.dart';
import 'package:locate_me/features/home/provider/filter_provider.dart';
import 'package:locate_me/features/home/provider/home_view_mode_provider.dart';
import 'package:locate_me/features/home/view/widgets/list_on_map/osm_view/osm_view.dart';
import 'package:locate_me/features/home/view/widgets/normal_list/normal_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/helper/map/enums/map_enum.dart';
import '../../../core/helper/map/provider/map_setting_notifier_provider.dart';
import '../../../core/widget/custom_switch.dart';
import '../provider/location_provider.dart';
import 'widgets/list_on_map/google_view/google_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int categoryIndex = 0;

  HomeViewMode homeListShowMode = HomeViewMode.list;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final locations = ref.watch(locationProvider);
        return locations.when(
          data: (places) {
            final data = ref.watch(filteredItemsProvider);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          suffixIcon: const Icon(Icons.search),
                          labelText: 'Search...',
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      alignment: Alignment.bottomCenter,
                      // color: Colors.blue,
                      child: Center(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = category[index];
                            final selectedCategory =
                                ref.watch(categoryFilterProvider).name;

                            log(selectedCategory);
                            log(item.name);
                            return Padding(
                                padding: const EdgeInsets.all(6.0),
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
                                      orElse: () => CategoryEnums.other,
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
                          const CustomSwitch()
                        ],
                      ),
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
                                  ? NormalListView(places: data)
                                  : ref
                                      .watch(mapSettingLayerNotifierProvider)
                                      .when(
                                      data: (value) {
                                        return switch (value) {
                                          MapLayer.google => GoogleView(
                                              places: data,
                                              polyLineFromPoint: false,
                                            ),
                                          MapLayer.osm => const OsmView(),
                                        };
                                      },
                                      error: (error, stackTrace) {
                                        return ErrorWidget(error);
                                      },
                                      loading: () {
                                        return const MyLoading();
                                      },
                                    )),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text('$error'));
          },
          loading: () {
            return const MyLoading();
          },
        );
      },
    );
  }
}
