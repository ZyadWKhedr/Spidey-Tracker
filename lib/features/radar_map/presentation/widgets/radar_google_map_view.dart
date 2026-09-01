import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/spidey_map_styles.dart';
import '../../domain/entities/spidey_sighting.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class RadarGoogleMapView extends StatefulWidget {
  const RadarGoogleMapView({super.key});

  @override
  State<RadarGoogleMapView> createState() => _RadarGoogleMapViewState();
}

class _RadarGoogleMapViewState extends State<RadarGoogleMapView> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      builder: (context, state) {
        final cubit = context.read<RadarMapCubit>();

        // Build individual Spidey Markers
        final markers = state.sightings.map((sighting) {
          return Marker(
            point: sighting.coordinates,
            width: 48,
            height: 48,
            child: GestureDetector(
              onTap: () => cubit.selectSighting(sighting),
              child: _SpideyMapMarkerWidget(sighting: sighting),
            ),
          );
        }).toList();

        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(40.7350, -73.9400), // Queens / NYC Core
            initialZoom: 12.8,
            minZoom: 2.0,
            maxZoom: 18.5,
            onMapReady: () {
              cubit.setMapController(_mapController);
            },
            onTap: (_, _) {
              cubit.clearSelectedSighting();
            },
          ),
          children: [
            // Dark Matter Retro Spider-Man OpenStreetMap Tile Layer
            TileLayer(
              urlTemplate: SpideyMapTileProviders.darkMatterUrl,
              subdomains: SpideyMapTileProviders.darkMatterSubdomains,
              userAgentPackageName: 'com.example.spidey_tracker',
              maxZoom: 19,
            ),

            // User GPS Location Pulse Marker Layer
            if (state.userLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: state.userLocation!,
                    width: 32,
                    height: 32,
                    child: _UserGpsMarkerWidget(),
                  ),
                ],
              ),

            // Animated Marker Clustering Layer for Hundreds of Sightings
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 50,
                size: const Size(54, 54),
                markers: markers,
                builder: (context, clusterMarkers) {
                  return _ClusterMarkerWidget(count: clusterMarkers.length);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SpideyMapMarkerWidget extends StatelessWidget {
  final SpideySighting sighting;

  const _SpideyMapMarkerWidget({required this.sighting});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.badgeCream,
        border: Border.all(
          color: AppColors.pixelBlack,
          width: 2.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.pixelBlack,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Image.asset(
        AppAssets.spideyIcon,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}

class _ClusterMarkerWidget extends StatelessWidget {
  final int count;

  const _ClusterMarkerWidget({required this.count});

  @override
  Widget build(BuildContext context) {
    final isHigh = count > 20;
    final isMid = count > 8;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHigh
            ? AppColors.spideyRed
            : (isMid ? AppColors.alertOrange : AppColors.primarySkyBlue),
        border: Border.all(
          color: AppColors.pixelBlack,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: (isHigh ? AppColors.spideyRed : AppColors.primarySkyBlue)
                .withValues(alpha: 0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
          const BoxShadow(
            color: AppColors.pixelBlack,
            offset: Offset(2, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          count > 99 ? '99+' : '$count',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppColors.pixelBlack,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class _UserGpsMarkerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primarySkyBlue,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySkyBlue.withValues(alpha: 0.8),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.navigation, size: 14, color: AppColors.pixelBlack),
      ),
    );
  }
}
