import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/search_debouncing/search_debouncing_notifier.dart';

final searchInputProvider =
    StateNotifierProvider<DebouncedSearchNotifier, String>(
  (ref) => DebouncedSearchNotifier(),
);
