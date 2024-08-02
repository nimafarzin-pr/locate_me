import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_map_dto.freezed.dart';
part 'google_map_dto.g.dart';

@freezed
class GoogleMapDto with _$GoogleMapDto {
  factory GoogleMapDto({
    required double lat,
    required double lng,
    String? placeMark,
    required String customIcon,
  }) = _GoogleMapDto;

  factory GoogleMapDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapDtoFromJson(json);
}
