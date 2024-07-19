import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/view_model/category_notifier.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

final categoryFilterProvider =
    NotifierProvider<HomeCategoryNotifier, CategoryModel>(
        HomeCategoryNotifier.new);
