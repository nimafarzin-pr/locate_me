import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/map/provider/map_setting_provider.dart';

import '../../database/provider/db_provider.dart';
import '../model/map_settings_model.dart';

class MapSettingNotifier extends AutoDisposeAsyncNotifier<MapSettingsModel> {
  MapSettingNotifier() : super();

  void updateSettings(MapSettingsModel setting) async {
    final req = ref.read(mapDBSettingRepositoryProvider);
    await req.updateSetting(setting);
  }

  @override
  Future<MapSettingsModel> build() async {
    final setting = await ref.watch(mapSettingStreamProvider.future);
    final data = MapSettingsModel(
        mapLayer: setting.mapLayer, mapStyle: setting.mapStyle);
    state = AsyncData(data);
    return data;
  }
}
