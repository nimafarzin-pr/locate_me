import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/extension/image_size_extension.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/sizing/app_sizing.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/utils/share_utils.dart';
import 'package:locate_me/core/widget/custom_favorite_icon_button.dart';
import 'package:locate_me/core/widget/custom_rich_text.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/warning_dialog.dart';
import 'package:locate_me/core/widget/rate.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/favorite_filter_provider.dart';
import 'package:locate_me/features/home/provider/home_screen_repository_provider.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/common_features/caching/image_byte_provider.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/common_features/caching/base64_dto.dart';

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
    final imageBytes = ref
        .watch(imageByteProvider(
            Base64DTO(id: item.id.toString(), source: item.picture)))
        .asData
        ?.value;

    return Container(
      margin: EdgeInsets.only(
          top: index == 0 ? 0 : AppSizes.smallMargin,
          left: isCarouselItem ? AppSizes.smallMargin : 0,
          right: isCarouselItem ? AppSizes.smallMargin : 0),
      width: context.screenWidth,
      height: context.screenWidth / 2.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.mediumBorderRadius),
        ),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                child: SizedBox(
                                  width: 30.cachedSize(context).toDouble(),
                                  height: 30.cachedSize(context).toDouble(),
                                  child: Icon(
                                    Icons.local_see_outlined,
                                    size: 26,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ),
                              imageBytes == null
                                  ? Container()
                                  : DecoratedBox(
                                      position: DecorationPosition.foreground,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.4),
                                              Colors.transparent
                                            ]),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,

                                            image: Image.memory(
                                              imageBytes,
                                              cacheWidth:
                                                  50.cachedSize(context),
                                              cacheHeight:
                                                  66.cachedSize(context),
                                              gaplessPlayback: true,
                                              fit: BoxFit.cover,
                                            ).image,
                                            // fit: BoxFit.contain,
                                          ),
                                        ),
                                        width:
                                            30.cachedSize(context).toDouble(),
                                        height:
                                            30.cachedSize(context).toDouble(),
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomRichText(
                                              title:
                                                  '${LocaleKeys.title.tr()}: ',
                                              value: item.title),
                                          CustomRichText(
                                              title:
                                                  '${LocaleKeys.address.tr()}: ',
                                              value: item.address),
                                          CustomRichText(
                                              title:
                                                  '${LocaleKeys.date.tr()}: ',
                                              value:
                                                  DateConverter.autoConverter(
                                                      item.date,
                                                      ref: ref)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          favAndRateColumn(ref),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: context.screenWidth / 1.4,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            footerActions(ref, context)
          ],
        ),
      ),
    );
  }

  SizedBox favAndRateColumn(WidgetRef ref) {
    return SizedBox(
      width: 28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  IconPickerUtils.iconPickerDeserializer(item.categoryIcon),
                  color: Colors.grey.withOpacity(0.7),
                  size: 20,
                ),
                const SizedBox(height: 4),
                Rate(
                  direction: Axis.vertical,
                  draggable: false,
                  // itemSize: 14,
                  initialRating: item.rate,
                ),
                CustomText.bodyLarge(
                  '${item.rate}',
                  customStyle: TextStyle(
                      fontSize: AppTextFontsAndSizing.bodyMediumFontSize),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget footerActions(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  ref
                      .read(selectedEditStateProviderForEditAndView.notifier)
                      .state = item;
                  context.goNamed(Routes.locationDetail);
                },
                icon: FaIcon(
                  size: 20,
                  color: Colors.grey.withOpacity(0.7),
                  FontAwesomeIcons.eye,
                )),
            IconButton(
                onPressed: () {
                  ref
                      .read(selectedEditStateProviderForEditAndView.notifier)
                      .state = item;
                  context.goNamed(Routes.editLocation);
                },
                icon: FaIcon(
                  size: 20,
                  FontAwesomeIcons.penToSquare,
                  color: Colors.grey.withOpacity(0.7),
                )),
            IconButton(
                onPressed: () async {
                  await ShareUtils.shareLocation(
                      markerLabel: item.title,
                      context: context,
                      lat: item.latlng.latitude,
                      lng: item.latlng.longitude);
                },
                icon: FaIcon(
                  size: 20,
                  color: Colors.grey.withOpacity(0.7),
                  FontAwesomeIcons.shareNodes,
                )),
            IconButton(
              padding: EdgeInsets.zero, // Remove all padding
              visualDensity: VisualDensity.compact,
              onPressed: () {
                if (item.id == null) return;
                showWarningDialog(
                  context: context,
                  content: LocaleKeys.do_you_want_to_continue.tr(),
                  iconColor: Theme.of(context).colorScheme.error,
                  title: '${LocaleKeys.delete.tr()} ${item.title}\n\n',
                  onConfirm: () async {
                    await ref
                        .read(homeScreenRepositoryProvider)
                        .deleteLocation(item.id!);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                );
              },
              icon: FaIcon(
                size: 20,
                color: Colors.grey.withOpacity(0.7),
                FontAwesomeIcons.trashCan,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomFavoriteIconButton(
            isFavorite: item.isFavorite,
            onPressed: () {
              if (item.id == null) return;
              ref
                  .read(favoriteFilterProvider.notifier)
                  .updateFavoriteStatus(id: item.id!);
            },
          ),
        ),
      ],
    );
  }
}
