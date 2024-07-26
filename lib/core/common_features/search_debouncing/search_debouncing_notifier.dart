import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebouncedSearchNotifier extends StateNotifier<String> {
  DebouncedSearchNotifier() : super('');

  Timer? _debounce;

  void setSearchQuery(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      state = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
