// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> fa_IR = {
  "settings": "تنظیمات",
  "language": "زبان",
  "theme": "تم",
  "map_settings": "تنظیمات نقشه",
  "export": "بک آپ گیری از اطلاعات",
  "import": "جایگزینی با فایل بک آپ",
  "light": "روشن",
  "dark": "تاریک",
  "auto": "خودکار",
  "google_map": "گوگل نقشه"
};
static const Map<String,dynamic> en_US = {
  "settings": "Settings",
  "language": "Language",
  "theme": "Theme",
  "map_settings": "Map Settings",
  "export": "Export Data",
  "import": "Import Data",
  "light": "Light",
  "dark": "Dark",
  "auto": "Auto",
  "google_map": "Google Map"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"fa_IR": fa_IR, "en_US": en_US};
}
