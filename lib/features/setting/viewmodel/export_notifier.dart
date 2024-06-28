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

class ExportNotifier extends AutoDisposeNotifier<RiverpodActionsCommonState> {
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
      final toJson = jsonEncode(data);
      final toBase64 = EncryptUtils.jsonToBase64(toJson);
      if (Platform.isAndroid) {
        final file = await PermissionsUtils.createFilePath(fileName: fileName);
        await file.writeAsString(toBase64);
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName.txt');
        await file.writeAsString(toBase64);
        await Share.shareXFiles([XFile(file.path, name: fileName)],
            text: fileName, subject: fileName);
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

  @override
  RiverpodActionsCommonState build() => RiverpodActionsCommonState(
      isLoading: false,
      successMessage: null,
      errorMessage: null,
      isCancel: null);
}
