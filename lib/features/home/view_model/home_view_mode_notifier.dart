import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/map/core/enums/map_enum.dart';

class HomeViewModeNotifier extends Notifier<HomeViewMode> {
  @override
  HomeViewMode build() => HomeViewMode.list;

  void updateViewMode(HomeViewMode newValue) => state = newValue;
}
