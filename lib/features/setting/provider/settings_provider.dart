import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/view/view_model/language_notifier.dart';

import 'package:locate_me/core/riverpod/riverpod_actions_common_state.dart';
import 'package:locate_me/features/setting/view/view_model/logout.dart';
import 'package:riverpod/riverpod.dart';

import '../view/view_model/export_notifier.dart';
import '../view/view_model/import_state.dart';

import '../../../core/enums/enums.dart';
import '../view/view_model/theme_notifier.dart';

import 'package:locate_me/core/common_features/database/local/provider/db_provider.dart';
import 'package:locate_me/features/setting/repository/settings_repository.dart';

final appSettingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final repo = ref.read(appDBSettingsRepositoryProvider);

  return SettingsRepository(repo);
});

final exportNotifierProvider =
    AutoDisposeNotifierProvider<ExportNotifier, RiverpodActionsCommonState>(
        ExportNotifier.new);

final importNotifierProvider =
    NotifierProvider<ImportNotifier, RiverpodActionsCommonState>(
        ImportNotifier.new);

final languageNotifierProvider =
    AsyncNotifierProvider<LanguageNotifier, String>(LanguageNotifier.new);

final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, AppThemeMode>(ThemeNotifier.new);

final logoutNotifierProvider =
    AsyncNotifierProvider<LogoutNotifier, bool?>(LogoutNotifier.new);
