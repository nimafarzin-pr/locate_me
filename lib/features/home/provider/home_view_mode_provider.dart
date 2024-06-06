import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helper/map/enums/map_enum.dart';
import '../view_model/home_view_mode_notifier.dart';

final homeViewModeProvider =
    NotifierProvider<HomeViewModeNotifier, HomeViewMode>(
        HomeViewModeNotifier.new);
