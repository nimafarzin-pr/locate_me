// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/features/home/view/widgets/location_item.dart';

import '../../model/place_item_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.data,
    this.onPageChanged,
  });

  final List<PlaceItemModel> data;
  final dynamic Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          disableCenter: true,
          enlargeCenterPage: true,
          height: context.screenWidth / 2.2,
          onPageChanged: (index, reason) {
            if (onPageChanged != null) {
              onPageChanged!(index);
            }
          },
        ),
        items: data.map((place) {
          return Builder(
            builder: (BuildContext context) {
              return FadeInScaleAnimation(
                duration: const Duration(milliseconds: 600),
                child: LocationItem(
                  item: place,
                  isCarouselItem: true,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
