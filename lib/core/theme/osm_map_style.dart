class OsmMapStyle {
  // flutter_map_styles.dart
  static const standardTileLayer =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const darkTileLayer =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
  static const silverTileLayer =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';
  static const nightTileLayer =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';

  static final Map<String, String> mapStyles = {
    'standard': standardTileLayer,
    'dark': darkTileLayer,
    'silver': silverTileLayer,
    'night': nightTileLayer,
  };
}
