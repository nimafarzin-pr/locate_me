import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconPickerUtils {
  static IconData? iconPickerDeserializer(String iconString) {
    final icon = deserializeIcon(
      Map<String, dynamic>.from(jsonDecode(iconString)),
      iconPack: IconPack.allMaterial,
    );

    return icon;
  }

  static String iconPickerSerializer(IconData iconData) {
    final iconToString =
        jsonEncode(serializeIcon(iconData, iconPack: IconPack.allMaterial));
    return iconToString;
  }
}
