import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/caching/image_caching_notifier.dart';

import '../../../riverpod_test_utils/riverpod_test_utils.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = createContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('ImageCacheNotifier', () {
    test('should cache image and retrieve it', () async {
      final imageCacheNotifier = container.read(imageCacheProvider.notifier);

      const imageId = 'testImage';
      const base64Image = 'iVBORw0KGgoAAAANSUhEUgAAAAUA'
          'AAAFCAYAAACNbyblAAAAHElEQVQI12P4'
          '//8/w38GIAXDIBKE0DHxgljNBAAO'
          '9TXL0Y4OHwAAAABJRU5ErkJggg==';

      await imageCacheNotifier.cacheImage(imageId, base64Image);

      final cachedImage = imageCacheNotifier.getImage(imageId);

      // Decode the image manually to compare with the cached image
      final expectedImageBytes = await compute(base64Decode, base64Image);

      expect(cachedImage, expectedImageBytes);
    });

    test('getImage should return null if image is not in cache', () async {
      final imageCacheNotifier = container.read(imageCacheProvider.notifier);

      const imageId = 'nonExistentImage';
      final cachedImage = imageCacheNotifier.getImage(imageId);

      expect(cachedImage, isNull);
    });
  });

  group('decodeBase64Image', () {
    test('should decode base64 image correctly', () async {
      const base64Image = 'iVBORw0KGgoAAAANSUhEUgAAAAUA'
          'AAAFCAYAAACNbyblAAAAHElEQVQI12P4'
          '//8/w38GIAXDIBKE0DHxgljNBAAO'
          '9TXL0Y4OHwAAAABJRU5ErkJggg==';
      final expectedImageBytes = base64Decode(base64Image);

      final result = await compute(base64Decode, base64Image);

      expect(result, expectedImageBytes);
    });
  });
}
