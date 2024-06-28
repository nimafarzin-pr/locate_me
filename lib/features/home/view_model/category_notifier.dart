import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/category/enums/category.dart';

class CategoryNotifier extends Notifier<CategoryEnums> {
  @override
  CategoryEnums build() => CategoryEnums.all;

  void updateCategory(CategoryEnums newValue) => state = newValue;
}
