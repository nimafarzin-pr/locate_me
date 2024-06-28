import 'package:riverpod/riverpod.dart';

class ButtonLoadingNotifier extends AutoDisposeNotifier<bool> {
  @override
  bool build() => false;

  updateLoadingState(bool newState) {
    state = newState;
  }
}
