import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../view_model/home_view_mode_notifier.dart';

final homeViewModeProvider =
    NotifierProvider<HomeViewModeNotifier, HomeViewMode>(
        HomeViewModeNotifier.new);
