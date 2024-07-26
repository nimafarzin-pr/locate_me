import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/widget/accept_button/custom_accept_button.dart';
import 'package:locate_me/core/widget/custom_textfeild.dart';
import 'package:locate_me/core/widget/dialogs/diolog_wrapper.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../../core/widget/custom_text.dart';
import '../../../../../../core/widget/animation/fade_in_scale_animation.dart';

import '../../../../provider/app_settings_repository_provider.dart';

Future<void> showAddCategoryModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const SelectCategory();
    },
  );
}

class SelectCategory extends StatefulWidget {
  const SelectCategory({
    super.key,
  });

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  late TextEditingController _nameController;
  final formKey = GlobalKey<FormState>();
  IconData? _icon;
  Color? currentColor;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  _pickIcon() async {
    IconData? icon = await showIconPicker(context,
        iconPackModes: [IconPack.allMaterial], adaptiveDialog: true);

    setState(() {
      _icon = icon;
    });

    debugPrint('Picked Icon:  $_icon');
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${currentColor?.value}');
    return FadeInScaleAnimation(
      child: AlertDialog(
        title: CustomText.headlineSmall(LocaleKeys.add_category.tr()),
        content: SizedBox(
          width: context.screenWidth / 1.2,
          height: context.screenWidth / 1.4,
          child: Consumer(
            builder: (context, ref, child) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText.bodySmall(
                                  LocaleKeys.select_icon.tr()),
                            ),
                            Material(
                              elevation: 3,
                              shape: CircleBorder(
                                side: BorderSide(
                                    color: _icon != null
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.error,
                                    width: 0.6),
                              ),
                              child: GestureDetector(
                                onTap: _pickIcon,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  child: _icon == null
                                      ? Icon(
                                          Icons.add,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        )
                                      : Icon(
                                          _icon,
                                          size: 30,
                                          color: currentColor ??
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText.bodySmall(
                                  LocaleKeys.select_color.tr()),
                            ),
                            Material(
                              color: Colors.transparent,
                              borderOnForeground: true,
                              shape: CircleBorder(
                                side: BorderSide(
                                    color: currentColor != null
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.error,
                                    width: 0.6),
                              ),
                              elevation: 3,
                              // borderRadius: BorderRadius.circular(50.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          FadeInScaleAnimation(
                                              child: DialogWrapper(
                                            height: context.screenWidth / 0.7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ColorPicker(
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  pickerColor: currentColor !=
                                                          null
                                                      ? Color(
                                                          currentColor!.value)
                                                      : Colors.grey,
                                                  onColorChanged: changeColor,
                                                ),
                                                AcceptButton(
                                                  buttonText:
                                                      LocaleKeys.close.tr(),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          )));
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: currentColor ??
                                      Theme.of(context).colorScheme.surface,
                                  child: currentColor == null
                                      ? Icon(
                                          Icons.add,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                        textAlign: TextAlign.center,
                        hintText: LocaleKeys.enter_category_name.tr(),
                        controller: _nameController),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: AcceptButton(
                        buttonText: LocaleKeys.accept.tr(),
                        onPressed: () async {
                          if (!(formKey.currentState!.validate())) return;
                          if (_icon == null || currentColor == null) return;
                          final icon =
                              IconPickerUtils.iconPickerSerializer(_icon!);
                          ref.read(appSettingsRepositoryProvider).addCategory(
                              _nameController.text, icon, currentColor!.value);
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
