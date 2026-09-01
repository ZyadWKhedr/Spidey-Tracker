import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/spidey_sighting.dart';

enum CameraLevel { street, district, country, world }

final class RadarMapState extends Equatable {
  final List<SpideySighting> sightings;
  final Set<Marker> markers;
  final Set<ClusterManager> clusterManagers;
  final LatLng? userLocation;
  final SpideySighting? selectedSighting;
  final bool isLoadingLocation;
  final bool isScanning;
  final CameraLevel cameraLevel;
  final String? errorMessage;

  const RadarMapState({
    this.sightings = const [],
    this.markers = const {},
    this.clusterManagers = const {},
    this.userLocation,
    this.selectedSighting,
    this.isLoadingLocation = false,
    this.isScanning = false,
    this.cameraLevel = CameraLevel.district,
    this.errorMessage,
  });

  RadarMapState copyWith({
    List<SpideySighting>? sightings,
    Set<Marker>? markers,
    Set<ClusterManager>? clusterManagers,
    LatLng? userLocation,
    SpideySighting? selectedSighting,
    bool clearSelectedSighting = false,
    bool? isLoadingLocation,
    bool? isScanning,
    CameraLevel? cameraLevel,
    String? errorMessage,
  }) {
    return RadarMapState(
      sightings: sightings ?? this.sightings,
      markers: markers ?? this.markers,
      clusterManagers: clusterManagers ?? this.clusterManagers,
      userLocation: userLocation ?? this.userLocation,
      selectedSighting: clearSelectedSighting
          ? null
          : (selectedSighting ?? this.selectedSighting),
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      isScanning: isScanning ?? this.isScanning,
      cameraLevel: cameraLevel ?? this.cameraLevel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        sightings,
        markers,
        clusterManagers,
        userLocation,
        selectedSighting,
        isLoadingLocation,
        isScanning,
        cameraLevel,
        errorMessage,
      ];
}
