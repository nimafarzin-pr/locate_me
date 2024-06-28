import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/view_model/category_notifier.dart';

import '../../../core/common_features/category/enums/category.dart';

final categoryFilterProvider =
    NotifierProvider<CategoryNotifier, CategoryEnums>(CategoryNotifier.new);
