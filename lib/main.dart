import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locate_me/core/common_features/database/remote/supabase_service.dart';

import 'root.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();
  await SupabaseService().init();

  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('fa', 'IR'),
          child: const MyApp())));
}
