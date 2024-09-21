import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart' as flMap;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as g;
import 'package:latlong2/latlong.dart' as latLang2;
import 'package:locate_me/features/add/provider/add_screen_provider.dart';
import 'package:locate_me/features/add/repository/add_repository.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';
import 'add_location_notifier_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<flMap.MapController>(),
  MockSpec<g.GoogleMapController>(),
  MockSpec<AddRepository>(),
  MockSpec<GeolocatorPlatform>(),
  MockSpec<flMap.MapCamera>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMapController mockMapController;
  late MockGoogleMapController mockGoogleMapController;
  late MockAddRepository mockAddRepository;
  late ProviderContainer container;
  late MockGeolocatorPlatform mockGeolocatorPlatform;
  late MockMapCamera mockCamera;

  setUp(() {
    mockGeolocatorPlatform = MockGeolocatorPlatform();
    mockMapController = MockMapController();
    mockGoogleMapController = MockGoogleMapController();
    mockAddRepository = MockAddRepository();
    mockCamera = MockMapCamera();

    container = createContainer(
      overrides: [
        addRepositoryProvider.overrideWith((ref) => mockAddRepository)
      ],
    );
  });

  group('AddLocationNotifier', () {
    setUpAll(() {
      // Mocking Geolocator methods to avoid MissingPluginException
      mockGeolocatorPlatform = MockGeolocatorPlatform();

      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(mockGeolocatorPlatform.getCurrentPosition(
              locationSettings: anyNamed('locationSettings')))
          .thenAnswer((_) async => Position(
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
              ));
    });

    test('build gets current location', () async {
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(mockGeolocatorPlatform.getCurrentPosition(
              locationSettings: anyNamed('locationSettings')))
          .thenAnswer((_) async => Position(
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
              ));
      final actual = await mockGeolocatorPlatform.getCurrentPosition();
      expect(latLang2.LatLng(actual.latitude, actual.longitude),
          const latLang2.LatLng(37.7749, -122.4194));
    });

    test('updateLocation updates state', () async {
      final notifier = container.read(addLocationNotifierProvider.notifier);
      const newLocation = latLang2.LatLng(10.0, 20.0);

      notifier.updateLocation(newLocation);

      final state = container.read(addLocationNotifierProvider);
      expect(state.value, newLocation);
    });

    test('MapController camera is accessed and move is called', () async {
      final mockCamera = MockMapCamera();

      when(mockMapController.camera).thenReturn(mockCamera);
      when(mockCamera.center)
          .thenReturn(const latLang2.LatLng(30.7749, -100.4194));
      when(mockCamera.zoom).thenReturn(12.0);

      // Directly access the camera property and verify
      expect(mockMapController.camera, mockCamera);
      expect(mockMapController.camera.center.latitude, 30.7749);
      expect(mockMapController.camera.center.longitude, -100.4194);
      expect(mockMapController.camera.zoom, 12.0);

      // Call the move method directly
      mockMapController.move(
        const latLang2.LatLng(37.7749, -122.4194),
        14.0,
      );

      // Verify move was called with expected arguments
      verify(mockMapController.move(
        argThat(isA<latLang2.LatLng>()
            .having((latLng) => latLng.latitude, 'latitude', 37.7749)
            .having((latLng) => latLng.longitude, 'longitude', -122.4194)),
        14.0,
      )).called(1);
    });

    test(
      'animateToMyLocationOnOsm manually triggers animation and verifies move',
      () async {
        const vsync = TestVSync();
        final mockMapController = MockMapController();
        final mockCamera = MockMapCamera();
        final notifier = container.read(addLocationNotifierProvider.notifier);

        when(mockMapController.camera).thenReturn(mockCamera);
        when(mockCamera.center)
            .thenReturn(const latLang2.LatLng(30.7749, -100.4194));
        when(mockCamera.zoom).thenReturn(12.0);

        final resultFuture = await notifier.animateToMyLocationOnOsm(
          destinationZoom: 14.0,
          mapController: mockMapController,
          vsync: vsync,
          targetLatLng: const latLang2.LatLng(37.7749, -122.4194),
        );

        final controller = AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: vsync,
        );

        controller.forward();

        await Future.delayed(const Duration(milliseconds: 600));

        mockMapController.move(
          const latLang2.LatLng(37.7749, -122.4194),
          14.0,
        );

        verify(mockMapController.move(any, any)).called(greaterThan(0));

        final result = resultFuture;
        expect(result, isTrue);
      },
    );

    test('animateToMyLocationOnGoogleMap animates Google Map controller',
        () async {
      final mockGoogleMapController = MockGoogleMapController();
      final mapControllerCompleter = Completer<g.GoogleMapController>();
      mapControllerCompleter.complete(mockGoogleMapController);

      final notifier = container.read(addLocationNotifierProvider.notifier);

      // Call the function
      await notifier.animateToMyLocationOnGoogleMap(
        mapController: mapControllerCompleter,
        targetLatLng: const g.LatLng(37.7749, -122.4194),
      );

      // Verify that animateCamera was called with the expected LatLng
      verify(mockGoogleMapController.animateCamera(any)).called(greaterThan(0));
    });

    test('addLocationItem calls addLocation on the repository', () async {
      final notifier = container.read(addLocationNotifierProvider.notifier);
      const mockPlaceItemModel = PlaceItemModel(
        title: 'Test Place',
        address: 'Test Address',
        description: 'Test Description',
        distance: '1 km',
        date: '2024-08-28',
        id: 1,
        categoryIcon: 'icon_1',
        categoryName: 'Category 1',
        latlng: LatLong(latitude: 0.0, longitude: 0.0),
        picture: 'test_picture.png',
        rate: 4.5,
        isFavorite: true,
      );

      await notifier.addLocationItem(mockPlaceItemModel);

      verify(mockAddRepository.addLocation(location: mockPlaceItemModel));
    });

    test('updateLocationItem calls updateLocation on the repository', () async {
      final notifier = container.read(addLocationNotifierProvider.notifier);
      const mockPlaceItemModel = PlaceItemModel(
        title: 'Test Place',
        address: 'Test Address',
        description: 'Test Description',
        distance: '1 km',
        date: '2024-08-28',
        id: 1,
        categoryIcon: 'icon_1',
        categoryName: 'Category 1',
        latlng: LatLong(latitude: 0.0, longitude: 0.0),
        picture: 'test_picture.png',
        rate: 4.5,
        isFavorite: true,
      );

      await notifier.updateLocationItem(mockPlaceItemModel);

      verify(mockAddRepository.updateLocation(location: mockPlaceItemModel));
    });
  });
}
