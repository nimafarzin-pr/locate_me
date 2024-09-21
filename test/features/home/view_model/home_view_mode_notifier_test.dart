import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/core/common_features/map/core/enums/map_enum.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';

void main() {
  test('homeViewModeProvider initial state is list', () {
    final container = createContainer();

    final initialState = container.read(homeViewModeProvider);
    expect(initialState, HomeViewMode.list);
  });

  test('homeViewModeProvider state can be updated', () {
    final container = createContainer();
    final notifier = container.read(homeViewModeProvider.notifier);
    // Update the state
    notifier.state = HomeViewMode.map;

    final updatedState = container.read(homeViewModeProvider);
    expect(updatedState, equals(HomeViewMode.map));
  });

  test('selectedEditStateProviderForEditAndView state can be reset to list',
      () {
    final container = createContainer();

    final notifier = container.read(homeViewModeProvider.notifier);

    // Update the state
    notifier.state = HomeViewMode.map;

    // Reset the state
    notifier.state = HomeViewMode.list;

    final resetState = container.read(homeViewModeProvider);
    expect(resetState, HomeViewMode.list);
  });
}
