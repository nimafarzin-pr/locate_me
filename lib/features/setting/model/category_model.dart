import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@Freezed(copyWith: true, toJson: true, fromJson: true)
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @Default("") String name,
    @Default("") String iconString,
    @Default(0) int color,
    int? id,
  }) = _Category;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
