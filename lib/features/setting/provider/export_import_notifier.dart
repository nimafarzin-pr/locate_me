import 'package:locate_me/core/riverpod/riverpod_actions_common_state.dart';
import 'package:riverpod/riverpod.dart';

import '../view/viewmodel/export_notifier.dart';
import '../view/viewmodel/import_state.dart';

final exportNotifierProvider =
    AutoDisposeNotifierProvider<ExportNotifier, RiverpodActionsCommonState>(
        ExportNotifier.new);

final importNotifierProvider =
    NotifierProvider<ImportNotifier, RiverpodActionsCommonState>(
        ImportNotifier.new);
