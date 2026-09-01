import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

abstract final class AppTheme {
  // Light Theme (Vibrant Sky Blue Spidey Brand New Day)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primarySkyBlue,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primarySkyBlue,
        secondary: AppColors.spideyRed,
        tertiary: AppColors.badgeCream,
        surface: AppColors.lightSurface,
        onPrimary: AppColors.pixelBlack,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryLight,
        outline: AppColors.lightBorder,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: AppColors.pixelBlack,
            width: 2,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1.5,
      ),
    );
  }

  // Dark Theme (Comic Night Patrol HUD)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primarySkyBlue,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primarySkyBlue,
        secondary: AppColors.spideyRed,
        tertiary: AppColors.badgeCreamDark,
        surface: AppColors.darkSurface,
        onPrimary: AppColors.pixelBlack,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryDark,
        outline: AppColors.darkBorder,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: AppColors.darkBorder,
            width: 1.5,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1.5,
      ),
    );
  }
}
