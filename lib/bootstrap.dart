import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_bloc_observer.dart';
import 'core/services/theme_storage_service.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function(
    ThemeStorageService themeStorageService,
    ThemeMode initialThemeMode,
  ) builder,
) async {
  FlutterError.onError = (details) {
    developer.log(
      details.exceptionAsString(),
      name: 'FLUTTER_ERROR',
      stackTrace: details.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeStorageService = ThemeStorageServiceImpl(prefs);
  final initialThemeMode = await themeStorageService.getSavedThemeMode();

  runApp(await builder(themeStorageService, initialThemeMode));
}
