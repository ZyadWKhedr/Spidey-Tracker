import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';
import '../widgets/cinematic_camera_controls.dart';
import '../widgets/radar_google_map_view.dart';
import '../widgets/radar_map_header.dart';
import '../widgets/sighting_bottom_sheet.dart';
import '../widgets/user_location_button.dart';

class RadarMapPage extends StatelessWidget {
  const RadarMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RadarMapCubit, RadarMapState>(
        builder: (context, state) {
          return Stack(
            children: [
              // 1. Full-screen OpenStreetMap Radar View with Dark Theme
              const RadarGoogleMapView(),

              // 2. Top Header HUD with Back Button & Count (No overflow)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: RadarMapHeader(sightingsCount: state.sightings.length),
              ),

              // 3. Camera Level Controls positioned safely below the header
              const Positioned(
                top: 100,
                right: AppDimensions.p12,
                child: CinematicCameraControls(),
              ),

              // 4. User GPS Location Target Button
              const Positioned(
                bottom: 110,
                right: AppDimensions.p16,
                child: UserLocationButton(),
              ),

              // 5. Selected Sighting Popup Sheet
              const SightingBottomSheet(),
            ],
          );
        },
      ),
    );
  }
}
