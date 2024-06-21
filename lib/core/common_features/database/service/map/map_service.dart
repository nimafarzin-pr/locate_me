import '../../db/db.dart';

abstract class IMapService<T, C> {
  Future<void> updateSetting(MapSettings mapSettings);
  Future<MapSettings?> getSetting();
  Stream<MapSettings?> watchSettings();
}
