import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/home/view_model/edit_item_notifier.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';
import '../../../../core/common_features/caching/base64_dto.dart';
import '../../../../core/common_features/caching/image_byte_provider.dart';
import '../../../../core/common_features/map/core/enums/map_enum.dart';
import '../../../../core/common_features/map/provider/map_setting_notifier_provider.dart';
import '../../../../core/sizing/my_text_size.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/utils/share_utils.dart';
import '../../../../core/widget/custom_back_icon.dart';
import '../../../../core/widget/custom_favorite_icon_button.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/rate.dart';
import '../../../setting/provider/language_notifier_provider.dart';
import '../../provider/favorite_filter_provider.dart';
import 'list_on_map/google_view/google_view.dart';
import 'list_on_map/osm_view/osm_view.dart';

class ShowDetailsScreen<T> extends ConsumerStatefulWidget {
  const ShowDetailsScreen({
    super.key,
  });

  @override
  ConsumerState<ShowDetailsScreen> createState() => _AddLocationViewState<T>();
}

class _AddLocationViewState<T> extends ConsumerState<ShowDetailsScreen> {
  late Uint8List? imageByte;

  @override
  Widget build(BuildContext context) {
    double width = context.screenWidth;
    double height = context.screenHeight;
    final selectedItem = ref.watch(selectedEditStateProviderForEditAndView);
    if (ref.watch(selectedEditStateProviderForEditAndView) != null &&
        selectedItem!.picture.isNotEmpty) {
      imageByte = ref
          .watch(imageByteProvider(Base64DTO(
              id: selectedItem.id.toString(), source: selectedItem.picture)))
          .asData
          ?.value;
    }

    return FadeInScaleAnimation(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BackButtonListener(
            onBackButtonPressed: () async {
              ref.read(selectedEditStateProviderForEditAndView.notifier).state =
                  null;
              Navigator.of(context).pop();
              return true;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  collapsedHeight: context.screenWidth / 1.5,
                  expandedHeight: context.screenWidth / 1.5,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: FloatingActionButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          onPressed: () {
                            ref
                                .read(selectedEditStateProviderForEditAndView
                                    .notifier)
                                .state = null;
                            Navigator.of(context).pop();
                          },
                          child: const CustomBackIcon(),
                        ),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  pinned: false,
                  // forceElevated: true,
                  primary: true,
                  floating: true,
                  // elevation: 4,
                  // excludeHeaderSemantics: true,
                  // leadingWidth: 60,

                  title: CustomText.bodyLarge(selectedItem!.title,
                      customStyle: TextStyle(
                          color: Theme.of(context).colorScheme.surface)),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              onPressed: () async {
                                await ShareUtils.shareLocation(
                                    markerLabel: selectedItem.title,
                                    context: context,
                                    lat: selectedItem.latlng.latitude,
                                    lng: selectedItem.latlng.longitude);
                              },
                              child: const Icon(
                                Icons.share_rounded,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                onPressed: () async {
                                  await ShareUtils.shareLocation(
                                      markerLabel: selectedItem.title,
                                      context: context,
                                      lat: selectedItem.latlng.latitude,
                                      lng: selectedItem.latlng.longitude);
                                },
                                child: CustomFavoriteIconButton(
                                  iconSize: 20,
                                  isFavorite: selectedItem.isFavorite,
                                  onPressed: () {
                                    if (selectedItem.id == null) return;
                                    ref
                                        .read(favoriteFilterProvider.notifier)
                                        .updateFavoriteStatus(
                                            id: selectedItem.id!);
                                    ref
                                            .read(
                                                selectedEditStateProviderForEditAndView
                                                    .notifier)
                                            .state =
                                        selectedItem.copyWith(
                                            isFavorite:
                                                !selectedItem.isFavorite);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    expandedTitleScale: 1,
                    titlePadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Container(
                      width: context.screenWidth,
                      height: 40,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.pin_drop_rounded,
                                  size: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: 2),
                                CustomText.bodyLarge(
                                  selectedItem.address,
                                  customStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  size: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: 2),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: CustomText.bodyLarge(
                                    DateConverter.autoConverter(
                                            selectedItem.date,
                                            ref: ref)
                                        .trim(),
                                    customStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Rate(
                                  direction: Axis.horizontal,
                                  draggable: false,
                                  itemSize: 7,
                                  initialRating: selectedItem.rate,
                                ),
                                CustomText.bodyLarge(
                                  '${selectedItem.rate}',
                                  customStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer,
                                      fontSize: AppTextFontsAndSizing
                                          .bodyMediumFontSize),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          child: SizedBox(
                            width: context.screenWidth,
                            height: 240,
                            child: Center(
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
                        ),
                        DecoratedBox(
                            position: DecorationPosition.foreground,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ]),
                            ),
                            child: selectedItem.picture.isEmpty
                                ? Container()
                                : Image.memory(
                                    imageByte!,
                                    fit: BoxFit.cover,
                                  ))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // const SizedBox(height: 20),
                        dataItemBuilder(
                            iconData: Icons.gps_fixed_outlined,
                            title: LocaleKeys.latitude.tr(),
                            value: selectedItem.latlng.latitude.toString()),
                        dataItemBuilder(
                            iconData: Icons.gps_fixed_outlined,
                            title: LocaleKeys.longitude.tr(),
                            value: selectedItem.latlng.longitude.toString()),

                        dataItemBuilder(
                            iconData: Icons.description_rounded,
                            title: LocaleKeys.description.tr(),
                            value: selectedItem.description),

                        dataItemBuilder(
                            iconData: Icons.category,
                            title: LocaleKeys.category.tr(),
                            value: selectedItem.categoryName == 'all'
                                ? LocaleKeys.all.tr()
                                : selectedItem.categoryName),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            height: context.screenWidth / 1.4,
                            child:
                                ref.watch(mapSettingLayerNotifierProvider).when(
                              data: (value) {
                                return switch (value) {
                                  MapLayer.google =>
                                    const GoogleView(withCarouselSlider: false),
                                  MapLayer.osm => const OsmView(
                                      withCarouselSlider: false,
                                    ),
                                };
                              },
                              error: (error, stackTrace) {
                                return StatusWidget(
                                  title: LocaleKeys.error.tr(),
                                  content: "$error",
                                  iconColor:
                                      Theme.of(context).colorScheme.error,
                                );
                              },
                              loading: () {
                                return MyLoading(
                                    color:
                                        Theme.of(context).colorScheme.primary);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  ListTile dataItemBuilder(
      {required String value,
      required String title,
      required IconData iconData}) {
    return ListTile(
      title: CustomRichText(
        title: '$title: ',
        value: value,
        maxLines: null,
      ),
      leading: Icon(
        iconData,
        color: Colors.grey.withOpacity(0.7),
      ),
    );
  }
}
