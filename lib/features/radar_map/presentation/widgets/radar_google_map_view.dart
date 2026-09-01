import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/theme/spidey_map_styles.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class RadarGoogleMapView extends StatelessWidget {
  const RadarGoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      buildWhen: (prev, current) =>
          prev.markers != current.markers ||
          prev.clusterManagers != current.clusterManagers ||
          prev.userLocation != current.userLocation,
      builder: (context, state) {
        final cubit = context.read<RadarMapCubit>();

        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(40.7350, -73.9400), // NYC Queens Core
            zoom: 12.8,
            tilt: 20.0,
          ),
          style: SpideyMapStyles.darkRetroSpiderMan,
          markers: state.markers,
          clusterManagers: state.clusterManagers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            cubit.setMapController(controller);
          },
          onTap: (_) {
            cubit.clearSelectedSighting();
          },
        );
      },
    );
  }
}
