import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spidey_tracker/core/theme/cubit/theme_cubit.dart';
import 'package:spidey_tracker/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:spidey_tracker/features/splash/presentation/cubit/splash_state.dart';
import 'package:spidey_tracker/features/tracker/data/repositories/tracker_repository_impl.dart';
import 'package:spidey_tracker/features/tracker/presentation/cubit/tracker_cubit.dart';
import 'package:spidey_tracker/features/tracker/presentation/cubit/tracker_state.dart';

void main() {
  group('ThemeCubit Tests', () {
    test('Initial theme is light and toggling switches to dark', () {
      final cubit = ThemeCubit();
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      expect(cubit.state.isDarkMode, isFalse);

      cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      expect(cubit.state.isDarkMode, isTrue);

      cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.light));
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
}
