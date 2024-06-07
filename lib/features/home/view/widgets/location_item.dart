import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/constant/category.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/custom_favorite_icon_button.dart';
import 'package:locate_me/core/widget/custom_rich_text.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/warning_dialog.dart';
import 'package:locate_me/core/widget/rate.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/home_screen_repository_provider.dart';

class LocationItem extends ConsumerWidget {
  final int index;
  final bool isCarouselItem;
  final PlaceItemModel item;

  const LocationItem({
    super.key,
    this.index = 0,
    this.isCarouselItem = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(
          top: index == 0 ? 0 : 12.0,
          left: isCarouselItem ? 8 : 0,
          right: isCarouselItem ? 8 : 0),
      width: context.screenWidth,
      height: context.screenHeight / 4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                      ),
                                    ),
                                    child: Image.asset(
                                        categoryMap[item.category] != null
                                            ? categoryMap[item.category]!.icon
                                            : item.icon)),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: CustomText.bodyLarge(
                                    item.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRichText(
                                    title: 'Address: ', value: item.address),
                                CustomRichText(
                                    title: 'Distance: ', value: item.distance),
                                CustomRichText(
                                    title: 'Date: ', value: item.date),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.go(Routes.map);
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      color: Colors.grey,
                                    )),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: const FaIcon(
                                //       color: Colors.grey,
                                //       FontAwesomeIcons.mapLocationDot,
                                //     )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      color: Colors.grey,
                                      FontAwesomeIcons.route,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      if (item.id == null) return;
                                      showWarningDialog(
                                        context: context,
                                        title: 'Delete',
                                        onConfirm: () async {
                                          await ref
                                              .read(
                                                  homeScreenRepositoryProvider)
                                              .deleteLocation(item.id!);
                                        },
                                      );
                                    },
                                    icon: const FaIcon(
                                      color: Colors.grey,
                                      FontAwesomeIcons.trashCan,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFavoriteIconButton(
                    isFavorite: item.isFavorite,
                    onPressed: () {
                      log('~~~~~~~${item.id}');
                      log('~~~~~~~${item.isFavorite}');
                      if (item.id == null) return;
                      ref
                          .read(favoriteFilterProvider.notifier)
                          .updateFavoriteStatus(id: item.id!);
                    },
                  ),
                  Column(
                    children: [
                      Rate(
                        direction: Axis.vertical,
                        draggable: false,
                        initialRating: item.rate,
                      ),
                      CustomText.bodyLarge('${item.rate}')
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
