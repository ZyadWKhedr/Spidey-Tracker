import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

abstract final class AppTextStyles {
  // Title & Headline (Comic / HUD feel)
  static TextStyle headlineLarge(BuildContext context) {
    return GoogleFonts.chakraPetch(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle headlineMedium(BuildContext context) {
    return GoogleFonts.chakraPetch(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle headlineSmall(BuildContext context) {
    return GoogleFonts.chakraPetch(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  // Telemetry & Badge Font (Digital / Radar HUD vibe)
  static TextStyle telemetry(Color color) {
    return GoogleFonts.shareTechMono(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
      color: color,
    );
  }

  // Body & Content (Clear, modern UI reading)
  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
    );
  }

  // Pixel/Game Tag Font
  static TextStyle pixelBadge = GoogleFonts.vt323(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    color: AppColors.pixelBlack,
  );
}
