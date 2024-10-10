import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/utils/encrypt_utils.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/riverpod/riverpod_actions_common_state.dart';
import '../../../home/model/place_item_model.dart';
import '../../provider/app_settings_repository_provider.dart';

class ImportNotifier extends Notifier<RiverpodActionsCommonState> {
  Future<void> importData() async {
    state = state.copyWith(
        isLoading: true,
        successMessage: null,
        errorMessage: null,
        isCancel: null);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if (result != null && result.paths[0] != null) {
        final file = File(result.paths[0]!);
        final base64String = await file.readAsString();
        final jsonFromBase64 = EncryptUtils.base64ToJson(base64String);
        final decode = json.decode(jsonFromBase64) as List<dynamic>;
        final List<PlaceItemModel> data = decode
            .map((e) => PlaceItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final ref = ProviderContainer();
        final repo = ref.read(appSettingsRepositoryProvider);
        await repo.importData(data);
        state = state.copyWith(
          isLoading: false,
          successMessage: LocaleKeys.success_import.tr(),
          errorMessage: null,
        );
      } else {
        ref.invalidateSelf();
        state = state.copyWith(
            isLoading: false,
            successMessage: null,
            errorMessage: null,
            isCancel: true);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        successMessage: null,
        errorMessage: LocaleKeys.no_valid_data.tr(),
      );
    }
  }

  @override
  RiverpodActionsCommonState build() => RiverpodActionsCommonState(
      isLoading: true,
      successMessage: null,
      errorMessage: null,
      isCancel: null);
}
