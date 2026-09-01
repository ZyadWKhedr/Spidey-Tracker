import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum SightingType { webSlinging, villainBattle, policeAssistance, catRescue, photoOp }

class SpideySighting extends Equatable {
  final String id;
  final String title;
  final String district;
  final LatLng coordinates;
  final String timestamp;
  final SightingType type;
  final String reportNotes;
  final int witnessCount;

  const SpideySighting({
    required this.id,
    required this.title,
    required this.district,
    required this.coordinates,
    required this.timestamp,
    required this.type,
    required this.reportNotes,
    this.witnessCount = 1,
  });

  LatLng get location => coordinates;

  @override
  List<Object?> get props => [
        id,
        title,
        district,
        coordinates.latitude,
        coordinates.longitude,
        timestamp,
        type,
        reportNotes,
        witnessCount,
      ];
}
