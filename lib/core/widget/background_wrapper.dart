import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/enums/enums.dart';
import 'package:locate_me/core/widget/dialogs/status_widget.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/setting/provider/theme_notifier_provider.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

class BackgroundWrapper extends ConsumerWidget {
  final Widget child;

  const BackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: theme.when(
                data: (currentTheme) {
                  final isAuto = currentTheme == AppThemeMode.auto;
                  final autoThemeValue =
                      (MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? AppThemeMode.dark
                          : AppThemeMode.light);
                  final customOption = isAuto ? autoThemeValue : currentTheme;
                  return Container(
                    color: Theme.of(context).colorScheme.surface,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     opacity: customOption == AppThemeMode.dark ? 0.06 : 0.3,
                    //     image: AssetImage(customOption == AppThemeMode.dark
                    //         ? "assets/background/darkBackground.png"
                    //         : "assets/background/background.png"),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: child,
                  );
                },
                error: (error, stackTrace) => StatusWidget(
                      title: LocaleKeys.error.tr(),
                      content: '$error',
                      iconColor: Theme.of(context).colorScheme.error,
                    ),
                loading: () => const MyLoading())),
      ),
    );
  }
}
