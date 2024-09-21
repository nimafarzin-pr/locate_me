import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/caching/base64_dto.dart';
import 'package:locate_me/core/common_features/caching/image_byte_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('imageByteProvider', () {
    test('should cache and return the correct image bytes', () async {
      const imageId = 'testImageId';
      const base64Image = 'iVBORw0KGgoAAAANSUhEUgAAAAUA'
          'AAAFCAYAAACNbyblAAAAHElEQVQI12P4'
          '//8/w38GIAXDIBKE0DHxgljNBAAO'
          '9TXL0Y4OHwAAAABJRU5ErkJggg==';

      // Create the Base64DTO object with the image id and source
      final base64DTO = Base64DTO(id: imageId, source: base64Image);

      // Call the imageByteProvider with the Base64DTO object
      final result = await container.read(imageByteProvider(base64DTO).future);

      // Decode the base64 image manually for comparison
      final expectedImageBytes = base64Decode(base64Image);

      expect(result, expectedImageBytes);
    });

    test('should return empty if image does not exist in cache', () async {
      const imageId = 'nonExistentImageId';
      const base64Image = ''; // Empty string for non-existent image

      // Create the Base64DTO object
      final base64DTO = Base64DTO(id: imageId, source: base64Image);

      final result = await container.read(imageByteProvider(base64DTO).future);

      expect(result, isEmpty);
    });
  });
}
