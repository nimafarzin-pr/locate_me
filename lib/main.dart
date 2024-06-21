import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locate_me/core/navigation/router/router.dart';
import 'package:locate_me/core/theme/theme.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'core/enums/enums.dart';
import 'features/setting/provider/language_notifier_provider.dart';
import 'features/setting/provider/theme_notifier_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  await EasyLocalization.ensureInitialized();
  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('fa', 'IR'),
          child: const MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    log('P> $themeMode');
    log('T> ${MediaQuery.of(context).platformBrightness}');

    return currentLanguage.when(
      data: (locale) {
        context.setLocale(Locale(locale, locale == 'fa' ? 'IR' : 'US'));
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: Locale(locale, locale == 'fa' ? 'IR' : 'US'),
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              routerDelegate: router.routerDelegate,
              themeMode: getThemeMode(themeMode),
              debugShowCheckedModeBanner: false,
              theme: getTheme(themeMode),
            );
          },
        );
      },
      loading: () {
        return const MyLoading();
      },
      error: (error, stackTrace) => ErrorWidget(error),
    );
  }
}
