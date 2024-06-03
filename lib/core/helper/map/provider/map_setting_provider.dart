import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/helper/map/model/map_settings_model.dart';

import '../../../database/provider/db_provider.dart';

final mapSettingStreamProvider = StreamProvider<MapSettingsModel>((ref) async* {
  final req = ref.read(mapSettingRepositoryProvider);
  final setting = req.watchSettings();
  log('>>>>>> 3 : $setting');
  yield* setting;
});
