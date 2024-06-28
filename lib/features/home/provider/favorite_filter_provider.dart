import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/map/core/enums/map_enum.dart';
import '../view_model/favorite_notifier.dart';

final favoriteFilterProvider =
    NotifierProvider<FavoriteNotifier, ItemViewState>(FavoriteNotifier.new);
