import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_item_model.freezed.dart';
part 'place_item_model.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String title,
    required String address,
    required String distance,
    required String date,
    required LatLong latlng,
    required String icon,
    required double rate,
    required bool isSaved,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

@freezed
class LatLong with _$LatLong {
  const factory LatLong({
    required double latitude,
    required double longitude,
  }) = _LatLong;

  factory LatLong.fromJson(Map<String, dynamic> json) =>
      _$LatLongFromJson(json);
}
