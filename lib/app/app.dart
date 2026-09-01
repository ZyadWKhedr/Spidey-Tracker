import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_strings.dart';
import '../core/routes/app_router.dart';
import '../core/services/theme_storage_service.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/cubit/theme_cubit.dart';
import '../core/theme/cubit/theme_state.dart';

class SpideyTrackerApp extends StatelessWidget {
  final ThemeStorageService? themeStorageService;
  final ThemeMode initialThemeMode;

  const SpideyTrackerApp({
    super.key,
    this.themeStorageService,
    this.initialThemeMode = ThemeMode.light,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(
        storageService: themeStorageService,
        initialMode: initialThemeMode,
      ),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
