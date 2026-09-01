import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import '../../domain/entities/spidey_sighting.dart';
import '../../domain/repositories/radar_map_repository.dart';
import '../models/spidey_sighting_model.dart';

class RadarMapRepositoryImpl implements RadarMapRepository {
  @override
  Future<List<SpideySighting>> getSightings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final List<SpideySightingModel> sightings = [];

    // 1. Core Iconic NYC Sightings
    final coreSpots = [
      (
        'Queensboro Bridge Web-Line',
        'Queens / Long Island City',
        const LatLng(40.7570, -73.9540),
        SightingType.webSlinging,
        'Spotted swinging from the upper cables heading westbound towards Manhattan.',
      ),
      (
        'Oscorp Tower Rooftop Intrusion',
        'Midtown Manhattan',
        const LatLng(40.7580, -73.9855),
        SightingType.villainBattle,
        'Heavy seismic vibrations reported on rooftop helipad. Green flare visible.',
      ),
      (
        'Daily Bugle Front Steps',
        'Flatiron District',
        const LatLng(40.7410, -73.9896),
        SightingType.photoOp,
        'Took selfies with tourists, then web-zipped up the building facade.',
      ),
      (
        'Brooklyn Bridge Ferry Rescue',
        'DUMBO / Brooklyn',
        const LatLng(40.7061, -73.9969),
        SightingType.policeAssistance,
        'Secured loose container barge drifting toward bridge pilings.',
      ),
      (
        'Aunt May’s Forest Hills Bodega',
        'Forest Hills, Queens',
        const LatLng(40.7180, -73.8448),
        SightingType.catRescue,
        'Safely brought down Calico kitten from roof gutter. Accepted free bagel.',
      ),
      (
        'Times Square Jumbotron Thwip',
        'Times Square',
        const LatLng(40.7589, -73.9851),
        SightingType.webSlinging,
        'High-velocity swing between digital billboards over 7th Avenue.',
      ),
      (
        'Empire State Spire Perch',
        'Midtown East',
        const LatLng(40.7484, -73.9857),
        SightingType.photoOp,
        'Perched on the lightning rod observing south Manhattan.',
      ),
      (
        'Grand Central Express Intercept',
        'Murray Hill',
        const LatLng(40.7527, -73.9772),
        SightingType.policeAssistance,
        'Halted runaway maintenance cart on terminal tracks.',
      ),
    ];

    int idCounter = 100;
    for (final spot in coreSpots) {
      idCounter++;
      sightings.add(
        SpideySightingModel(
          id: 'SPIDEY-$idCounter',
          title: spot.$1,
          district: spot.$2,
          coordinates: spot.$3,
          timestamp: '${math.Random().nextInt(45) + 2}m ago',
          type: spot.$4,
          reportNotes: spot.$5,
          witnessCount: math.Random().nextInt(20) + 3,
        ),
      );
    }

    // 2. Dense Cluster Generator across NYC Districts (over 80 sightings)
    final clusters = [
      ('Queens Central', 40.7282, -73.7949, 25),
      ('Manhattan Dense Hub', 40.7831, -73.9712, 35),
      ('Brooklyn Navy Yard', 40.6976, -73.9740, 20),
      ('Bronx Highbridge', 40.8400, -73.9300, 15),
      ('Staten Island Ferry Terminal', 40.6437, -74.0736, 10),
    ];

    final random = math.Random(42);
    for (final cluster in clusters) {
      final name = cluster.$1;
      final lat = cluster.$2;
      final lng = cluster.$3;
      final count = cluster.$4;

      for (int i = 0; i < count; i++) {
        idCounter++;
        final deltaLat = (random.nextDouble() - 0.5) * 0.04;
        final deltaLng = (random.nextDouble() - 0.5) * 0.04;
        sightings.add(
          SpideySightingModel(
            id: 'SPIDEY-$idCounter',
            title: 'Sighting near $name #${i + 1}',
            district: name,
            coordinates: LatLng(lat + deltaLat, lng + deltaLng),
            timestamp: '${random.nextInt(120) + 5}m ago',
            type: SightingType.values[random.nextInt(SightingType.values.length)],
            reportNotes: 'Spider-Signal active. Movement confirmed by neighborhood app witnesses.',
            witnessCount: random.nextInt(15) + 1,
          ),
        );
      }
    }

    // 3. Global Hotspot Sightings (Tokyo, London, Paris for Country / World Zooming)
    final globalSpots = [
      ('London Tower Bridge Swing', 'London, UK', const LatLng(51.5055, -0.0754)),
      ('Tokyo Shibuya Crossing Thwip', 'Tokyo, Japan', const LatLng(35.6595, 139.7004)),
      ('Paris Eiffel Tower Vault', 'Paris, France', const LatLng(48.8584, 2.2945)),
    ];

    for (final g in globalSpots) {
      idCounter++;
      sightings.add(
        SpideySightingModel(
          id: 'SPIDEY-$idCounter',
          title: g.$1,
          district: g.$2,
          coordinates: g.$3,
          timestamp: '3h ago',
          type: SightingType.webSlinging,
          reportNotes: 'Multiverse / International spider-suit confirmed on site.',
          witnessCount: 42,
        ),
      );
    }

    return sightings;
  }
}
