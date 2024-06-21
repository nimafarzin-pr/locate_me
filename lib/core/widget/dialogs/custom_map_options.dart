// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/common_features/map/model/map_settings_model.dart';
import 'package:locate_me/core/common_features/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/common_features/map/core/theme/general_map_style_colors.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../common_features/map/core/enums/map_enum.dart';
import '../../sizing/app_sizing.dart';
import '../custom_dropdwon_button.dart';
import '../custom_radio.dart';

class CustomMapOptionsDialog extends StatefulWidget {
  final void Function(String) onOptionSelected;

  const CustomMapOptionsDialog({
    super.key,
    required this.onOptionSelected,
  });

  @override
  State<CustomMapOptionsDialog> createState() => _CustomMapOptionsDialogState();
}

class _CustomMapOptionsDialogState extends State<CustomMapOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    double width = context.screenWidth;
    double height = context.screenHeight;
    return Scaffold(
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
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 2),
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:
                        BorderRadius.circular(AppSizes.veryLargeBorderRadius),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomText.bodyLarge(
                        LocaleKeys.map_settings.tr(),
                        customStyle: TextStyle(
                          fontSize: AppTextFontsAndSizing.headlineSmallFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.largePadding),
                      ref.watch(mapSettingNotifierProvider).when(
                        data: (data) {
                          return Column(
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
                                      isSelect:
                                          data.mapLayer == MapLayer.google,
                                      groupValue:
                                          data.mapLayer ?? MapLayer.google,
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
                                      isSelect: data.mapLayer == MapLayer.osm,
                                      groupValue: data.mapLayer ?? MapLayer.osm,
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
                                hintText: LocaleKeys.select_your_map_style.tr(),
                                items: MapStyle.values.toList(),
                                value: ref
                                    .watch(mapSettingStyleNotifierProvider)
                                    .value,
                                onChanged: (MapStyle? newValue) {
                                  final newData = newValue != null
                                      ? const MapSettingsModel()
                                          .copyWith(mapStyle: newValue)
                                      : const MapSettingsModel().copyWith(
                                          mapStyle: MapStyle.standard);
                                  ref
                                      .read(mapSettingNotifierProvider.notifier)
                                      .updateSettings(newData);
                                },
                                itemAsString: (MapStyle item) => item.name.tr(),
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
                                    CustomText.labelSmall(item.name.tr()),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          return ErrorWidget(error);
                        },
                        loading: () {
                          return const MyLoading();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
