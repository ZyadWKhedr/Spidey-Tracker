import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/spidey_sighting.dart';
import '../../domain/repositories/radar_map_repository.dart';
import 'radar_map_state.dart';

class RadarMapCubit extends Cubit<RadarMapState> {
  final RadarMapRepository repository;
  MapController? mapController;

  RadarMapCubit({required this.repository}) : super(const RadarMapState());

  void setMapController(MapController controller) {
    mapController = controller;
  }

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(isScanning: true));
      final sightings = await repository.getSightings();
      emit(state.copyWith(
        sightings: sightings,
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
    mapController?.move(sighting.coordinates, 16.0);
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

      mapController?.move(userLatLng, 16.0);
    } catch (e) {
      emit(state.copyWith(
        isLoadingLocation: false,
        errorMessage: 'Unable to acquire GPS fix: $e',
      ));
    }
  }

  void animateToLevel(CameraLevel level) {
    emit(state.copyWith(cameraLevel: level));
    final controller = mapController;
    if (controller == null) return;

    LatLng target;
    double zoom;
    switch (level) {
      case CameraLevel.street:
        target = const LatLng(40.7580, -73.9855); // Times Square / Midtown
        zoom = 17.0;
      case CameraLevel.district:
        target = const LatLng(40.7350, -73.9400); // Queens / NYC core
        zoom = 13.0;
      case CameraLevel.country:
        target = const LatLng(39.8283, -98.5795); // USA
        zoom = 5.0;
      case CameraLevel.world:
        target = const LatLng(25.0, 10.0); // Global
        zoom = 2.5;
    }

    controller.move(target, zoom);
  }

  /// Dramatic Spider-Sense multi-stage cinematic zoom
  Future<void> performDramaticSpiderSenseZoom() async {
    final controller = mapController;
    if (controller == null) return;

    emit(state.copyWith(isScanning: true));

    // Step 1: Fly to Global Orbit
    controller.move(const LatLng(25.0, -40.0), 2.5);
    await Future.delayed(const Duration(milliseconds: 700));

    // Step 2: Swoop to Country
    controller.move(const LatLng(40.0, -75.0), 6.5);
    await Future.delayed(const Duration(milliseconds: 700));

    // Step 3: Dive to NYC / Queens District
    controller.move(const LatLng(40.7484, -73.9857), 13.5);
    await Future.delayed(const Duration(milliseconds: 600));

    // Step 4: Slam into Street Level
    controller.move(const LatLng(40.7580, -73.9855), 17.2);

    emit(state.copyWith(
      isScanning: false,
      cameraLevel: CameraLevel.street,
    ));
  }
}
