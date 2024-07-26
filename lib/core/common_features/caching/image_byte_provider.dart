import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base64_dto.dart';
import 'image_caching_notifier.dart';

final imageByteProvider =
    FutureProvider.family<Uint8List?, Base64DTO>((ref, Base64DTO params) async {
  final imageCacheNotifierN = ref.read(imageCacheProvider.notifier);
  final imageCacheNotifier = ref.read(imageCacheProvider);

  if (!imageCacheNotifier.containsKey(params.id)) {
    await imageCacheNotifierN.cacheImage(params.id, params.source);
  }

  return imageCacheNotifierN.getImage(params.id);
});
