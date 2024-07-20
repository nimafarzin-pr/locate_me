import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../provider/app_settings_repository_provider.dart';

class CategoryNotifier extends AutoDisposeStreamNotifier<List<CategoryModel>> {
  @override
  Stream<List<CategoryModel>> build() => loadData();

  Stream<List<CategoryModel>> loadData() async* {
    final repo = ref.read(appSettingsRepositoryProvider);
    final dataStream = repo.watchCategories();

    await for (final data in dataStream) {
      final combinedData = [
        CategoryModel(
          name: 'all',
          iconString: IconPickerUtils.iconPickerSerializer(
            IconPickerUtils.iconPickerDeserializer(
              IconPickerUtils.iconPickerSerializer(Icons.place),
            )!,
          ),
          color: Colors.grey.value,
        ),
        ...data
      ];

      yield combinedData;
    }
  }

  void addCategory(CategoryModel category) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.addCategory(category.name, category.iconString, category.color);
  }

  void deleteCategory(int id) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.deleteCategory(id);
  }
}
