import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/utils/marker_generator.dart';
import '../../domain/entities/spidey_sighting.dart';
import '../../domain/repositories/radar_map_repository.dart';
import 'radar_map_state.dart';

class RadarMapCubit extends Cubit<RadarMapState> {
  final RadarMapRepository repository;
  GoogleMapController? mapController;

  static const ClusterManagerId _clusterId = ClusterManagerId('spidey_cluster');

  RadarMapCubit({required this.repository}) : super(const RadarMapState());

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(isScanning: true));
      final sightings = await repository.getSightings();
      final markerIcon = await MarkerGenerator.getSpideyMarker();

      // Create first-party cluster manager
      final clusterManager = ClusterManager(
        clusterManagerId: _clusterId,
        onClusterTap: (Cluster cluster) {
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(cluster.position, 14.5),
          );
        },
      );

      // Create clustered markers
      final markers = sightings.map((sighting) {
        return Marker(
          markerId: MarkerId(sighting.id),
          position: sighting.coordinates,
          clusterManagerId: _clusterId,
          icon: markerIcon,
          onTap: () => selectSighting(sighting),
        );
      }).toSet();

      emit(state.copyWith(
        sightings: sightings,
        markers: markers,
        clusterManagers: {clusterManager},
        isScanning: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isScanning: false,
        errorMessage: 'Failed to load Spidey sightings: $e',
      ));
    }
  }

  void selectSighting(SpideySighting sighting) {
    emit(state.copyWith(selectedSighting: sighting));
    mapController?.animateCamera(
      CameraUpdate.newLatLng(sighting.coordinates),
    );
  }

  void clearSelectedSighting() {
    emit(state.copyWith(clearSelectedSighting: true));
  }

  Future<void> requestUserLocation() async {
    emit(state.copyWith(isLoadingLocation: true));
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(
          isLoadingLocation: false,
          errorMessage: 'Location services are disabled on device.',
        ));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(
            isLoadingLocation: false,
            errorMessage: 'Location permission was denied.',
          ));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(
          isLoadingLocation: false,
          errorMessage: 'Location permissions are permanently denied.',
        ));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final userLatLng = LatLng(position.latitude, position.longitude);
      emit(state.copyWith(
        userLocation: userLatLng,
        isLoadingLocation: false,
      ));

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: userLatLng, zoom: 16.0, tilt: 35),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoadingLocation: false,
        errorMessage: 'Unable to acquire GPS fix: $e',
      ));
    }
  }

  Future<void> animateToLevel(CameraLevel level) async {
    emit(state.copyWith(cameraLevel: level));
    final controller = mapController;
    if (controller == null) return;

    CameraPosition targetPosition;
    switch (level) {
      case CameraLevel.street:
        targetPosition = const CameraPosition(
          target: LatLng(40.7580, -73.9855), // Times Square / Midtown
          zoom: 17.5,
          tilt: 50.0,
          bearing: 30.0,
        );
      case CameraLevel.district:
        targetPosition = const CameraPosition(
          target: LatLng(40.7350, -73.9400), // NYC / Queens Core
          zoom: 12.8,
          tilt: 20.0,
          bearing: 0.0,
        );
      case CameraLevel.country:
        targetPosition = const CameraPosition(
          target: LatLng(39.8283, -98.5795), // United States
          zoom: 4.8,
          tilt: 0.0,
        );
      case CameraLevel.world:
        targetPosition = const CameraPosition(
          target: LatLng(25.0, 10.0), // Globe View
          zoom: 2.0,
          tilt: 0.0,
        );
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(targetPosition),
    );
  }

  /// Dramatic Spider-Sense cinematic zoom from World -> Country -> District -> Street
  Future<void> performDramaticSpiderSenseZoom() async {
    final controller = mapController;
    if (controller == null) return;

    emit(state.copyWith(isScanning: true));

    // Step 1: Fly out to Orbit / World
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(25.0, -40.0),
          zoom: 2.0,
          tilt: 0,
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 900));

    // Step 2: Swoop to East Coast / Country
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(40.0, -75.0),
          zoom: 6.5,
          tilt: 15.0,
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 800));

    // Step 3: Dive into NYC / Queens District
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(40.7484, -73.9857),
          zoom: 13.5,
          tilt: 35.0,
          bearing: 45.0,
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 700));

    // Step 4: Slam down to Street Level with dramatic tilt
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(40.7580, -73.9855),
          zoom: 17.5,
          tilt: 60.0,
          bearing: 65.0,
        ),
      ),
    );

    emit(state.copyWith(
      isScanning: false,
      cameraLevel: CameraLevel.street,
    ));
  }
}
