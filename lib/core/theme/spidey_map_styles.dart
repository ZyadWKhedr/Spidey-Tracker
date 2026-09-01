abstract final class SpideyMapTileProviders {
  // Stadia Maps / Alidade Smooth Dark (Free OSM Dark Basemap)
  static const String darkMatterUrl =
      'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png';
  static const List<String> darkMatterSubdomains = [];

  // OpenStreetMap standard tile server
  static const String openStreetMapUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}
