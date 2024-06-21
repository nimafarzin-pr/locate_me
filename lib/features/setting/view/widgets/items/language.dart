import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/constant/constant_names.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/setting/provider/language_notifier_provider.dart';
import 'package:locate_me/features/setting/view/widgets/setting_item_tile.dart';

import '../../../../../core/widget/custom_text.dart';
import '../../../../home/provider/location_provider.dart';

void showLanguageModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText.headlineMedium('Select Language'),
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
                            Navigator.of(context).pop();
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
                            Navigator.of(context).pop();
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
                  return ErrorWidget(
                    errorMessage: "$error",
                    onOkPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
                loading: () {
                  return const MyLoading();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onOkPressed;

  const ErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Icon(
        Icons.error_outline,
        color: Theme.of(context).colorScheme.error,
        size: 40,
      ),
      content: Text(
        errorMessage,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: onOkPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            child: CustomText.labelSmall(
              'OK',
            ),
          ),
        ),
      ],
    );
  }
}
