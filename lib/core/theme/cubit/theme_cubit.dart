import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/theme_storage_service.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeStorageService? storageService;

  ThemeCubit({
    this.storageService,
    ThemeMode initialMode = ThemeMode.light,
  }) : super(ThemeState(themeMode: initialMode));

  void toggleTheme() {
    final nextMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextMode));
    storageService?.saveThemeMode(nextMode);
  }

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    storageService?.saveThemeMode(mode);
  }
}
