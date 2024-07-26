import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/home/provider/filter_provider.dart';

import '../../../features/home/provider/location_provider.dart';

// class ImageCacheNotifier extends StateNotifier<Map<String, Uint8List>> {
//   final Ref ref;

//   ImageCacheNotifier(this.ref) : super({}) {
//     ref.listen<List<PlaceItemModel>>(filteredItemsProvider, (previous, next) {
//       _cacheImages(next);
//     });
//   }

//   void _cacheImages(List<PlaceItemModel> items) {
//     log('_+_ $items');
//     for (var item in items) {
//       if (!state.containsKey(item.id.toString())) {
//         cacheImage(item.id.toString(), item.picture);
//       }
//     }
//   }

//   void cacheImage(String id, String base64Image) {
//     if (!state.containsKey(id)) {
//       final imageBytes = base64Decode(base64Image);
//       state = {...state, id: imageBytes};
//     }
//   }

//   Uint8List? getImage(String id) {
//     return state[id];
//   }
// }

// class ImageCacheNotifier extends Notifier<Map<String, Uint8List>> {
//   @override
//   Map<String, Uint8List> build() {
//     final allItems = ref.watch(locationProvider).asData?.value ?? [];

//     log('>>> $allItems');
//     for (var item in allItems) {
//       if (!state.containsKey(item.id.toString())) {
//         cacheImage(item.id.toString(), item.picture);
//       }
//     }

//     return {};
//   }

//   void cacheImage(String id, String base64Image) {
//     if (!state.containsKey(id)) {
//       final imageBytes = base64Decode(base64Image);
//       state = {...state, id: imageBytes};
//     }
//   }

//   Uint8List? getImage(String id) {
//     return state[id];
//   }
// }

// final imageCacheProvider =
//     NotifierProvider<ImageCacheNotifier, Map<String, Uint8List>>(
//         ImageCacheNotifier.new);

class ImageCacheNotifier extends StateNotifier<Map<String, Uint8List>> {
  ImageCacheNotifier() : super({});

  Future<void> cacheImage(String id, String base64Image) async {
    if (!state.containsKey(id)) {
      final imageBytes = await decodeBase64Image(base64Image);
      state = {...state, id: imageBytes};
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

Future<Uint8List> decodeBase64Image(String base64Image) async {
  return compute(base64Decode, base64Image);
}
