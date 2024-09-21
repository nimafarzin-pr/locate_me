import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';

void main() {
  test('HomeCategoryNotifier initial state is the default category', () {
    final container = createContainer();

    final homeCategoryNotifier = container.read(categoryFilterProvider);

    expect(
      homeCategoryNotifier,
      const CategoryModel(name: 'all'),
    );
  });

  test('HomeCategoryNotifier updates the state with a new category', () {
    final container = createContainer();

    final homeCategoryNotifier =
        container.read(categoryFilterProvider.notifier);

    const newCategory = CategoryModel(name: 'newCategory');
    homeCategoryNotifier.updateCategory(newCategory);

    final updatedCategory = container.read(categoryFilterProvider);
    expect(
      updatedCategory,
      newCategory,
    );
  });
}
