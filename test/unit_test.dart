import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spidey_tracker/core/services/theme_storage_service.dart';
import 'package:spidey_tracker/core/theme/cubit/theme_cubit.dart';
import 'package:spidey_tracker/features/radar_map/data/repositories/radar_map_repository_impl.dart';
import 'package:spidey_tracker/features/radar_map/domain/entities/spidey_sighting.dart';
import 'package:spidey_tracker/features/radar_map/presentation/cubit/radar_map_cubit.dart';
import 'package:spidey_tracker/features/radar_map/presentation/cubit/radar_map_state.dart';
import 'package:spidey_tracker/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:spidey_tracker/features/splash/presentation/cubit/splash_state.dart';
import 'package:spidey_tracker/features/tracker/data/repositories/tracker_repository_impl.dart';
import 'package:spidey_tracker/features/tracker/presentation/cubit/tracker_cubit.dart';
import 'package:spidey_tracker/features/tracker/presentation/cubit/tracker_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeStorageService & ThemeCubit Tests', () {
    test('Initial theme is light and toggling switches to dark and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storage = ThemeStorageServiceImpl(prefs);

      final cubit = ThemeCubit(storageService: storage);
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      expect(cubit.state.isDarkMode, isFalse);

      cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      expect(cubit.state.isDarkMode, isTrue);

      final savedMode = await storage.getSavedThemeMode();
      expect(savedMode, equals(ThemeMode.dark));

      cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      final savedMode2 = await storage.getSavedThemeMode();
      expect(savedMode2, equals(ThemeMode.light));
    });
  });

  group('SplashCubit Tests', () {
    test('Initial state is SplashInitial', () {
      final cubit = SplashCubit();
      expect(cubit.state, equals(const SplashInitial()));
      cubit.close();
    });
  });

  group('TrackerCubit Tests', () {
    late TrackerCubit cubit;

    setUp(() {
      cubit = TrackerCubit(repository: TrackerRepositoryImpl());
    });

    tearDown(() {
      cubit.close();
    });

    test('Initial state has active patrol and 92% web fluid', () {
      expect(cubit.state.patrolStatus, equals(PatrolStatus.active));
      expect(cubit.state.webFluidPercentage, equals(0.92));
    });

    test('Toggling patrol changes status', () {
      cubit.togglePatrol();
      expect(cubit.state.patrolStatus, equals(PatrolStatus.standby));
      expect(cubit.state.isPatrolActive, isFalse);

      cubit.togglePatrol();
      expect(cubit.state.patrolStatus, equals(PatrolStatus.active));
      expect(cubit.state.isPatrolActive, isTrue);
    });

    test('Shooting web reduces fluid level and reload restores to 100%', () {
      final initialFluid = cubit.state.webFluidPercentage;
      cubit.shootWeb();
      expect(cubit.state.webFluidPercentage, lessThan(initialFluid));

      cubit.reloadWebCartridge();
      expect(cubit.state.webFluidPercentage, equals(1.0));
    });

    test('Load initial data populates alerts', () async {
      await cubit.loadInitialData();
      expect(cubit.state.alerts.isNotEmpty, isTrue);
      expect(cubit.state.activeAlertsCount, greaterThan(0));
    });
  });

  group('RadarMapCubit Tests', () {
    late RadarMapCubit cubit;

    setUp(() {
      cubit = RadarMapCubit(repository: RadarMapRepositoryImpl());
    });

    tearDown(() {
      cubit.close();
    });

    test('Initial state is empty sightings and district camera level', () {
      expect(cubit.state.sightings, isEmpty);
      expect(cubit.state.cameraLevel, equals(CameraLevel.district));
    });

    test('loadInitialData populates sightings across NYC and global hubs', () async {
      await cubit.loadInitialData();
      expect(cubit.state.sightings.isNotEmpty, isTrue);
      expect(cubit.state.sightings.length, greaterThan(50));
    });

    test('Selecting and clearing a sighting updates state correctly', () {
      final sample = SpideySighting(
        id: 'TEST-1',
        title: 'Test Sighting',
        district: 'Queens',
        coordinates: const LatLng(40.7, -73.9),
        timestamp: '1m ago',
        type: SightingType.webSlinging,
        reportNotes: 'Notes',
      );

      cubit.selectSighting(sample);
      expect(cubit.state.selectedSighting, equals(sample));

      cubit.clearSelectedSighting();
      expect(cubit.state.selectedSighting, isNull);
    });
  });
}
