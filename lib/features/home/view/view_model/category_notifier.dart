import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

class HomeCategoryNotifier extends Notifier<CategoryModel> {
  @override
  CategoryModel build() => const CategoryModel(name: 'all');

  void updateCategory(CategoryModel newValue) => state = newValue;
}
