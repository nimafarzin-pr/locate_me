import 'package:locate_me/core/helper/map/model/map_settings_model.dart';

abstract class IMapRepository {
  Future<void> updateSetting(MapSettingsModel entry);
  Future<MapSettingsModel> getSetting();
  Stream<MapSettingsModel> watchSettings();
}
