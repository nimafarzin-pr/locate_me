import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/db/db.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

class DBCategoryConverter extends TypeConverter<CategoryModel, Categories> {
  const DBCategoryConverter();

  @override
  CategoryModel fromSql(Categories fromDb) {
    return CategoryModel(
        iconString: fromDb.emoji,
        name: fromDb.name,
        id: fromDb.id,
        color: fromDb.color);
  }

  @override
  Categories toSql(CategoryModel value) {
    return Categories(
        id: value.id ?? 0,
        name: value.name,
        emoji: value.iconString,
        color: value.color);
  }
}
