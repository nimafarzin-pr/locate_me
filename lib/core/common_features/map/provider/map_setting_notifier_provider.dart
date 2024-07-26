import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/map/view_model/map_setting_notifier.dart';

import '../core/enums/map_enum.dart';
import '../model/map_settings_model.dart';

final mapSettingNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MapSettingNotifier, MapSettingsModel>(
        MapSettingNotifier.new);

final mapSettingLayerNotifierProvider =
    FutureProvider.autoDispose<MapLayer>((ref) async {
  final data = await ref.watch(mapSettingNotifierProvider.future);
  return data.mapLayer ?? MapLayer.osm;
});

final mapSettingStyleNotifierProvider =
    FutureProvider.autoDispose<MapStyle>((ref) async {
  final data = await ref.watch(mapSettingNotifierProvider.future);
  return data.mapStyle ?? MapStyle.standard;
});
