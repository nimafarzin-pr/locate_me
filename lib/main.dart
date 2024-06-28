import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:easy_localization/easy_localization.dart';

import 'root.dart';

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
