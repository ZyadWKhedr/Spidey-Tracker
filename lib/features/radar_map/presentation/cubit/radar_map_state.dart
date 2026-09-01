import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/spidey_sighting.dart';

enum CameraLevel { street, district, country, world }

final class RadarMapState extends Equatable {
  final List<SpideySighting> sightings;
  final LatLng? userLocation;
  final SpideySighting? selectedSighting;
  final bool isLoadingLocation;
  final bool isScanning;
  final CameraLevel cameraLevel;
  final String? errorMessage;

  const RadarMapState({
    this.sightings = const [],
    this.userLocation,
    this.selectedSighting,
    this.isLoadingLocation = false,
    this.isScanning = false,
    this.cameraLevel = CameraLevel.district,
    this.errorMessage,
  });

  RadarMapState copyWith({
    List<SpideySighting>? sightings,
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
        userLocation,
        selectedSighting,
        isLoadingLocation,
        isScanning,
        cameraLevel,
        errorMessage,
      ];
}
