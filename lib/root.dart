import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/enums/enums.dart';
import 'core/navigation/router/router.dart';
import 'core/theme/theme.dart';
import 'core/widget/dialogs/status_widget.dart';
import 'core/widget/loading.dart';
import 'features/setting/provider/settings_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final currentLanguage = ref.watch(languageNotifierProvider);
    ThemeMode getThemeMode(AppThemeMode mode) {
      switch (mode) {
        case AppThemeMode.light:
          return ThemeMode.light;
        case AppThemeMode.dark:
          return ThemeMode.dark;
        case AppThemeMode.auto:
        default:
          return ThemeMode.system;
      }
    }

    ThemeData getTheme(AppThemeMode mode) {
      switch (mode) {
        case AppThemeMode.light:
          return GlobalThemeData.lightTheme;
        case AppThemeMode.dark:
          return GlobalThemeData.darkTheme;
        case AppThemeMode.auto:
        default:
          return (MediaQuery.of(context).platformBrightness == Brightness.dark
              ? GlobalThemeData.darkTheme
              : GlobalThemeData.lightTheme);
      }
    }

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return currentLanguage.when(
          data: (locale) {
            context.setLocale(Locale(locale, locale == 'fa' ? 'IR' : 'US'));
            return themeMode.when(
              data: (theme) {
                final tMode = getThemeMode(theme);
                final currentTheme = getTheme(theme);
                return rootWidget(context, locale, tMode, currentTheme);
              },
              error: (err, stackTrace) => errorWidget(err, context),
              loading: () => const MyLoading(),
            );
          },
          loading: () => const MyLoading(),
          error: (err, stack) => errorWidget(err, context),
        );
      },
    );
  }

  StatusWidget errorWidget(Object err, BuildContext context) => StatusWidget(
      title: "Error",
      content: err.toString(),
      iconColor: Theme.of(context).colorScheme.error);

  MaterialApp rootWidget(BuildContext context, language, tMode, currentTheme) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(language ?? 'fa', language == 'fa' ? 'IR' : 'US'),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      themeMode: tMode,
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
    );
  }
}
