import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;
import 'package:latlong2/latlong.dart';
import 'package:locate_me/features/home/model/dto/slider_notifier_dto.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/home_screen_provider.dart';
import 'package:locate_me/features/home/view_model/slider_notifier.dart';
import 'package:mocktail/mocktail.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';

// Mocks
class MockOSMController extends Mock implements MapController {}

class MockGoogleMapController extends Mock
    implements googleMap.GoogleMapController {}

class MockTickerProvider extends Mock implements TickerProvider {}

class MockCamera extends Mock implements MapCamera {}

// Fallback Class for CameraUpdate
class FakeCameraUpdate extends Fake implements googleMap.CameraUpdate {}

class MyFakeLatLng extends Fake implements LatLng {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late MockOSMController mockOsmController;
  late MockGoogleMapController mockGoogleMapController;
  late MockTickerProvider mockVsync;
  late MockCamera mockCamera;

  setUpAll(() {
    // Register a fallback for CameraUpdate
    registerFallbackValue(MyFakeLatLng());
    registerFallbackValue(FakeCameraUpdate());
  });

  setUp(() {
    mockOsmController = MockOSMController();
    mockGoogleMapController = MockGoogleMapController();
    mockVsync = MockTickerProvider();
    mockCamera = MockCamera();

    // Mock the creation of a Ticker
    when(() => mockVsync.createTicker(any())).thenReturn(FakeTicker());

    container = createContainer();
  });

  test('SliderNotifier animates to the specified location on OSM', () async {
    // Arrange
    when(() => mockOsmController.camera).thenReturn(mockCamera);
    when(() => mockCamera.center).thenReturn(const LatLng(12.34, 56.78));
    when(() => mockCamera.zoom).thenReturn(10.0);

    const position = PlaceItemModel(
      title: 'Test Place',
      address: '123 Test St',
      categoryIcon: 'test_icon',
      categoryName: 'Test Category',
      latlng: LatLong(latitude: 12.34, longitude: 56.78),
      picture: 'test_picture',
    );

    final args = SliderNotifierDTO(
      mapController: mockOsmController,
      position: position,
      vsync: mockVsync,
    );

    // Act
    final notifier = container.read(sliderNotifierProvider(args).notifier);
    final result = notifier.build(args);

    // Assert
    expect(result, position);
  });

  test('SliderNotifier animates to the specified location on Google Maps',
      () async {
    // Arrange
    final completer = Completer<googleMap.GoogleMapController>();
    completer.complete(mockGoogleMapController);

    const position = LatLong(latitude: 12.34, longitude: 56.78);

    when(() => mockGoogleMapController.animateCamera(any()))
        .thenAnswer((_) async {});

    // Act
    final notifier = SliderNotifier();
    final result = await notifier.animateToMyLocationOnGoogleMap(
      mapController: completer,
      position: position,
    );
    expect(result, position);
  });
}

// Mocking a Ticker class to be used in the test
class FakeTicker extends Ticker {
  FakeTicker() : super((_) {});
}
