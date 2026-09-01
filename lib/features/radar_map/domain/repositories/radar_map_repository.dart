import '../entities/spidey_sighting.dart';

abstract interface class RadarMapRepository {
  Future<List<SpideySighting>> getSightings();
}
