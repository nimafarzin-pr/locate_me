import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/model/category_model.dart';
import 'package:locate_me/features/setting/view/viewmodel/category_notifier.dart';

final categoryNotifierProvider =
    AutoDisposeStreamNotifierProvider<CategoryNotifier, List<CategoryModel>>(
        CategoryNotifier.new);
