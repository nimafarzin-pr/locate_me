import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/core/common_features/database/local/provider/db_provider.dart';
import 'package:locate_me/core/common_features/database/local/repository/location/location_repository_impl.dart';
import 'package:locate_me/core/common_features/map/core/google_map/model/dto/single_marker_dto.dart';
import 'package:locate_me/core/common_features/map/core/google_map/provider/location_provider.dart';
import 'package:locate_me/features/add/provider/add_screen_provider.dart';
import 'package:locate_me/features/add/repository/add_repository.dart';
import 'package:locate_me/features/add/view/view_model/add_location_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:latlong2/latlong.dart' as latLang2;

import '../../../riverpod_test_utils/riverpod_test_utils.dart';
import 'add_screen_provider_test.mocks.dart';

// Mock your necessary dependencies (e.g., GeolocatorPlatform, DB providers)

@GenerateNiceMocks([
  MockSpec<AddLocationNotifier>(),
  MockSpec<AddRepository>(),
  MockSpec<LocationRepositoryImpl>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late MockAddLocationNotifier mockAddLocationNotifier;
  late MockAddRepository mockAddRepository;
  late MockLocationRepositoryImpl mockLocationRepositoryImpl;

  group(
    'addLocationNotifierProvider provides a LatLng',
    () {
      setUp(() {
        mockAddLocationNotifier = MockAddLocationNotifier();
        container = createContainer(
          overrides: [
            addRepositoryProvider.overrideWith((ref) => mockAddRepository),
          ],
        );
      });
      test('addLocationNotifierProvider provides a LatLng', () async {
        final state = container.read(addLocationNotifierProvider.notifier);
        state.updateLocation(const latLang2.LatLng(37.7749, -122.4194));

        final result = await container.read(addLocationNotifierProvider.future);

        expect(result, isA<latLang2.LatLng>());
        expect(result.latitude, 37.7749);
        expect(result.longitude, -122.4194);
      });
    },
  );
  group('listenablePositionProvider', () {
    setUp(() {
      container = createContainer(
        overrides: [
          positionProvider.overrideWith((ref, streamController) async* {
            yield Position(
              latitude: 37.7749,
              longitude: -122.4194,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
              altitudeAccuracy: 0,
              headingAccuracy: 0,
            );
          }),
        ],
      );
    });

    test('should return the current position', () async {
      final result = await container.read(listenablePositionProvider.future);

      expect(result?.latitude, 37.7749);
      expect(result?.longitude, -122.4194);
    });
  });

  group('googleMapCurrentPositionProvider', () {
    setUp(() {
      mockAddLocationNotifier = MockAddLocationNotifier();
      mockAddRepository = MockAddRepository();
      mockLocationRepositoryImpl = MockLocationRepositoryImpl();
      container = createContainer(
        overrides: [
          addRepositoryProvider.overrideWith((ref) => mockAddRepository),
          locationDBRepositoryProvider
              .overrideWithValue(mockLocationRepositoryImpl),
        ],
      );
    });

    test('should return latLng with correct location', () async {
      final notifier = container.read(addLocationNotifierProvider.notifier);
      const newLocation = latLang2.LatLng(37.7749, -122.4194);

      notifier.updateLocation(newLocation);

      final state = container.read(addLocationNotifierProvider);

      // Verify that the correct latitude and longitude were returned
      expect(state.value?.latitude, 37.7749);
      expect(state.value?.longitude, -122.4194);
    });

    test('should return SingleMarkerDto with correct location', () async {
      final notifier = container.read(addLocationNotifierProvider.notifier);
      const newLocation = latLang2.LatLng(37.7749, -122.4194);

      notifier.updateLocation(newLocation);

      // Test the googleMapCurrentPositionProvider based on the mocked notifier
      final result =
          await container.read(googleMapCurrentPositionProvider.future);

      expect(result, isA<SingleMarkerDto>());
      expect(result.location.lat, 37.7749);
      expect(result.location.lng, -122.4194);
      expect(result.customIcon, BitmapDescriptor.defaultMarker);
    });
  });

// Mock classes

  group('addRepositoryProvider provides an instance of AddRepository', () {
    setUp(() {
      mockLocationRepositoryImpl = MockLocationRepositoryImpl();
      container = createContainer(
        overrides: [
          locationDBRepositoryProvider
              .overrideWithValue(mockLocationRepositoryImpl),
        ],
      );
    });

    test('addRepositoryProvider provides an instance of AddRepository',
        () async {
      final result = await container.read(addRepositoryProvider.future);

      expect(result, isA<AddRepository>());
    });
  });
}
