import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/local/db/db.dart';

import '../../../map/core/enums/map_enum.dart';
import '../../../map/model/map_settings_model.dart';

class DBMapLayerConverter extends TypeConverter<MapLayer, int> {
  const DBMapLayerConverter();

  @override
  MapLayer fromSql(int fromDb) {
    return MapLayer.values[fromDb];
  }

  @override
  int toSql(MapLayer value) {
    return value.index;
  }
}

class MapStyleConverter extends TypeConverter<MapStyle, int> {
  const MapStyleConverter();

  @override
  MapStyle fromSql(int fromDb) {
    return MapStyle.values[fromDb];
  }

  @override
  int toSql(MapStyle value) {
    return value.index;
  }
}

class MapSettingsConverter
    extends TypeConverter<MapSettingsModel, MapSettings> {
  const MapSettingsConverter();

  @override
  MapSettingsModel fromSql(MapSettings fromDb) {
    return MapSettingsModel(
      mapLayer: fromDb.mapLayer,
      mapStyle: fromDb.mapStyle,
    );
  }

  @override
  MapSettings toSql(MapSettingsModel value) {
    return MapSettings(
        id: 0, mapLayer: value.mapLayer, mapStyle: value.mapStyle);
  }
}
