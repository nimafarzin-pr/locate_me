// Define the state notifier
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/provider/app_settings_repository_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../home/model/place_item_model.dart';

class DataNotifier extends AsyncNotifier<List<PlaceItemModel>> {
  Future<void> exportData() async {
    try {
      final repo = ref.read(appSettingsRepositoryProvider);
      final data = await repo.getExportedData();
      final jsonString = jsonEncode(data);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/locations_export.json');
      await file.writeAsString(jsonString);
      await Share.shareXFiles([XFile(file.path)],
          text: 'Exported Location Data');
    } catch (e) {
      log('EXPORT ERROR: $e');
    }
  }

  Future<void> importData() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null && result.files.single.path != null) {
    //   final file = File(result.files.single.path!);
    //   final jsonString = await file.readAsString();
    //   final data = jsonDecode(jsonString);

    //   await DB().importLocationData(data);
    // }
  }

  @override
  List<PlaceItemModel> build() {
    return [];
  }
}
