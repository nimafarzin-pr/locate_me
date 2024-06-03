import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/constant/category.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/custom_rich_text.dart';
import 'package:locate_me/core/widget/rate.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

class LocationItem extends StatelessWidget {
  final int index;
  final PlaceItemModel item;

  const LocationItem({
    super.key,
    this.index = 0,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 0 : 12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.18,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
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
                                  child: Text(
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
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      color: Colors.grey,
                                      FontAwesomeIcons.mapLocationDot,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const FaIcon(
                                      color: Colors.grey,
                                      FontAwesomeIcons.route,
                                    )),
                                IconButton(
                                    onPressed: () {},
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
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.bookmark)),
                  Column(
                    children: [
                      Rate(
                        direction: Axis.vertical,
                        draggable: false,
                        initialRating: item.rate,
                      ),
                      Text('${item.rate}')
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
