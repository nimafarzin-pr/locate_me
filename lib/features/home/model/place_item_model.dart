import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleLatLng;
import 'package:latlong2/latlong.dart';

part 'place_item_model.freezed.dart';
part 'place_item_model.g.dart';

@Freezed(copyWith: true, toJson: true, fromJson: true)
class PlaceItemModel with _$PlaceItemModel {
  const factory PlaceItemModel({
    required String title,
    required String address,
    @Default("") String description,
    @Default("") String distance,
    @Default("") String date,
    int? id,
    required String categoryIcon,
    required String categoryName,
    required LatLong latlng,
    required String picture,
    @Default(0) double rate,
    @Default(false) bool isFavorite,
  }) = _Place;

  factory PlaceItemModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceItemModelFromJson(json);
}

@Freezed(copyWith: true, toJson: true, fromJson: true)
class LatLong with _$LatLong {
  const factory LatLong({
    required double latitude,
    required double longitude,
  }) = _LatLong;

  factory LatLong.fromJson(Map<String, dynamic> json) =>
      _$LatLongFromJson(json);

  factory LatLong.fromLatLang2(LatLng latlng) {
    return LatLong(latitude: latlng.latitude, longitude: latlng.longitude);
  }
  factory LatLong.fromGoogleLatLong(googleLatLng.LatLng latlng) {
    return LatLong(latitude: latlng.latitude, longitude: latlng.longitude);
  }
}
