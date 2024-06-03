import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/helper/map/provider/map_setting_provider.dart';

import '../../../database/provider/db_provider.dart';
import '../model/map_settings_model.dart';

class MapSettingNotifier extends AutoDisposeAsyncNotifier<MapSettingsModel> {
  MapSettingNotifier() : super();

  void updateSettings(MapSettingsModel setting) async {
    final req = ref.read(mapSettingRepositoryProvider);
    await req.updateSetting(setting);

    // final previousState = await future;

    final newSetting = await ref.watch(mapSettingStreamProvider.future);
    log('>>>>>>>$newSetting');
  }

  // void updateLayer(MapSettingsModel layer) {
  //   final req = ref.read(mapSettingRepositoryProvider);
  //   final newData = const MapSettingsModel().copyWith(mapLayer: layer.mapLayer);
  //   req.updateSetting(newData);
  //   state = AsyncData(newData);
  // }

  // void updateStyle(MapSettingsModel style) {
  //   log('${style.mapLayer}');
  //   final req = ref.read(mapSettingRepositoryProvider);
  //   final newData = const MapSettingsModel().copyWith(mapStyle: style.mapStyle);
  //   req.updateSetting(newData);
  //   state = AsyncData(newData);
  // }

  @override
  Future<MapSettingsModel> build() async {
    final setting = await ref.watch(mapSettingStreamProvider.future);
    final data = MapSettingsModel(
        mapLayer: setting.mapLayer, mapStyle: setting.mapStyle);
    state = AsyncData(data);
    return data;
  }
}
