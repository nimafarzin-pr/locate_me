import 'package:flutter/material.dart';
import 'package:locate_me/core/constant/category.dart';
import 'package:locate_me/core/enums/enums.dart';
import 'package:locate_me/core/widget/category_item.dart';
import 'package:locate_me/core/widget/custom_segmented_button.dart';
import 'package:locate_me/core/widget/empty_box.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/view/widgets/normal_list/normal_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/location_provider.dart';
import 'widgets/list_on_map/google_view/google_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int categoryIndex = 0;

  HomeListShowMode homeListShowMode = HomeListShowMode.list;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final locations = ref.watch(locationProvider);
        return locations.when(
          data: (data) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
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
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      alignment: Alignment.bottomCenter,
                      // color: Colors.blue,
                      child: Center(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = category[index];
                            return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CategoryBox(
                                  isSelected: categoryIndex == index,
                                  item: item,
                                  onTap: () {
                                    setState(() {
                                      categoryIndex = index;
                                    });
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
                      child: SegmentedButtonExample(
                        onSelectionChanged: (state) {
                          setState(() {
                            homeListShowMode = state.first;
                          });
                        },
                        homeListShowMode: homeListShowMode,
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
                              : homeListShowMode == HomeListShowMode.list
                                  ? NormalListView(places: data)
                                  : GoogleView(
                                      places: data,
                                      polyLineFromPoint: false,
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
