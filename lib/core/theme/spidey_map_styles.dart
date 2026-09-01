abstract final class SpideyMapTileProviders {
  // 1. OpenFreeMap Dark / Positron (No API Key Required, Fast, High Quality)
  static const String openFreeMapDarkUrl =
      'https://tiles.openfreemap.org/styles/dark/{z}/{x}/{y}.png';

  // 2. OpenFreeMap Positron / Light Style
  static const String openFreeMapLightUrl =
      'https://tiles.openfreemap.org/styles/positron/{z}/{x}/{y}.png';

  // 3. Fallback OpenStreetMap Standard
  static const String openStreetMapUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}
