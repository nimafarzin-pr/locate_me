import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../view_model/add_location_notifier.dart';

final addScreenLocationProvider =
    AsyncNotifierProvider.autoDispose<AddLocationNotifier, LatLng>(
        AddLocationNotifier.new);
