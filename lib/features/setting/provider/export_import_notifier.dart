import 'package:locate_me/core/riverpod/riverpod_actions_common_state.dart';
import 'package:riverpod/riverpod.dart';

import '../viewmodel/export_notifier.dart';
import '../viewmodel/import_state.dart';

final exportNotifierProvider =
    StateNotifierProvider<ExportNotifier, RiverpodActionsCommonState>((ref) {
  return ExportNotifier();
});

final importNotifierProvider =
    StateNotifierProvider<ImportNotifier, RiverpodActionsCommonState>((ref) {
  return ImportNotifier();
});
