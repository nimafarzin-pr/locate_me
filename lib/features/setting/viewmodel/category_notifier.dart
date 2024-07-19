import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../provider/app_settings_repository_provider.dart';

class CategoryNotifier extends AutoDisposeStreamNotifier<List<CategoryModel>> {
  @override
  Stream<List<CategoryModel>> build() => loadData();

  Stream<List<CategoryModel>> loadData() async* {
    final repo = ref.read(appSettingsRepositoryProvider);
    final data = repo.watchCategories();
    yield* data;
  }

  void addCategory(CategoryModel category) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.addCategory(category.name, category.emoji, category.color);
  }

  void deleteCategory(int id) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.deleteCategory(id);
  }
}
