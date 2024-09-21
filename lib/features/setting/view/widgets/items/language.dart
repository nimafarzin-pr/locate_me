import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/constant/constant_names.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/setting/provider/language_notifier_provider.dart';
import 'package:locate_me/features/setting/view/widgets/setting_item_tile.dart';

import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';
import '../../../../../generated/locale_keys.g.dart';

void showLanguageModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BackButtonListener(
        onBackButtonPressed: () async {
          Navigator.pop(context);
          return true;
        },
        child: FadeInScaleAnimation(
          child: AlertDialog(
            title: CustomText.headlineSmall(LocaleKeys.select_language.tr()),
            content: SizedBox(
              width: 400,
              height: 200,
              child: Consumer(
                builder: (context, ref, child) {
                  final languageNotifier = ref.watch(languageNotifierProvider);
                  return languageNotifier.when(
                    data: (currentLanguage) {
                      return Column(
                        children: [
                          SettingItemTile(
                              context: context,
                              title: 'English',
                              icon: Icons.language,
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .read(languageNotifierProvider.notifier)
                                    .setLanguage(englishLanguageKey);
                                context.setLocale(const Locale('en', "US"));
                              },
                              isSelect: currentLanguage == englishLanguageKey),
                          SettingItemTile(
                              context: context,
                              title: 'فارسی',
                              icon: Icons.language,
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .read(languageNotifierProvider.notifier)
                                    .setLanguage(persianLanguageKey);
                                context.setLocale(const Locale('fa', "IR"));
                              },
                              isSelect: currentLanguage == persianLanguageKey),
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
                    loading: () {
                      return const MyLoading();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
