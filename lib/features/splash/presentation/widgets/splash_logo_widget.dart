import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppDimensions.logoSizeLarge + 16,
        height: AppDimensions.logoSizeLarge + 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl + 8),
          border: Border.all(
            color: AppColors.pixelBlack,
            width: 3.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pixelBlack.withValues(alpha: 0.25),
              offset: const Offset(0, 6),
              blurRadius: 12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl + 4),
          child: Image.asset(
            AppAssets.spideyAppIcon,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none, // Preserve crisp pixel art
          ),
        ),
      ),
    );
  }
}
