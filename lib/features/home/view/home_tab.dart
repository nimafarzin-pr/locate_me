import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locate_me/core/constant/category.dart';
import 'package:locate_me/core/dummydata/dummy_data.dart';
import 'package:locate_me/core/enums/enums.dart';
import 'package:locate_me/core/widget/category_item.dart';
import 'package:locate_me/core/widget/custom_segmented_button.dart';
import 'package:locate_me/core/widget/location_item.dart';
import 'package:locate_me/features/map/view/map_view.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Place> places = [];

  @override
  void initState() {
    final fakeData =
        (json.decode(jsonStr) as List).map((e) => Place.fromJson(e)).toList();
    places.addAll(fakeData);

    super.initState();
  }

  int selectedIndex = 0;
  HomeListShowMode homeListShowMode = HomeListShowMode.list;

  @override
  Widget build(BuildContext context) {
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
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = category[index];
                    return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CategoryBox(
                          isSelected: selectedIndex == index,
                          item: item,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
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
                  child: homeListShowMode == HomeListShowMode.list
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            final item = places[index];
                            return LocationItem(item: item, index: index);
                          },
                          itemCount: places.length,
                        )
                      : MapView(
                          locations: places,
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
