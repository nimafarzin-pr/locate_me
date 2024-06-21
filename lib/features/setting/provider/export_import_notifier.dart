import 'package:riverpod/riverpod.dart';

import '../../home/model/place_item_model.dart';
import '../viewmodel/export_import_notifier.dart';

final exportAndImportNotifierProvider =
    AsyncNotifierProvider<DataNotifier, List<PlaceItemModel>>(DataNotifier.new);
