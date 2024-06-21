import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/map/view_model/map_setting_notifier.dart';

import '../core/enums/map_enum.dart';
import '../model/map_settings_model.dart';

final mapSettingNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MapSettingNotifier, MapSettingsModel>(
        MapSettingNotifier.new);

final mapSettingLayerNotifierProvider =
    StreamProvider.autoDispose<MapLayer>((ref) async* {
  final data = await ref
      .watch(mapSettingNotifierProvider.selectAsync((data) => data.mapLayer));
  yield data ?? MapLayer.osm;
});
final mapSettingStyleNotifierProvider =
    StreamProvider.autoDispose<MapStyle>((ref) async* {
  final data = await ref
      .watch(mapSettingNotifierProvider.selectAsync((data) => data.mapStyle));
  yield data ?? MapStyle.standard;
});
