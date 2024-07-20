import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageCacheNotifier extends StateNotifier<Map<String, Uint8List>> {
  ImageCacheNotifier() : super({});

  void cacheImage(String id, String base64Image) {
    if (!state.containsKey(id)) {
      try {
        final bytes = base64Decode(base64Image);
        state = {
          ...state,
          id: bytes,
        };
      } catch (e) {
        // Handle decoding error
        log('>>>>>>>>>> Error decoding base64 image: $e');
      }
    }
  }

  Uint8List? getImage(String id) {
    return state[id];
  }
}

final imageCacheProvider =
    StateNotifierProvider<ImageCacheNotifier, Map<String, Uint8List>>((ref) {
  return ImageCacheNotifier();
});
