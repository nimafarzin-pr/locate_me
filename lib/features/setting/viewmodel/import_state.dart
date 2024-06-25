import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/utils/encrypt_utils.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../core/riverpod/riverpod_actions_common_state.dart';
import '../../home/model/place_item_model.dart';
import '../provider/app_settings_repository_provider.dart';

class ImportNotifier extends StateNotifier<RiverpodActionsCommonState> {
  ImportNotifier() : super(RiverpodActionsCommonState());

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
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final decode =
            json.decode(EncryptUtils.base64ToJson(jsonString)) as List<dynamic>;
        final List<PlaceItemModel> data = decode
            .map((e) => PlaceItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (data.isNotEmpty) {
          final ref = ProviderContainer();
          final repo = ref.read(appSettingsRepositoryProvider);
          await repo.importData(data);
          state = state.copyWith(
            isLoading: false,
            successMessage: LocaleKeys.success_import.tr(),
            errorMessage: null,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            successMessage: null,
            errorMessage: LocaleKeys.no_valid_data.tr(),
          );
        }
      } else {
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
}
