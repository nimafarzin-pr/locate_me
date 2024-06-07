// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/helper/map/model/map_settings_model.dart';
import 'package:locate_me/core/helper/map/provider/map_setting_notifier_provider.dart';
import 'package:locate_me/core/theme/general_map_style_colors.dart';

import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../helper/map/enums/map_enum.dart';
import '../custom_dropdwon_button.dart';

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
                  context.pop();
                },
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: width / 1.1,
                  height: width,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
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
                        'Choose an option',
                        customStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ref.watch(mapSettingNotifierProvider).when(
                        data: (data) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ListTile(
                                title: CustomText.bodyLarge('Change Map'),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      onTap: () {
                                        ref
                                            .read(mapSettingNotifierProvider
                                                .notifier)
                                            .updateSettings(
                                                const MapSettingsModel()
                                                    .copyWith(
                                                        mapLayer:
                                                            MapLayer.google));
                                      },
                                      title: CustomText.labelSmall(
                                        'Google map',
                                      ),
                                      leading: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<MapLayer>(
                                          value: MapLayer.google,
                                          groupValue:
                                              data.mapLayer ?? MapLayer.osm,
                                          onChanged: (MapLayer? value) {
                                            ref
                                                .read(mapSettingNotifierProvider
                                                    .notifier)
                                                .updateSettings(
                                                    const MapSettingsModel()
                                                        .copyWith(
                                                            mapLayer: MapLayer
                                                                .google));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      onTap: () {
                                        ref
                                            .read(mapSettingNotifierProvider
                                                .notifier)
                                            .updateSettings(
                                                const MapSettingsModel()
                                                    .copyWith(
                                                        mapLayer:
                                                            MapLayer.osm));
                                      },
                                      title: CustomText.labelSmall(
                                        'Open street map',
                                        maxLines: 1,
                                      ),
                                      leading: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Radio<MapLayer>(
                                          visualDensity:
                                              VisualDensity.comfortable,
                                          value: MapLayer.osm,
                                          groupValue:
                                              data.mapLayer ?? MapLayer.osm,
                                          onChanged: (MapLayer? value) {
                                            ref
                                                .read(mapSettingNotifierProvider
                                                    .notifier)
                                                .updateSettings(
                                                    const MapSettingsModel()
                                                        .copyWith(
                                                            mapLayer:
                                                                MapLayer.osm));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListTile(title: CustomText.bodyLarge('Map type')),
                              CustomDropdownField<MapStyle>(
                                validator: (value) {
                                  return null;
                                },
                                hintText: 'Select your map style',
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
                                itemAsString: (MapStyle item) => item.name,
                                itemAsWidget: (MapStyle item) => Row(
                                  children: [
                                    const SizedBox(width: 8),
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
                                    const SizedBox(width: 8),
                                    CustomText.bodyLarge(item.name),
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
