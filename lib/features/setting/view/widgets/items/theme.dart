import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/enums/enums.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../home/provider/location_provider.dart';
import '../../../provider/theme_notifier_provider.dart';
import '../setting_item_tile.dart';

Future<void> showThemeModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText.headlineMedium('Select Theme'),
        content: SizedBox(
          width: 400,
          height: 200,
          child: Consumer(
            builder: (context, ref, child) {
              return Column(
                children: [
                  SettingItemTile(
                      isSelect:
                          ref.watch(themeNotifierProvider) == AppThemeMode.auto,
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
                      isSelect: ref.watch(themeNotifierProvider) ==
                          AppThemeMode.light,
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
                      isSelect:
                          ref.watch(themeNotifierProvider) == AppThemeMode.dark,
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
          ),
        ),
      );
    },
  );
}
