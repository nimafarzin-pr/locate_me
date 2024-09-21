import 'package:riverpod/riverpod.dart';

class MyLocationButtonNotifier extends AutoDisposeNotifier<bool> {
  @override
  bool build() => false;

  updateLoadingState(bool newState) {
    state = newState;
  }
}

final myLocationButtonNotifierProvider =
    AutoDisposeNotifierProvider<MyLocationButtonNotifier, bool>(
        MyLocationButtonNotifier.new);
