import 'package:latlong2/latlong.dart';
import '../../domain/entities/spidey_sighting.dart';

class SpideySightingModel extends SpideySighting {
  const SpideySightingModel({
    required super.id,
    required super.title,
    required super.district,
    required super.coordinates,
    required super.timestamp,
    required super.type,
    required super.reportNotes,
    super.witnessCount,
  });

  factory SpideySightingModel.fromJson(Map<String, dynamic> json) {
    return SpideySightingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      district: json['district'] as String,
      coordinates: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
      timestamp: json['timestamp'] as String,
      type: _parseType(json['type'] as String?),
      reportNotes: json['reportNotes'] as String,
      witnessCount: json['witnessCount'] as int? ?? 1,
    );
  }

  static SightingType _parseType(String? type) {
    switch (type?.toLowerCase()) {
      case 'villainbattle':
        return SightingType.villainBattle;
      case 'policeassistance':
        return SightingType.policeAssistance;
      case 'catrescue':
        return SightingType.catRescue;
      case 'photoop':
        return SightingType.photoOp;
      case 'webslinging':
      default:
        return SightingType.webSlinging;
    }
  }
}
