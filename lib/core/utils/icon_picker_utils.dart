import 'dart:convert';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconPickerUtils {
  static IconPickerIcon? iconPickerDeserializer(String iconString) {
    final icon = deserializeIcon(
      Map<String, dynamic>.from(jsonDecode(iconString)),
    );

    return icon;
  }

  static String iconPickerSerializer(IconPickerIcon iconData) {
    final iconToString = jsonEncode(serializeIcon(iconData));
    return iconToString;
  }
}
