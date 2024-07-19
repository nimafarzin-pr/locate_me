import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locate_me/core/widget/dialogs/status_widget.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/enums/enums.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';
import '../../../provider/theme_notifier_provider.dart';
import '../setting_item_tile.dart';

Future<void> showThemeModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return FadeInScaleAnimation(
        child: AlertDialog(
          title: CustomText.headlineSmall(LocaleKeys.select_theme.tr()),
          content: SizedBox(
            width: 400,
            height: 200,
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(themeNotifierProvider).when(
                    data: (theme) {
                      return Column(
                        children: [
                          SettingItemTile(
                              isSelect: theme == AppThemeMode.auto,
                              context: context,
                              title: 'Auto',
                              icon: Icons.auto_awesome_rounded,
                              onTap: () {
                                Navigator.of(context).pop();
                                ref
                                    .read(themeNotifierProvider.notifier)
                                    .setTheme(AppThemeMode.auto);
                              }),
                          SettingItemTile(
                              isSelect: theme == AppThemeMode.light,
                              context: context,
                              title: 'Light Theme',
                              icon: Icons.light_mode,
                              onTap: () {
                                Navigator.of(context).pop();
                                ref
                                    .read(themeNotifierProvider.notifier)
                                    .setTheme(AppThemeMode.light);
                              }),
                          SettingItemTile(
                              isSelect: theme == AppThemeMode.dark,
                              context: context,
                              title: 'Dark Theme',
                              icon: Icons.dark_mode,
                              onTap: () {
                                Navigator.of(context).pop();
                                ref
                                    .read(themeNotifierProvider.notifier)
                                    .setTheme(AppThemeMode.dark);
                              }),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      return StatusWidget(
                        title: LocaleKeys.error.tr(),
                        content: "$error",
                        iconColor: Theme.of(context).colorScheme.error,
                      );
                    },
                    loading: () => const MyLoading());
              },
            ),
          ),
        ),
      );
    },
  );
}
