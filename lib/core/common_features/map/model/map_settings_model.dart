import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/enums/map_enum.dart';

part 'map_settings_model.freezed.dart';
part 'map_settings_model.g.dart';

@Freezed(fromJson: true, toJson: true, copyWith: true)
class MapSettingsModel with _$MapSettingsModel {
  const factory MapSettingsModel({
    MapLayer? mapLayer,
    MapStyle? mapStyle,
  }) = _MapSettingsModel;

  factory MapSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$MapSettingsModelFromJson(json);
}
