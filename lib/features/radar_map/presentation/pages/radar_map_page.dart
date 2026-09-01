import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../data/repositories/radar_map_repository_impl.dart';
import '../cubit/radar_map_cubit.dart';
import '../widgets/cinematic_camera_controls.dart';
import '../widgets/radar_google_map_view.dart';
import '../widgets/radar_map_header.dart';
import '../widgets/sighting_bottom_sheet.dart';
import '../widgets/user_location_button.dart';

class RadarMapPage extends StatelessWidget {
  const RadarMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    return BlocProvider(
      create: (context) => RadarMapCubit(
        repository: RadarMapRepositoryImpl(),
      )
        ..setMapController(mapController)
        ..loadInitialData(),
      child: const RadarMapView(),
    );
  }
}

class RadarMapView extends StatelessWidget {
  const RadarMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          // 1. Full-screen OpenStreetMap Radar View with Dark Matter Styling
          RadarGoogleMapView(),

          // 2. Top Header HUD with Back Button & Count
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: RadarMapHeader(),
          ),

          // 3. Cinematic Camera Controls (Street -> District -> Country -> World)
          Positioned(
            top: 80,
            right: AppDimensions.p16,
            child: CinematicCameraControls(),
          ),

          // 4. User GPS Location Target Button
          Positioned(
            bottom: 120,
            right: AppDimensions.p16,
            child: UserLocationButton(),
          ),

          // 5. Selected Sighting Popup Sheet
          SightingBottomSheet(),
        ],
      ),
    );
  }
}
