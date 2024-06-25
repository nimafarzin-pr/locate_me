import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/generated/locale_keys.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/riverpod/riverpod_actions_common_state.dart';
import '../../../core/utils/date_converter.dart';
import '../../../core/utils/encrypt_utils.dart';
import '../../../core/utils/permissions.dart';
import '../provider/app_settings_repository_provider.dart';
import '../provider/language_notifier_provider.dart';

class ExportNotifier extends StateNotifier<RiverpodActionsCommonState> {
  ExportNotifier() : super(RiverpodActionsCommonState());

  Future<void> exportData(String fileName) async {
    state = state.copyWith(
        isLoading: true,
        successMessage: null,
        errorMessage: null,
        isCancel: null);
    try {
      final ref = ProviderContainer();
      final languageLocale = ref.read(languageNotifierProvider).value ?? "fa";
      final date =
          DateConverter.autoConverter(DateTime.now().toIso8601String());
      final fName = "$fileName $date";
      final repo = ref.read(appSettingsRepositoryProvider);
      final data = await repo.getExportedData();
      final jsonString = jsonEncode(data);
      if (Platform.isAndroid) {
        final file = await PermissionsUtils.createFilePath(fileName: fileName);
        await file.writeAsString(EncryptUtils.jsonToBase64(jsonString));
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/locations_export.json');
        await file.writeAsString(jsonString);
        await Share.shareXFiles([XFile(file.path)],
            text: LocaleKeys.export.tr());
      }
      state = state.copyWith(
          isLoading: false,
          successMessage: LocaleKeys.success_backup.tr(),
          isCancel: false,
          errorMessage: null);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, errorMessage: LocaleKeys.error_backup.tr());
    }
  }
}
