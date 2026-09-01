import 'dart:ui';

abstract final class SpideyMapTileProviders {
  // Official Public OpenStreetMap Tile Server
  static const String openStreetMapUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // Dark Matrix Color Filter tailored to Spidey Tracker Dark Night HUD
  // Translates light OSM tiles into dark slate blue & glowing cyan/red roads
  static const ColorFilter darkSpideyRadarFilter = ColorFilter.matrix(<double>[
    -0.80, 0, 0, 0, 240, // Red Channel Inversion & Night Tint
    0, -0.80, 0, 0, 245, // Green Channel
    0, 0, -0.75, 0, 255, // Blue Channel (Deep Sky Blue Glow)
    0, 0, 0, 1.0, 0,     // Alpha
  ]);
}
