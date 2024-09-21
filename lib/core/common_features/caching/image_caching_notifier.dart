import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageCacheNotifier extends StateNotifier<Map<String, Uint8List>> {
  ImageCacheNotifier() : super({});

  Future<void> cacheImage(String id, String base64Image) async {
    final imageBytes = await compute(base64Decode, base64Image);
    state = {
      ...state,
      id: imageBytes, // This will update if id exists, or add if it doesn't
    };
  }

  Uint8List? getImage(String id) {
    return state[id];
  }
}

final imageCacheProvider =
    StateNotifierProvider<ImageCacheNotifier, Map<String, Uint8List>>((ref) {
  return ImageCacheNotifier();
});
