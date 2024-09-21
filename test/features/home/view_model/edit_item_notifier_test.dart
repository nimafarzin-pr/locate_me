import 'package:flutter_test/flutter_test.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';

void main() {
  test('selectedEditStateProviderForEditAndView initial state is null', () {
    final container = createContainer();

    final initialState = container.read(selectedEditStateProviderForEditView);
    expect(initialState, isNull);
  });

  test('selectedEditStateProviderForEditAndView state can be updated', () {
    final container = createContainer();

    const placeItem = PlaceItemModel(
      title: 'Test Place',
      address: '123 Test St',
      categoryIcon: 'test_icon',
      categoryName: 'Test Category',
      latlng: LatLong(
          latitude: 12.34,
          longitude: 56.78), // Assuming LatLong takes two doubles
      picture: 'test_picture',
    );

    final notifier =
        container.read(selectedEditStateProviderForEditView.notifier);

    // Update the state
    notifier.state = placeItem;

    final updatedState = container.read(selectedEditStateProviderForEditView);
    expect(updatedState, equals(placeItem));
  });

  test('selectedEditStateProviderForEditAndView state can be reset to null',
      () {
    final container = createContainer();

    const placeItem = PlaceItemModel(
      title: 'Test Place',
      address: '123 Test St',
      categoryIcon: 'test_icon',
      categoryName: 'Test Category',
      latlng: LatLong(latitude: 12.34, longitude: 56.78),
      picture: 'test_picture',
    );

    final notifier =
        container.read(selectedEditStateProviderForEditView.notifier);

    // Update the state
    notifier.state = placeItem;

    // Reset the state
    notifier.state = null;

    final resetState = container.read(selectedEditStateProviderForEditView);
    expect(resetState, isNull);
  });
}
