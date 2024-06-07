import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/enums/enums.dart';

class CategoryNotifier extends Notifier<CategoryEnums> {
  @override
  CategoryEnums build() => CategoryEnums.all;

  void updateCategory(CategoryEnums newValue) => state = newValue;
}
