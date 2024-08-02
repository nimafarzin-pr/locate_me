import 'dart:developer';

import 'package:locate_me/core/common_features/database/repository/map/map_repository.dart';
import 'package:locate_me/core/common_features/database/service/map/map_service_impl.dart';
import 'package:locate_me/core/common_features/database/type_converter/map_setting_converter.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/core/common_features/map/model/map_settings_model.dart';

class MapRepositoryImpl implements IMapRepository {
  final MapServiceImpl _mapServiceImpl;

  MapRepositoryImpl(this._mapServiceImpl);

  @override
  Future<void> updateSetting(MapSettingsModel entry) async {
    try {
      final toSql = const MapSettingsConverter().toSql(
        MapSettingsModel(mapLayer: entry.mapLayer, mapStyle: entry.mapStyle),
      );
      await _mapServiceImpl.updateSetting(toSql);
    } catch (e, stackTrace) {
      log('Error updating setting: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<MapSettingsModel> getSetting() async {
    try {
      final data = await _mapServiceImpl.getSetting();
      if (data != null) {
        final toModel = const MapSettingsConverter().fromSql(data);
        return toModel;
      }
      return const MapSettingsModel(
        mapLayer: MapLayer.osm,
        mapStyle: MapStyle.standard,
      );
    } catch (e, stackTrace) {
      log('Error getting setting: $e', stackTrace: stackTrace);
      return const MapSettingsModel(
        mapLayer: MapLayer.osm,
        mapStyle: MapStyle.standard,
      );
    }
  }

  @override
  Stream<MapSettingsModel> watchSettings() {
    return _mapServiceImpl.watchSettings().map<MapSettingsModel>((event) {
      try {
        if (event != null) {
          final toModel = const MapSettingsConverter().fromSql(event);
          return toModel;
        } else {
          return const MapSettingsModel(
            mapLayer: MapLayer.osm,
            mapStyle: MapStyle.standard,
          );
        }
      } catch (e, stackTrace) {
        log('Error watching settings: $e', stackTrace: stackTrace);
        return const MapSettingsModel(
          mapLayer: MapLayer.osm,
          mapStyle: MapStyle.standard,
        );
      }
    }).handleError((e, stackTrace) {
      log('Error in watchSettings stream: $e', stackTrace: stackTrace);
    });
  }
}
