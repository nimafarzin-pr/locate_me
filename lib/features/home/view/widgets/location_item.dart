import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/sizing/app_sizing.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/widget/custom_favorite_icon_button.dart';
import 'package:locate_me/core/widget/custom_rich_text.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/diolog_wrapper.dart';
import 'package:locate_me/core/widget/dialogs/warning_dialog.dart';
import 'package:locate_me/core/widget/rate.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/home_screen_repository_provider.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../core/utils/date_converter.dart';

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
          top: index == 0 ? 0 : AppSizes.smallMargin,
          left: isCarouselItem ? AppSizes.smallMargin : 0,
          right: isCarouselItem ? AppSizes.smallMargin : 0),
      width: context.screenWidth,
      height: context.screenWidth / 2.3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.mediumBorderRadius),
        ),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.mediumBorderRadius),
                                    border: Border.all(
                                      width: AppSizes.thinBorderWidth,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                        IconPickerUtils.iconPickerDeserializer(
                                            item.category)),
                                  ),
                                ),
                                const SizedBox(
                                    width: AppSizes.verySmallScreenGutter),
                                Expanded(
                                  child: CustomText.bodyLarge(
                                    customStyle: TextStyle(
                                        fontSize: AppTextFontsAndSizing
                                            .bodyMediumFontSize),
                                    item.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomRichText(
                                    title: '${LocaleKeys.title.tr()}: ',
                                    value: item.title),
                                CustomRichText(
                                    title: '${LocaleKeys.address.tr()}: ',
                                    value: item.address),
                                CustomRichText(
                                    title: '${LocaleKeys.date.tr()}: ',
                                    value:
                                        DateConverter.autoConverter(item.date)),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: context.screenWidth,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      ref
                                          .read(editStateProvider.notifier)
                                          .state = item;
                                      // context.go(Routes.editLocation);
                                      context.goNamed(Routes.editLocation);
                                    },
                                    icon: FaIcon(
                                      size: 20,
                                      FontAwesomeIcons.penToSquare,
                                      color: Colors.grey.withOpacity(0.7),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      String markerLabel = item.title;
                                      try {
                                        if (Platform.isAndroid) {
                                          final url = Uri.parse(
                                              'geo:${item.latlng.latitude},${item.latlng.longitude}?q=${item.latlng.latitude},${item.latlng.longitude}($markerLabel)');
                                          await launchUrl(url);
                                        } else {
                                          final availableMaps =
                                              await MapLauncher.installedMaps;
                                          await showDialog(
                                            context: context,
                                            builder: (dContext) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(40),
                                                child: DialogWrapper(
                                                  height:
                                                      context.screenWidth / 2,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        availableMaps.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final maps =
                                                          availableMaps[index];

                                                      return Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await maps
                                                                      .showMarker(
                                                                    coords: Coords(
                                                                        item.latlng
                                                                            .latitude,
                                                                        item.latlng
                                                                            .longitude),
                                                                    title: item
                                                                        .title,
                                                                  );

                                                                  Navigator.pop(
                                                                      dContext);
                                                                },
                                                                child: Text(maps
                                                                    .mapName
                                                                    .toString()),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } catch (error) {
                                        if (context.mounted) {
                                          log('$error');
                                        }
                                      }
                                    },
                                    icon: FaIcon(
                                      size: 20,
                                      color: Colors.grey.withOpacity(0.7),
                                      FontAwesomeIcons.shareAlt,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      if (item.id == null) return;
                                      showWarningDialog(
                                        context: context,
                                        content: LocaleKeys
                                            .do_you_want_to_continue
                                            .tr(),
                                        iconColor:
                                            Theme.of(context).colorScheme.error,
                                        title:
                                            '${LocaleKeys.delete.tr()} ${item.title}\n\n',
                                        onConfirm: () async {
                                          await ref
                                              .read(
                                                  homeScreenRepositoryProvider)
                                              .deleteLocation(item.id!);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                      );
                                    },
                                    icon: FaIcon(
                                      size: 20,
                                      color: Colors.grey.withOpacity(0.7),
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
              SizedBox(
                width: 28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomFavoriteIconButton(
                      isFavorite: item.isFavorite,
                      onPressed: () {
                        if (item.id == null) return;
                        ref
                            .read(favoriteFilterProvider.notifier)
                            .updateFavoriteStatus(id: item.id!);
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Rate(
                            direction: Axis.vertical,
                            draggable: false,
                            initialRating: item.rate,
                          ),
                          CustomText.bodyLarge(
                            '${item.rate}',
                            customStyle: TextStyle(
                                fontSize:
                                    AppTextFontsAndSizing.bodyMediumFontSize),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
