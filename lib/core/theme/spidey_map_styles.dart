abstract final class SpideyMapTileProviders {
  // Dark CartoDB Matter (Retro Dark Comic Spider-Man Radar Style)
  static const String darkMatterUrl =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
  static const List<String> darkMatterSubdomains = ['a', 'b', 'c', 'd'];

  // Standard OpenStreetMap Fallback
  static const String openStreetMapUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}
