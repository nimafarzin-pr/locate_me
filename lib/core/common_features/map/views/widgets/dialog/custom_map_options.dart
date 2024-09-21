// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/common_features/map/model/map_settings_model.dart';
import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/common_features/map/core/theme/general_map_style_colors.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../core/enums/map_enum.dart';
import '../../../../../sizing/app_sizing.dart';
import '../../../../../widget/custom_dropdwon_button.dart';
import '../../../../../widget/custom_radio.dart';
import '../../../../../widget/animation/fade_in_scale_animation.dart';

class CustomMapOptionsDialog extends ConsumerStatefulWidget {
  final void Function(String) onOptionSelected;

  const CustomMapOptionsDialog({
    super.key,
    required this.onOptionSelected,
  });

  @override
  ConsumerState<CustomMapOptionsDialog> createState() =>
      _CustomMapOptionsDialogState();
}

class _CustomMapOptionsDialogState
    extends ConsumerState<CustomMapOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    double width = context.screenWidth;
    double height = context.screenHeight;
    final layer = ref.watch(mapSettingLayerNotifierProvider).asData?.value ??
        MapLayer.google;
    final style = ref.watch(mapSettingStyleNotifierProvider).asData?.value ??
        MapStyle.standard;

    return BackButtonListener(
      onBackButtonPressed: () async {
        Navigator.pop(context);
        return true;
      },
      child: FadeInScaleAnimation(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer(
            builder: (context, ref, child) {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: width / 1.1,
                      height: width,
                      padding: const EdgeInsets.all(AppSizes.largePadding),
                      margin: const EdgeInsets.all(AppSizes.largePadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                            AppSizes.veryLargeBorderRadius),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Builder(builder: (context) {
                        if (!(ref
                                .watch(mapSettingLayerNotifierProvider)
                                .hasValue) ||
                            !(ref
                                .watch(mapSettingStyleNotifierProvider)
                                .hasValue)) {
                          return const MyLoading();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomText.bodyLarge(
                              LocaleKeys.map_settings.tr(),
                              customStyle: TextStyle(
                                fontSize:
                                    AppTextFontsAndSizing.headlineSmallFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSizes.largePadding),
                            // ref.watch(mapSettingNotifierProvider).when(

                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ListTile(
                                  title: CustomText.bodyLarge(
                                      LocaleKeys.change_map.tr()),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      child: CustomRadio<MapLayer>(
                                        isSelect: layer == MapLayer.google,
                                        groupValue: layer,
                                        onChanged: (p0) {
                                          ref
                                              .read(mapSettingNotifierProvider
                                                  .notifier)
                                              .updateSettings(
                                                  const MapSettingsModel()
                                                      .copyWith(
                                                          mapLayer:
                                                              MapLayer.google));
                                        },
                                        title: "Google Map",
                                        value: MapLayer.google,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomRadio<MapLayer>(
                                        isSelect: layer == MapLayer.osm,
                                        groupValue: layer,
                                        onChanged: (p0) {
                                          ref
                                              .read(mapSettingNotifierProvider
                                                  .notifier)
                                              .updateSettings(
                                                  const MapSettingsModel()
                                                      .copyWith(
                                                          mapLayer:
                                                              MapLayer.osm));
                                        },
                                        title: "Open Street Map",
                                        value: MapLayer.osm,
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                    title: CustomText.bodyLarge(
                                        LocaleKeys.map_style.tr())),
                                CustomDropdownField<MapStyle>(
                                  validator: (value) {
                                    return null;
                                  },
                                  hintText:
                                      LocaleKeys.select_your_map_style.tr(),
                                  items: MapStyle.values.toList(),
                                  value: style,
                                  onChanged: (MapStyle? newValue) {
                                    final newData = newValue != null
                                        ? const MapSettingsModel()
                                            .copyWith(mapStyle: newValue)
                                        : const MapSettingsModel().copyWith(
                                            mapStyle: MapStyle.standard);
                                    ref
                                        .read(
                                            mapSettingNotifierProvider.notifier)
                                        .updateSettings(newData);
                                  },
                                  itemAsString: (MapStyle item) =>
                                      item.name.tr(),
                                  itemAsWidget: (MapStyle item) => Row(
                                    children: [
                                      const SizedBox(
                                          width: AppSizes.smallPadding),
                                      Card(
                                        clipBehavior: Clip.hardEdge,
                                        elevation: 2,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  generalStyleColors[item.name],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(
                                          width: AppSizes.smallPadding),
                                      CustomText.bodySmall(item.name.tr()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
