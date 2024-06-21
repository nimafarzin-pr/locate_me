import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/map/model/map_settings_model.dart';

import '../../database/provider/db_provider.dart';

final mapSettingStreamProvider = StreamProvider<MapSettingsModel>((ref) async* {
  final req = ref.read(mapDBSettingRepositoryProvider);
  final setting = req.watchSettings();
  yield* setting;
});
