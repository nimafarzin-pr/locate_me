import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/common_features/category/constant/category.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/sizing/app_sizing.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/widget/custom_favorite_icon_button.dart';
import 'package:locate_me/core/widget/custom_rich_text.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/warning_dialog.dart';
import 'package:locate_me/core/widget/rate.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/home_screen_repository_provider.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/features/setting/provider/language_notifier_provider.dart';
import 'package:locate_me/generated/locale_keys.g.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
      height: context.screenWidth / 2.4,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.mediumBorderRadius),
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ],
        ),
      ),
      child: Card(
        elevation: 3,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.smallPadding),
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
                                    padding: const EdgeInsets.all(
                                        AppSizes.verySmallPadding),
                                    child: Image.asset(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        categoryMap[item.category] != null
                                            ? categoryMap[item.category]!.icon
                                            : item.icon),
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
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                      FontAwesomeIcons.penToSquare,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      FontAwesomeIcons.route,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      if (item.id == null) return;
                                      showWarningDialog(
                                        context: context,
                                        content:
                                            '${item.title}\n\n${LocaleKeys.do_you_want_to_continue.tr()}',
                                        iconColor:
                                            Theme.of(context).colorScheme.error,
                                        title: LocaleKeys.delete.tr(),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
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
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
