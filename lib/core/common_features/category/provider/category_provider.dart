import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/setting/model/category_model.dart';
import '../notifier/category_notifier.dart';

final categoryNotifierProvider =
    AutoDisposeStreamNotifierProvider<CategoryNotifier, List<CategoryModel>>(
        CategoryNotifier.new);
